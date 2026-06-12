# HTML 报告格式

架构评审被渲染为操作系统临时目录中的一个自包含 HTML 文件。Tailwind 和 Mermaid 都来自 CDN。Mermaid 可靠地处理图状图表；手工编写的 div 和内联 SVG 处理更具编辑感的视觉元素（质量图、剖面图）。把两者混合使用——不要什么都靠 Mermaid，那会开始显得千篇一律。

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
      /* 给 Tailwind 不能干净覆盖的东西用的小型自定义层：
         虚线缝、手绘感的箭头、等等。 */
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

## 头部

仓库名、日期，以及一个紧凑的图例：实线框 = 模块，虚线 = 缝，红色箭头 = 泄漏，粗深色框 = 深模块。不要引言段落——直接进入候选项。

## 候选项卡片

图表承载主要分量。散文稀疏、朴素，不加修饰地使用术语表（[LANGUAGE.md](LANGUAGE.md)）中的术语。

每个候选项是一个 `<article>`：

- **Title（标题）** — 简短，命名这次深化（例如「坍缩 Order 接收管线」）。
- **Badge row（徽章行）** — 推荐强度（`Strong` = 翠绿，`Worth exploring` = 琥珀，`Speculative` = 石板灰），外加一个标注依赖类别的标签（`in-process`、`local-substitutable`、`ports & adapters`、`mock`）。
- **Files（文件）** — 等宽列表，`font-mono text-sm`。
- **Before / After diagram（前后对比图）** — 核心看点。两列并排。见下面的模式。
- **Problem（问题）** — 一句话。哪里疼。
- **Solution（方案）** — 一句话。改什么。
- **Wins（收益）** — 要点列表，每条 ≤6 个词。例如「测试只打一个接口」「定价逻辑不再泄漏」「删掉 4 个浅包装」。
- **ADR callout（ADR 标注）**（如适用）— 在一个琥珀色调框里一行。

不要成段的解释。如果一张图需要一段话才能被理解，那就重画这张图。

## 图表模式

挑选适合该候选项的模式。把它们混用。不要让每张图看起来都一样——多样性也是要点的一部分。

### Mermaid 图（处理依赖/调用流的主力）

当要点是「X 调 Y 调 Z，看这一团乱麻」时，用 Mermaid 的 `flowchart` 或 `graph`。把它包在一张 Tailwind 样式的卡片里，这样它就不会显得突兀。用 classDef 把泄漏的边染红、把深模块染暗。时序图很适合「之前：6 次往返；之后：1 次」。

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

### 手工编写的盒子与箭头（当 Mermaid 的布局跟你较劲时）

模块用带边框和标签的 `<div>`。箭头用绝对定位在相对容器之上的内联 SVG `<line>` 或 `<path>` 元素。当你想让「之后」的图感觉像是一个粗边框的深模块、内部被灰化时，就用这个——Mermaid 渲染不出那种分量感。

### 剖面图（适合分层的浅薄）

堆叠水平条带（`h-12 border-l-4`）来展示一次调用穿过的层。之前：6 个各自什么都不做的薄层。之后：1 个标注了被整合职责的粗条带。

### 质量图（适合「接口和实现一样宽」）

每个模块画两个矩形——一个表示接口表面积，一个表示实现。之前：接口矩形几乎和实现矩形一样高（浅）。之后：接口矩形矮，实现矩形高（深）。

### 调用图坍缩

之前：一棵函数调用树，渲染为嵌套的盒子。之后：同一棵树坍缩成一个盒子，现在变成内部的调用以淡化方式显示在盒子里面。

## 样式指南

- 偏编辑风，而非企业仪表盘风。慷慨的留白。标题可选衬线字体（`font-serif` 与 stone/slate 配合得很好）。
- 用色克制：一个强调色（翠绿或靛蓝）加上红色表泄漏、琥珀表警告。
- 把图表保持在约 320px 高，这样前后对比能舒适地并排而无需滚动。
- 图内的模块标签用 `text-xs uppercase tracking-wider`——它们应读起来像示意图，而非 UI。
- 唯一的脚本是 Tailwind CDN 和 Mermaid 的 ESM 导入。报告在其他方面是静态的——没有应用代码，除 Mermaid 自身的渲染外没有交互。

## 首要推荐小节

一张更大的卡片。候选项名称、一句话说明为什么、指向其卡片的锚链接。仅此而已。

## 语气

白话、简洁——但架构的名词和动词直接取自 [LANGUAGE.md](LANGUAGE.md)。简洁不是漂移的借口。

**精确使用：**module、interface、implementation、depth、deep、shallow、seam、adapter、leverage、locality。

**永不替换：**component、service、unit（替 module）· API、signature（替 interface）· boundary（替 seam）· layer、wrapper（在你指 module 时替 module）。

**契合这种风格的措辞：**

- 「Order 接收模块是浅的——接口几乎与实现匹配。」
- 「定价跨缝泄漏。」
- 「深化：一个接口，一处可测。」
- 「两个适配器证明了缝的正当性：生产里用 HTTP，测试里用内存。」

**Wins 要点**用术语表的词命名收益：*「局部性：缺陷集中在一个模块」*、*「杠杆：一个接口，N 个调用点」*、*「接口收缩；实现吸收了那些包装」*。不要写*「更易维护」*或*「更整洁的代码」*——那些词不在术语表里，配不上它们的位置。

不要含糊其辞，不要清嗓子式开场，不要「值得一提的是……」。如果一句话能变成一个要点，就让它变成要点。如果一个要点能删掉，就删掉。如果某个术语不在 [LANGUAGE.md](LANGUAGE.md) 里，在发明新词之前先去够一个在里面的。
