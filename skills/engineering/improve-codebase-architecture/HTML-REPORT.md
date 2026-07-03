# HTML 报告格式

架构评审被渲染为 OS 临时目录中一个自包含的单一 HTML 文件。Tailwind 和 Mermaid 都来自 CDN。Mermaid 能可靠地处理图状（graph-shaped）的图示；而手工搭建的 div 和内联 SVG 则用于处理更具编辑性的视觉呈现（质量图、剖面图）。把两者混用——不要事事都依赖 Mermaid，否则它会开始显得千篇一律。

## 脚手架

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Architecture review — {{repo name}}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="module">
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
      mermaid.initialize({ startOnLoad: true, theme: "neutral", securityLevel: "loose" });
    </script>
    <style>
      /* small custom layer for things Tailwind doesn't cover cleanly:
         dashed seam lines, hand-drawn-feeling arrow heads, etc. */
      .seam { stroke-dasharray: 4 4; }
      .leak { stroke: #dc2626; }
      .deep { background: linear-gradient(135deg, #0f172a, #1e293b); }
    </style>
  </head>
  <body class="bg-stone-50 text-slate-900 font-sans">
    <main class="max-w-5xl mx-auto px-6 py-12 space-y-12">
      <header>...</header>
      <section id="candidates" class="space-y-10">...</section>
      <section id="top-recommendation">...</section>
    </main>
  </body>
</html>
```

## 页眉

仓库名、日期，以及一个紧凑的图例：实心方框 = 模块（module），虚线 = 接缝（seam），红色箭头 = 泄漏（leakage），粗深色方框 = 深模块（deep module）。不要引言段落——直接进入候选项。

## 候选卡片

图示承担主要分量。文字稀疏、朴素，并且不加修饰地使用（来自 `/codebase-design` 技能的）术语表词汇。

每个候选项是一个 `<article>`：

- **标题**——简短，点明这次的深化（例如「合并 Order 接收流水线」）。
- **徽章行**——推荐强度（`Strong` = 翡翠绿，`Worth exploring` = 琥珀色，`Speculative` = 石板灰），外加一个标注依赖类别的标签（`in-process`、`local-substitutable`、`ports & adapters`、`mock`）。
- **文件**——等宽字体列表，`font-mono text-sm`。
- **前 / 后 图示**——核心所在。两列并排。见下方的模式。
- **问题**——一句话。哪里痛。
- **方案**——一句话。改变什么。
- **收益**——列表项，每条 ≤6 个词。例如「测试命中一个接口」「定价逻辑不再泄漏」「删除 4 个浅包装」。
- **ADR 提示框**（如适用）——琥珀色底框中的一行。

不要有成段的解释。如果图示需要一个段落才能被理解，就重画图示。

## 图示模式

选择适合该候选项的模式。把它们混用。不要让每个图示都长得一样——多样性是重点的一部分。

### Mermaid 图（处理依赖 / 调用流的主力）

当要表达的是「X 调用 Y 调用 Z，看看这一团乱麻」时，使用 Mermaid `flowchart` 或 `graph`。把它包在一张 Tailwind 风格的卡片里，这样它就不会显得像空降进来的。用 classDef 上色，把泄漏边设为红色、把深模块设为深色。序列图很适合表达「之前：6 次往返；之后：1 次」。

```html
<div class="rounded-lg border border-slate-200 bg-white p-4">
  <pre class="mermaid">
    flowchart LR
      A[OrderHandler] --> B[OrderValidator]
      B --> C[OrderRepo]
      C -.leak.-> D[PricingClient]
      classDef leak stroke:#dc2626,stroke-width:2px;
      class C,D leak
  </pre>
</div>
```

### 手工搭建的方框与箭头（当 Mermaid 的布局跟你对着干时）

模块用带边框和标签的 `<div>` 表示。箭头用内联 SVG 的 `<line>` 或 `<path>` 元素，绝对定位在一个相对定位的容器之上。当你想让「之后」的图示呈现为一个粗边框的深模块、内部灰化时，就用这个——Mermaid 渲染不出正确的分量感。

### 剖面图（适合分层的浅薄）

堆叠水平色带（`h-12 border-l-4`）来展示一次调用所穿过的各层。之前：6 个薄层，各自什么也没做。之后：1 个粗带，标注为合并后的职责。

### 质量图（适合「接口和实现一样宽」）

每个模块两个矩形——一个表示接口的表面积，一个表示实现。之前：接口矩形几乎和实现矩形一样高（浅）。之后：接口矩形很矮，实现矩形很高（深）。

### 调用图坍缩

之前：一棵函数调用树，渲染为嵌套的方框。之后：同一棵树坍缩成一个方框，如今变为内部的调用以淡化方式显示在其中。

## 样式指引

- 偏编辑风格，而非企业仪表盘风格。留白慷慨。标题可选用衬线体（`font-serif` 与 stone/slate 搭配效果好）。
- 用色克制：一个强调色（翡翠绿或靛蓝），外加红色表示泄漏、琥珀色表示警告。
- 图示保持约 320px 高，这样前/后能舒适地并排而无需滚动。
- 图示内部的模块标签用 `text-xs uppercase tracking-wider`——它们应读起来像示意图，而不是 UI。
- 唯一的脚本是 Tailwind CDN 和 Mermaid ESM 导入。除此之外报告是静态的——没有应用代码，除 Mermaid 自身的渲染外没有任何交互。

## 首选推荐区块

一张更大的卡片。候选项名称、一句话说明为什么、指向其卡片的锚点链接。仅此而已。

## 语气

朴实的英文、简洁——但架构上的名词和动词直接来自 `/codebase-design` 技能。简洁不是漂移的借口。

**精确使用：** module、interface、implementation、depth、deep、shallow、seam、adapter、leverage、locality。

**绝不替换：** component、service、unit（代替 module）· API、signature（代替 interface）· boundary（代替 seam）· layer、wrapper（在你指 module 时代替 module）。

**契合此风格的措辞：**

- 「Order intake 模块是浅的——接口几乎与实现相当。」
- 「Pricing 跨接缝泄漏。」
- 「深化：一个接口，一处可测。」
- 「两个适配器让接缝成立：生产用 HTTP，测试用内存实现。」

**收益列表项**用术语表的词汇来命名收益：*「locality：bug 集中在一个模块」*、*「leverage：一个接口，N 个调用点」*、*「接口收缩；实现吸收包装层」*。不要写*「更易维护」*或*「更干净的代码」*——那些词不在术语表里，配不上它们的位置。

不含糊其辞，不清嗓子，不写「值得一提的是……」。如果一句话能变成列表项，就把它变成列表项。如果一个列表项能删，就删掉。如果某个术语不在 `/codebase-design` 术语表里，在发明新词之前先去找一个在表里的。
