<p>
  <a href="https://www.aihero.dev/s/skills-newsletter">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skills-repo-dark_2x.png">
      <source media="(prefers-color-scheme: light)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png">
      <img alt="Skills" src="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png" width="369">
    </picture>
  </a>
</p>

# 为真正的工程师打造的技能

[![skills.sh](https://skills.sh/b/mattpocock/skills)](https://skills.sh/mattpocock/skills)

我每天用来做真正工程——而非 vibe coding——的代理技能。

开发真正的应用很难。GSD、BMAD、Spec-Kit 这类方法试图通过接管流程来帮忙。但这样做的同时，它们夺走了你的控制权，也让流程中的 bug 难以解决。

这些技能被设计得小巧、易于改造、可组合。它们适配任何模型。它们基于数十年的工程经验。尽管拿它们折腾。把它们变成你自己的。享受吧。

如果你想跟上这些技能的变化，以及我创建的任何新技能，可以加入我的通讯，与另外约 60,000 名开发者同行：

[订阅通讯](https://www.aihero.dev/s/skills-newsletter)

## 快速开始（30 秒设置）

1. 运行 skills.sh 安装器：

```bash
npx skills@latest add mattpocock/skills
```

2. 挑选你想要的技能，以及你想把它们安装到哪些编码代理上。**确保你选中了 `/setup-matt-pocock-skills`**。

3. 在你的代理里运行 `/setup-matt-pocock-skills`。它会：
   - 询问你想使用哪个问题跟踪器（GitHub、Linear，或本地文件）
   - 询问你在分诊工单时会应用哪些标签（`/triage` 会用到标签）
   - 询问你想把我们创建的任何文档保存到哪里

4. 好了——你可以开工了。

## 作为 Claude Code 插件安装

更想要一个无需手动维护的即插即用安装方式？这些技能也以原生 [Claude Code 插件](https://code.claude.com/docs/en/plugins)的形式发布。插件不是把可编辑的文件复制进你的仓库，而是把整套技能作为一个受管理的捆绑包安装，并在我发布新版本时更新——你是订阅，而非分叉。

在 Claude Code 内：

```
/plugin marketplace add mattpocock/skills
/plugin install mattpocock-skills@mattpocock
```

或者从你的 shell：

```bash
claude plugin marketplace add mattpocock/skills
claude plugin install mattpocock-skills@mattpocock
```

然后每个仓库运行一次 `/setup-matt-pocock-skills`，与上面的快速开始完全一样。

两种安装方式，两种理念：

- **[skills.sh](https://skills.sh/mattpocock/skills)** 把技能复制进你的项目，让你可以在上面折腾，把它们变成你自己的。
- **插件**把它们作为一个只读、始终最新的捆绑包保留，你不去编辑它——当你只想让我这套技能直接工作、并随它演进而跟进时最合适。

> 用 Codex 或别的代理？[skills.sh 安装器](https://skills.sh/mattpocock/skills)如今已经能把这些技能安装进 Codex 及其他符合 Agent-Skills 标准的框架。原生 Codex 插件在路线图上——见 [`.agents/adr/0002-ship-as-a-claude-code-plugin.md`](./.agents/adr/0002-ship-as-a-claude-code-plugin.md)。

## 这些技能为何存在

我构建这些技能，是为了修复我在 Claude Code、Codex 及其他编码代理身上看到的常见失败模式。

### #1：代理没做我想要的事

> "没有人确切知道自己想要什么"
>
> David Thomas & Andrew Hunt，[《程序员修炼之道》](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**问题**。软件开发中最常见的失败模式是错位。你以为开发者知道你想要什么。然后你看到他们构建出来的东西——你才意识到它根本没理解你。

在 AI 时代也是一样。你和代理之间有一道沟通鸿沟。对此的修复是一次**拷问会话（grilling session）**——让代理就你正在构建的东西向你提出详细的问题。

**修复**是使用：

- [`/grill-me`](./skills/productivity/grill-me/SKILL.md) - 用于非代码场景
- [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md) - 与 [`/grill-me`](./skills/productivity/grill-me/SKILL.md) 相同，但增加了更多好东西（见下文）

这些是我最受欢迎的技能。它们帮助你在开始之前与代理对齐，并深入思考你正在做的变更。每次你想做一个变更时都用它们。

### #2：代理太啰嗦了

> 有了通用语言，开发者之间的对话与代码的表达就都源自同一个领域模型。
>
> Eric Evans，[《领域驱动设计》](https://www.amazon.co.uk/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215)

**问题**：在一个项目的开端，开发者与他们为之构建软件的人（领域专家）通常讲着不同的语言。

我在自己的代理身上感受到了同样的张力。代理通常被丢进一个项目，被要求边做边搞懂那些行话。于是它们用 20 个词去说 1 个词就够的事。

**修复**是一门共享语言。它是一份帮助代理解码项目中所用行话的文档。

<details>
<summary>
示例
</summary>

这是一个来自我 `course-video-manager` 仓库的 [`CONTEXT.md`](https://github.com/mattpocock/course-video-manager/blob/076a5a7a182db0fe1e62971dd7a68bcadf010f1c/CONTEXT.md) 示例。哪一个更易读？

- **之前**："当一节课程某个章节里的 lesson 被变成'真实的'（即在文件系统中获得一个位置）时会有一个问题"
- **之后**："materialization cascade 有一个问题"

这种简洁在一次又一次的会话中持续获得回报。

</details>

这内建于 [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md)。它是一次拷问会话，但那会帮助你与 AI 构建一门共享语言，并把难以解释的决策记录进 ADR。

很难说清这有多强大。它可能是这个仓库里最酷的单项技法。试一试，你就明白了。

> [!TIP]
> 一门共享语言除了减少啰嗦之外还有许多别的好处：
>
> - **变量、函数和文件的命名保持一致**，使用共享语言
> - 由此，**代码库对代理而言更易于导航**
> - 代理还**在思考上花更少的 token**，因为它能用上一门更简洁的语言

### #3：代码不工作

> "永远迈出小而审慎的步子。反馈的速率就是你的速度上限。绝不接手一个太大的任务。"
>
> David Thomas & Andrew Hunt，[《程序员修炼之道》](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**问题**：假设你和代理在要构建什么上已经对齐了。当代理_仍然_产出垃圾时会发生什么？

是时候审视你的反馈循环了。没有关于它所产代码实际如何运行的反馈，代理就会盲飞。

**修复**：你需要那套常规的反馈循环：静态类型、浏览器访问，以及自动化测试。

对于自动化测试，红-绿-重构循环至关重要。这是指代理先写一个失败的测试，然后修好它。这帮助给代理一个一致水平的反馈，从而产出好得多的代码。

我构建了一个可以插进任何项目的 **[`/tdd`](./skills/engineering/tdd/SKILL.md) 技能**。它鼓励红-绿-重构，并给代理大量关于什么才是好测试和坏测试的指引。

对于调试，我还构建了一个 **[`/diagnosing-bugs`](./skills/engineering/diagnosing-bugs/SKILL.md)** 技能，它把最佳调试实践包裹进一个简单的循环。

### #4：我们建出了一团烂泥

> "_每一天_都投资于系统的设计。"
>
> Kent Beck，[《解析极限编程》](https://www.amazon.co.uk/Extreme-Programming-Explained-Embrace-Change/dp/0321278658)

> "最好的模块是深的。它们让大量功能可以通过一个简单的接口来访问。"
>
> John Ousterhout，[《软件设计的哲学》](https://www.amazon.co.uk/Philosophy-Software-Design-2nd/dp/173210221X)

**问题**：大多数用代理构建的应用都复杂且难以更改。因为代理能极大地加速编码，它们也加速了软件的熵增。代码库以前所未有的速度变得更复杂。

**修复**是一种关于 AI 驱动开发的全新、激进的方法：在意代码的设计。

这内建于这些技能的每一层：

- [`/to-spec`](./skills/engineering/to-spec/SKILL.md) 在创建规范之前先就你正在触碰哪些模块盘问你

而至关重要的是，[`/improve-codebase-architecture`](./skills/engineering/improve-codebase-architecture/SKILL.md) 帮助你拯救一个已经变成一团烂泥的代码库。我建议每隔几天就在你的代码库上运行它一次。

### 小结

软件工程的基本功比以往任何时候都更重要。这些技能是我把这些基本功浓缩为可重复实践的最大努力，好帮助你交付你职业生涯中最好的应用。享受吧。

## 参考

这些技能在一个维度上区分——谁能调用它们。**用户调用型**技能只有在你输入它们时才能触达（例如 `/grill-me`）；它们的职责是编排。**模型调用型**技能可以由你调用，_也可以_在任务合适时被代理自动触达；它们承载着可复用的纪律。一个用户调用型技能可以调用模型调用型技能，但绝不能调用另一个用户调用型技能。

### 工程（Engineering）

我每天用于代码工作的技能。

**用户调用型**

- **[ask-matt](./skills/engineering/ask-matt/SKILL.md)** —— 询问哪个技能或流程契合你的处境。一个在本仓库用户调用型技能之上的路由器。
- **[grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md)** —— 一次拷问会话，同时构建你项目的领域模型，磨砺术语并就地更新 `CONTEXT.md` 和 ADR。
- **[triage](./skills/engineering/triage/SKILL.md)** —— 让 issue 走过一套分诊角色的状态机。
- **[improve-codebase-architecture](./skills/engineering/improve-codebase-architecture/SKILL.md)** —— 扫描代码库寻找深化机会，以一份可视化的 HTML 报告呈现它们，然后就你挑选的那一个进行拷问。
- **[setup-matt-pocock-skills](./skills/engineering/setup-matt-pocock-skills/SKILL.md)** —— 为工程技能配置这个仓库（问题跟踪器、分诊标签、领域文档布局）。在使用其他工程技能之前，每个仓库运行一次。
- **[to-spec](./skills/engineering/to-spec/SKILL.md)** —— 把当前对话变成一份规范并发布到问题跟踪器。不做访谈——只综合你已经讨论过的内容。
- **[to-tickets](./skills/engineering/to-tickets/SKILL.md)** —— 把任何计划、规范或对话拆解成一组曳光弹式工单，每个都声明它的阻塞边——在本地文件里写成文本，或在真实跟踪器上写成原生阻塞链接。
- **[implement](./skills/engineering/implement/SKILL.md)** —— 构建一份规范或一组工单所描述的工作，在预先商定的接缝处驱动 `/tdd`，并在提交前以 `/code-review` 收尾。
- **[wayfinder](./skills/engineering/wayfinder/SKILL.md)** —— 规划一大块工作，超过单次代理会话所能容纳的量，作为问题跟踪器上一张调查工单的共享地图——逐个解决它们，直到通往目的地的路清晰起来。

**模型调用型**

- **[prototype](./skills/engineering/prototype/SKILL.md)** —— 构建一个一次性原型来回答一个设计问题——用于状态／逻辑问题的一个可运行终端应用，或从单一路由可切换的若干个截然不同的 UI 变体。
- **[diagnosing-bugs](./skills/engineering/diagnosing-bugs/SKILL.md)** —— 针对疑难 bug 和性能回归的严谨诊断循环：复现 → 最小化 → 提出假设 → 埋点 → 修复 → 回归测试。
- **[research](./skills/engineering/research/SKILL.md)** —— 针对高可信的一手来源调查一个问题，并把发现捕获为仓库中一个带引用的 Markdown 文件，以后台代理方式运行。
- **[tdd](./skills/engineering/tdd/SKILL.md)** —— 采用红-绿-重构循环的测试驱动开发。一次一个垂直切片地构建功能或修复 bug。
- **[domain-modeling](./skills/engineering/domain-modeling/SKILL.md)** —— 主动构建并磨砺一个项目的领域模型——针对术语表质疑各术语，用边界情形场景进行压力测试，并就地更新 `CONTEXT.md` 和 ADR。
- **[codebase-design](./skills/engineering/codebase-design/SKILL.md)** —— 用于设计深模块的共享纪律与词汇：大量行为置于一个小接口之后，放在一个干净的接缝处，可通过那个接口进行测试。
- **[code-review](./skills/engineering/code-review/SKILL.md)** —— 对自某个固定点以来的 diff 进行两轴评审：**Standards**（它是否遵循仓库的编码标准，外加一个 Fowler 坏味道基线？）和 **Spec**（它是否忠实地实现了源起的 issue/PRD？），作为并行的子代理运行，使两者互不污染。
- **[resolving-merge-conflicts](./skills/engineering/resolving-merge-conflicts/SKILL.md)** —— 逐个冲突块地处理一个进行中的 git 合并或变基冲突，按追溯到每一方一手来源的意图来解决，然后完成该操作——绝不 `--abort`。

### 生产力（Productivity）

通用工作流工具，与代码无关。

**用户调用型**

- **[grill-me](./skills/productivity/grill-me/SKILL.md)** —— 就一个计划或设计被无情地访谈，直到决策树的每个分支都被解决。
- **[handoff](./skills/productivity/handoff/SKILL.md)** —— 把当前对话压缩成一份交接文档，好让另一个代理接续这项工作。
- **[teach](./skills/productivity/teach/SKILL.md)** —— 跨多次会话教用户一项新技能或概念，以当前目录作为一个有状态的教学工作区。
- **[writing-great-skills](./skills/productivity/writing-great-skills/SKILL.md)** —— 把技能写好、编辑好的参考：让一个技能可预测的词汇和原则。

**模型调用型**

- **[grilling](./skills/productivity/grilling/SKILL.md)** —— 就一个计划、决策或想法无情地访谈用户，直到决策树的每个分支都被解决。`grill-me` 和 `grill-with-docs` 背后那个可复用的循环。
