<p>
  <a href="https://www.aihero.dev/s/skills-newsletter">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skills-repo-dark_2x.png">
      <source media="(prefers-color-scheme: light)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png">
      <img alt="Skills" src="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png" width="369">
    </picture>
  </a>
</p>

# 面向真正工程师的技能

[![skills.sh](https://skills.sh/b/mattpocock/skills)](https://skills.sh/mattpocock/skills)

这是我每天用来做真正工程工作的智能体技能——而不是凭感觉写代码（vibe coding）。

开发真正的应用很难。GSD、BMAD、Spec-Kit 这类方法试图通过接管整个流程来帮你。但在这样做的同时，它们剥夺了你的控制权，也让流程中的 bug 难以解决。

这些技能被设计得小巧、易于改造、可组合。它们适用于任何模型。它们建立在数十年的工程经验之上。尽情去折腾它们。把它们变成你自己的。享受吧。

如果你想跟进这些技能的更新，以及我创建的任何新技能，可以加入我的 newsletter，与另外约 60,000 名开发者同行：

[订阅 Newsletter](https://www.aihero.dev/s/skills-newsletter)

## 快速开始（30 秒设置）

1. 运行 skills.sh 安装器：

```bash
npx skills@latest add mattpocock/skills
```

2. 挑选你想要的技能，以及你想把它们安装到哪些编码智能体上。**务必选中 `/setup-matt-pocock-skills`**。

3. 在你的智能体中运行 `/setup-matt-pocock-skills`。它会：
   - 询问你想使用哪个 issue 追踪器（GitHub、Linear 或本地文件）
   - 询问你在分诊工单时会打哪些标签（`/triage` 会用到标签）
   - 询问你想把我们创建的任何文档保存到哪里

4. 好了——你已经准备就绪。

## 这些技能为何存在

我构建这些技能，是为了修复我在 Claude Code、Codex 和其他编码智能体身上看到的常见失败模式。

### #1：智能体没做我想要的

> "No-one knows exactly what they want"
>
> David Thomas & Andrew Hunt, [The Pragmatic Programmer](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**问题所在**。软件开发中最常见的失败模式是错位。你以为开发者知道你想要什么。然后你看到他们构建出来的东西——你意识到他们根本没理解你。

在 AI 时代也是一样。你和智能体之间存在沟通鸿沟。修复它的办法是一场**拷问式会话**——让智能体针对你要构建的东西，向你提出详尽的问题。

**修复方法**是使用：

- [`/grill-me`](./skills/productivity/grill-me/SKILL.md) —— 用于非代码场景
- [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md) —— 与 [`/grill-me`](./skills/productivity/grill-me/SKILL.md) 相同，但增加了更多好东西（见下文）

这些是我最受欢迎的技能。它们帮助你在动手之前与智能体对齐，并深入思考你正在做的改动。每一次你想做改动时，都用它们。

### #2：智能体太啰嗦了

> With a ubiquitous language, conversations among developers and expressions of the code are all derived from the same domain model.
>
> Eric Evans, [Domain-Driven-Design](https://www.amazon.co.uk/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215)

**问题所在**：在项目伊始，开发者和他们为之构建软件的人（领域专家）通常说着不同的语言。

我在自己的智能体身上也感受到了同样的张力。智能体通常被丢进一个项目，被要求边做边搞懂行话。于是它们用 20 个词去表达 1 个词就够的意思。

**修复方法**是一套通用语言。这是一份帮助智能体解码项目中所用行话的文档。

<details>
<summary>
示例
</summary>

这是我 `course-video-manager` 仓库里的一个 [`CONTEXT.md`](https://github.com/mattpocock/course-video-manager/blob/076a5a7a182db0fe1e62971dd7a68bcadf010f1c/CONTEXT.md) 示例。哪一个更好读？

- **之前**："当课程某个章节里的一节课被'落实'（即在文件系统中获得一个位置）时会出现问题"
- **之后**："物化级联（materialization cascade）出现了问题"

这种简洁在一次又一次的会话中不断回报。

</details>

这已内建于 [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md)。它是一场拷问式会话，但同时帮你与 AI 建立通用语言，并在 ADR 中记录难以解释的决策。

很难解释这有多强大。它可能是本仓库中最酷的单个技巧。试一试，你就明白了。

> [!TIP]
> 通用语言除了减少啰嗦之外，还有许多其他好处：
>
> - **变量、函数和文件的命名保持一致**，都使用通用语言
> - 结果就是，**代码库对智能体更易于导航**
> - 智能体也**在思考上花更少的 token**，因为它能用上更简洁的语言

### #3：代码跑不起来

> "Always take small, deliberate steps. The rate of feedback is your speed limit. Never take on a task that's too big."
>
> David Thomas & Andrew Hunt, [The Pragmatic Programmer](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**问题所在**：假设你和智能体对要构建什么已经对齐。如果智能体_仍然_产出垃圾，会怎样？

是时候审视你的反馈回路了。如果对它产出的代码究竟如何运行没有反馈，智能体就是在盲飞。

**修复方法**：你需要一整套常规反馈回路：静态类型、浏览器访问以及自动化测试。

对于自动化测试，红-绿-重构回路至关重要。这就是智能体先写一个失败的测试，再让测试通过。这有助于给智能体提供稳定的反馈层次，从而产出好得多的代码。

我构建了一个 **[`/tdd`](./skills/engineering/tdd/SKILL.md) 技能**，你可以将它嵌入任何项目。它鼓励红-绿-重构，并给智能体大量指引，告诉它什么是好测试、什么是坏测试。

对于调试，我还构建了一个 **[`/diagnosing-bugs`](./skills/engineering/diagnosing-bugs/SKILL.md)** 技能，把最佳调试实践包装成一个简单的回路。

### #4：我们造出了一个大泥球

> "Invest in the design of the system _every day_."
>
> Kent Beck, [Extreme Programming Explained](https://www.amazon.co.uk/Extreme-Programming-Explained-Embrace-Change/dp/0321278658)

> "The best modules are deep. They allow a lot of functionality to be accessed through a simple interface."
>
> John Ousterhout, [A Philosophy Of Software Design](https://www.amazon.co.uk/Philosophy-Software-Design-2nd/dp/173210221X)

**问题所在**：大多数用智能体构建的应用都复杂且难以改动。因为智能体能极大加速编码，它们也加速了软件熵增。代码库以前所未有的速度变得更复杂。

**修复方法**是一种全新的 AI 驱动开发理念：在乎代码的设计。

这内建在这些技能的每一层：

- [`/to-prd`](./skills/engineering/to-prd/SKILL.md) 在创建 PRD 之前会盘问你正在触及哪些模块

而至关重要的是，[`/improve-codebase-architecture`](./skills/engineering/improve-codebase-architecture/SKILL.md) 帮助你抢救一个已经变成大泥球的代码库。我建议每隔几天就在你的代码库上运行一次。

### 小结

软件工程基本功比以往任何时候都更重要。这些技能是我尽最大努力，将这些基本功浓缩成可重复的实践，助你交付职业生涯中最好的应用。享受吧。

## 参考

这些技能沿一个轴划分——谁能调用它们。**用户调用（User-invoked）**的技能只有你输入时才能触及（例如 `/grill-me`）；它们的职责是编排。**模型调用（Model-invoked）**的技能可以由你调用，_或_由智能体在任务契合时自动触及；它们承载着可复用的纪律。用户调用的技能可以调用模型调用的技能，但绝不会调用另一个用户调用的技能。

### 工程（Engineering）

我每天用于代码工作的技能。

**用户调用**

- **[ask-matt](./skills/engineering/ask-matt/SKILL.md)** —— 询问哪个技能或流程适合你的处境。是本仓库中用户调用技能之上的路由器。
- **[grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md)** —— 拷问式会话，同时构建项目的领域模型，打磨术语并就地更新 `CONTEXT.md` 和 ADR。
- **[triage](./skills/engineering/triage/SKILL.md)** —— 让 issue 通过分诊角色的状态机流转。
- **[improve-codebase-architecture](./skills/engineering/improve-codebase-architecture/SKILL.md)** —— 扫描代码库寻找加深（deepening）机会，以可视化 HTML 报告呈现，然后就你挑选的那个进行拷问。
- **[setup-matt-pocock-skills](./skills/engineering/setup-matt-pocock-skills/SKILL.md)** —— 为工程技能配置本仓库（issue 追踪器、分诊标签、领域文档布局）。在使用其他工程技能之前，每个仓库运行一次。
- **[to-issues](./skills/engineering/to-issues/SKILL.md)** —— 用垂直切片把任何计划、规格或 PRD 拆成可独立认领的 issue。
- **[to-prd](./skills/engineering/to-prd/SKILL.md)** —— 把当前对话变成 PRD 并发布到 issue 追踪器。不做访谈——只是综合你已经讨论过的内容。

**模型调用**

- **[prototype](./skills/engineering/prototype/SKILL.md)** —— 构建一次性原型来回答一个设计问题——对状态/逻辑问题是可运行的终端应用，或者是从同一路由切换的若干个截然不同的 UI 变体。
- **[diagnosing-bugs](./skills/engineering/diagnosing-bugs/SKILL.md)** —— 针对疑难 bug 和性能回退的严谨诊断回路：复现 → 最小化 → 假设 → 埋点 → 修复 → 回归测试。
- **[tdd](./skills/engineering/tdd/SKILL.md)** —— 采用红-绿-重构回路的测试驱动开发。一次一个垂直切片地构建功能或修复 bug。
- **[domain-modeling](./skills/engineering/domain-modeling/SKILL.md)** —— 主动构建并打磨项目的领域模型——用术语表挑战词汇、用边缘案例场景做压力测试，并就地更新 `CONTEXT.md` 和 ADR。
- **[codebase-design](./skills/engineering/codebase-design/SKILL.md)** —— 用于设计深模块的共享纪律与词汇：在小接口后面藏大量行为，放置在干净的接缝处，可通过该接口测试。
- **[code-review](./skills/engineering/code-review/SKILL.md)** —— 针对自某个固定点以来 diff 的双轴审查：**标准**（是否遵循仓库的编码标准，外加 Fowler 坏味道基线？）与**规格**（是否忠实实现了源头的 issue/PRD？），作为并行子智能体运行，使二者互不污染。

### 生产力（Productivity）

通用的工作流工具，不特定于代码。

**用户调用**

- **[grill-me](./skills/productivity/grill-me/SKILL.md)** —— 就一个计划或设计被不停地访谈，直到决策树的每个分支都被解决。
- **[handoff](./skills/productivity/handoff/SKILL.md)** —— 把当前对话压缩成一份交接文档，让另一个智能体可以继续工作。
- **[teach](./skills/productivity/teach/SKILL.md)** —— 跨多个会话教会用户一项新技能或概念，把当前目录当作有状态的教学工作区。
- **[writing-great-skills](./skills/productivity/writing-great-skills/SKILL.md)** —— 写好和编辑好技能的参考：让技能变得可预测的词汇与原则。

**模型调用**

- **[grilling](./skills/productivity/grilling/SKILL.md)** —— 就一个计划或设计不停地访谈用户，直到决策树的每个分支都被解决。是 `grill-me` 和 `grill-with-docs` 背后可复用的回路。
