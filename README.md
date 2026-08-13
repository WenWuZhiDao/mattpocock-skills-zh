<p>
  <a href="https://www.aihero.dev/s/skills-newsletter">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skills-repo-dark_2x.png">
      <source media="(prefers-color-scheme: light)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png">
      <img alt="Skills" src="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png" width="369">
    </picture>
  </a>
</p>

# 面向真正工程师的技能集

[![skills.sh](https://skills.sh/b/mattpocock/skills)](https://skills.sh/mattpocock/skills)

这是我每天用来做真正工程 —— 而非「凭感觉写代码」（vibe coding）—— 的智能体技能。

开发真正的应用程序很难。GSD、BMAD 和 Spec-Kit 这类方法试图通过接管整个流程来提供帮助。但这样一来，它们剥夺了你的控制权，也让流程中的 bug 变得难以解决。

这些技能被设计得小巧、易于调整、可组合。它们适用于任何模型。它们基于数十年的工程经验。尽情折腾它们，把它们变成你自己的，好好享受。

如果你想跟进这些技能的变化以及我创建的任何新技能，可以加入我的通讯（newsletter），与约 6 万名其他开发者一起：

[订阅通讯](https://www.aihero.dev/s/skills-newsletter)

## 安装（30 秒搞定）

两种入口，两种理念。**[Claude Code 插件](https://code.claude.com/docs/en/plugins)**将整套技能作为一个受管理的只读捆绑包安装，并在我发布更新时随之更新 —— 你是订阅，而不是 fork。**[skills.sh](https://skills.sh/mattpocock/skills)** 将可编辑的技能文件复制进你的项目，因此你可以对它们进行改造，把它们变成你自己的。二选一即可 —— 两种都装会让你每个技能都拥有两份。

### 1. 获取技能

<details>
<summary><strong>Claude Code</strong></summary>

```bash
claude plugins install mattpocock-skills
```

或者，在会话内：

```
/plugin install mattpocock-skills
```

它位于 Claude Code 的官方市场中，因此无需先添加任何东西，更新也会自动送达。

</details>

<details>
<summary><strong>Codex 及其他智能体</strong></summary>

```bash
npx skills@latest add mattpocock/skills
```

挑选你想要的技能，以及要将它们安装到哪些编码智能体上。**安装器允许你选择要取用哪些技能 —— 请确保 `setup-matt-pocock-skills` 是其中之一。**

原生 Codex 插件已在路线图上 —— 见 [`.agents/adr/0002-ship-as-a-claude-code-plugin.md`](./.agents/adr/0002-ship-as-a-claude-code-plugin.md)。

</details>

<details>
<summary><strong>面向爱折腾的人</strong></summary>

在任何智能体上使用同一个安装器 —— 包括 Claude Code：

```bash
npx skills@latest add mattpocock/skills
```

它会把技能作为你拥有、可编辑的普通文件写入你的仓库。不会有任何东西在你背后偷偷更新；想要我的最新改动时，用 `npx skills update` 拉取。

</details>

### 2. 运行 `/setup-matt-pocock-skills`

在你的智能体中，每个仓库运行一次。它会：

- 询问你想使用哪个问题追踪器（GitHub、Linear，或本地文件）
- 询问你在分诊时给票据打哪些标签（`/triage` 会用到标签）
- 询问你想把我们创建的任何文档保存到哪里

### 3. 搞定 —— 你已准备就绪。

## 这些技能为何存在

我构建这些技能，是为了修复我在 Claude Code、Codex 及其他编码智能体上看到的常见失败模式。

### #1：智能体没做出我想要的东西

> "没有人确切知道自己想要什么"
>
> David Thomas 与 Andrew Hunt，[《程序员修炼之道》](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**问题所在**。软件开发中最常见的失败模式是错位（misalignment）。你以为开发者知道你想要什么。然后你看到他们构建出来的东西 —— 你才意识到，他们根本没理解你。

到了 AI 时代，情况也一样。你与智能体之间存在沟通鸿沟。对此的解决办法是一次**拷问式会话（grilling session）** —— 让智能体就你正在构建的东西向你提出详尽的问题。

**解决方案**是使用：

- [`/grill-me`](./skills/productivity/grill-me/SKILL.md) —— 用于非代码场景
- [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md) —— 与 [`/grill-me`](./skills/productivity/grill-me/SKILL.md) 相同，但增加了更多好料（见下文）

这些是我最受欢迎的技能。它们帮助你在动手之前与智能体对齐，并对你正在做的改动进行深入思考。每一次你想做出改动时都应使用它们。

### #2：智能体太过啰嗦

> 有了统一语言（ubiquitous language），开发者之间的对话与代码的表达都源自同一个领域模型。
>
> Eric Evans，[《领域驱动设计》](https://www.amazon.co.uk/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215)

**问题所在**：在项目起步时，开发者与他们为之构建软件的人（领域专家）通常说着不同的语言。

我在自己的智能体身上感受到同样的张力。智能体通常被丢进一个项目，被要求边做边搞懂行话。于是它们用 20 个词去说 1 个词就够的事。

**解决方案**是一套共享语言。它是一份帮助智能体解码项目中所用行话的文档。

<details>
<summary>
示例
</summary>

这是一个来自我的 `course-video-manager` 仓库的 [`CONTEXT.md`](https://github.com/mattpocock/course-video-manager/blob/076a5a7a182db0fe1e62971dd7a68bcadf010f1c/CONTEXT.md) 示例。哪一句更容易读懂？

- **之前**："当课程某个章节里的一节课被『变为真实』（即在文件系统中被赋予一个位置）时会出问题"
- **之后**："物化级联（materialization cascade）出问题了"

这种简洁会在一次又一次的会话中带来回报。

</details>

这已内建于 [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md)。它是一次拷问式会话，但能帮助你与 AI 建立起共享语言，并在 ADR 中记录难以解释的决策。

很难说清这有多强大。它也许是本仓库中最酷的单项技术。试一试，你就知道了。

> [!TIP]
> 共享语言除了减少啰嗦之外还有许多其他好处：
>
> - **变量、函数和文件的命名保持一致**，都使用共享语言
> - 因此，**代码库对智能体来说更易于导航**
> - 智能体在**思考上也花更少的 token**，因为它可以使用一套更简洁的语言

### #3：代码跑不起来

> "始终迈出小而审慎的步子。反馈的速率就是你的速度上限。永远不要接下一个太大的任务。"
>
> David Thomas 与 Andrew Hunt，[《程序员修炼之道》](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**问题所在**：假设你和智能体已经就要构建什么达成了一致。当智能体_依然_产出垃圾时会怎样？

是时候审视你的反馈回路了。如果没有关于其产出的代码实际运行情况的反馈，智能体就会盲飞。

**解决方案**：你需要那套常规的反馈回路：静态类型、浏览器访问，以及自动化测试。

对于自动化测试，红-绿-重构（red-green-refactor）回路至关重要。也就是让智能体先写一个失败的测试，再修好这个测试。这有助于给智能体提供稳定水平的反馈，从而产出好得多的代码。

我构建了一个可以嵌入任何项目的 **[`/tdd`](./skills/engineering/tdd/SKILL.md) 技能**。它鼓励红-绿-重构，并就好测试与坏测试的标准给智能体大量指引。

对于调试，我还构建了一个 **[`/diagnosing-bugs`](./skills/engineering/diagnosing-bugs/SKILL.md)** 技能，它把最佳调试实践包装进一个有纪律的回路，逐阶段设卡（gated）。

### #4：我们建出了一坨烂泥（Ball Of Mud）

> "_每一天_都投资于系统的设计。"
>
> Kent Beck，[《解析极限编程》](https://www.amazon.co.uk/Extreme-Programming-Explained-Embrace-Change/dp/0321278658)

> "最好的模块是深的。它们让大量功能能够通过一个简单的接口来访问。"
>
> John Ousterhout，[《软件设计的哲学》](https://www.amazon.co.uk/Philosophy-Software-Design-2nd/dp/173210221X)

**问题所在**：大多数用智能体构建的应用都复杂且难以更改。因为智能体能极大地加速编码，它们也加速了软件的熵增。代码库以前所未有的速率变得更加复杂。

**解决方案**是一种全新的 AI 驱动开发方式：在意代码的设计。

这已内建于这些技能的每一层：

- [`/to-spec`](./skills/engineering/to-spec/SKILL.md) 会在创建规格之前就你正在改动哪些模块对你进行考问

而关键在于，[`/improve-codebase-architecture`](./skills/engineering/improve-codebase-architecture/SKILL.md) 会对代码库进行普查，寻找可加深（deepening）的机会，并把候选项交到你手上。我建议每隔几天在你的代码库上运行一次。它是一次普查，而非一次救援：在一个真正陈旧的代码库上，它会找出真实的候选项，但它不会替你理清那坨烂泥。

### 小结

软件工程的基本功比以往任何时候都更重要。这些技能是我尽最大努力将这些基本功浓缩为可重复实践的成果，以帮助你交付职业生涯中最好的应用。好好享受。

## 参考

这些技能沿一个轴划分 —— 谁可以调用它们。**用户调用型**技能只有在你键入它们时才可触达（例如 `/grill-me`）；它们的职责是编排。**模型调用型**技能可以由你调用，_也可_在任务契合时由智能体自动触达；它们承载可复用的纪律。用户调用型技能可以调用模型调用型技能，但绝不会调用另一个用户调用型技能。

### 工程（Engineering）

我每天用于代码工作的技能。

**用户调用型**

- **[ask-matt](./skills/engineering/ask-matt/SKILL.md)** —— 询问哪个技能或流程适合你的处境。是本仓库中用户调用型技能之上的一个路由器。
- **[grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md)** —— 拷问式会话，同时构建你项目的领域模型，磨砺术语并就地更新 `CONTEXT.md` 与 ADR。
- **[triage](./skills/engineering/triage/SKILL.md)** —— 让问题在分诊角色的状态机中流转。
- **[improve-codebase-architecture](./skills/engineering/improve-codebase-architecture/SKILL.md)** —— 扫描代码库以寻找可加深的机会，将其呈现为可视化的 HTML 报告，然后就你所挑选的那一项进行拷问。
- **[setup-matt-pocock-skills](./skills/engineering/setup-matt-pocock-skills/SKILL.md)** —— 为工程技能配置本仓库（问题追踪器、分诊标签、领域文档布局）。在使用其他工程技能之前，每个仓库运行一次。
- **[to-spec](./skills/engineering/to-spec/SKILL.md)** —— 将当前对话转化为一份规格并发布到问题追踪器。无需访谈 —— 只是把你们已经讨论过的内容综合起来。
- **[to-tickets](./skills/engineering/to-tickets/SKILL.md)** —— 把任何计划、规格或对话拆解为一组「曳光弹（tracer-bullet）」票据，每一条都声明其阻塞边（blocking edges）—— 以文本形式写在本地文件中，或作为真实追踪器上的原生阻塞链接。
- **[implement](./skills/engineering/implement/SKILL.md)** —— 构建某份规格或一组票据所描述的工作，在预先约定的接缝处驱动 `/tdd`，并在提交前以 `/code-review` 收尾。
- **[wayfinder](./skills/engineering/wayfinder/SKILL.md)** —— 将一大块工作（超出单个智能体会话所能容纳的规模）规划为问题追踪器上一张由决策票组成的共享地图 —— 逐一解决它们，直到通往目的地的道路清晰可见。

**模型调用型**

- **[prototype](./skills/engineering/prototype/SKILL.md)** —— 构建一个用完即弃的原型来回答某个设计问题 —— 用于状态/逻辑问题的单个可分享 HTML 文件，或若干可从单一路由切换的差异极大的 UI 变体。
- **[diagnosing-bugs](./skills/engineering/diagnosing-bugs/SKILL.md)** —— 针对棘手 bug 与性能回退的有纪律诊断回路：构建一个在此 bug 上会变红的反馈回路 → 最小化 → 提出假设 → 埋点观测 → 修复 → 回归测试。
- **[research](./skills/engineering/research/SKILL.md)** —— 针对高可信度的一手来源调查某个问题，并将发现作为一个带引用的 Markdown 文件捕获到仓库中，以后台智能体方式运行。
- **[tdd](./skills/engineering/tdd/SKILL.md)** —— 采用红-绿-重构回路的测试驱动开发。一次一个纵向切片地构建功能或修复 bug。
- **[domain-modeling](./skills/engineering/domain-modeling/SKILL.md)** —— 主动构建并磨砺项目的领域模型 —— 对照术语表挑战各个术语，用边界情形场景进行压力测试，并就地更新 `CONTEXT.md` 与 ADR。
- **[codebase-design](./skills/engineering/codebase-design/SKILL.md)** —— 用于设计深模块的共享纪律与词汇：将大量行为置于一个小接口之后，安放在一个干净的接缝处，并可通过该接口进行测试。
- **[code-review](./skills/engineering/code-review/SKILL.md)** —— 对自某个固定点以来的 diff 进行双轴审查：**标准（Standards）**（它是否遵循仓库的编码标准，外加一条 Fowler 坏味道基线？）与**规格（Spec）**（它是否忠实实现了发起的问题/规格？），作为并行子智能体运行，以免二者相互污染。
- **[resolving-merge-conflicts](./skills/engineering/resolving-merge-conflicts/SKILL.md)** —— 逐个冲突块地处理一次进行中的 git 合并或变基冲突，依据可追溯到各方一手来源的意图来解决，然后完成该操作 —— 绝不使用 `--abort`。
- **[wizard](./skills/engineering/wizard/SKILL.md)** —— 生成一个交互式 bash 向导，引导人类完成只有他们才能执行的步骤：预置基础设施、设置凭据或 CI 密钥、走完一个不熟悉的第三方仪表盘，或执行一次一次性的迁移或切换。

### 生产力（Productivity）

通用工作流工具，不专属于代码。

**用户调用型**

- **[grill-me](./skills/productivity/grill-me/SKILL.md)** —— 就某个计划或设计接受不留情面的访谈，直到决策树的每个分支都被解决。
- **[handoff](./skills/productivity/handoff/SKILL.md)** —— 将当前对话压缩成一份交接文档，以便另一个智能体能继续这项工作。
- **[teach](./skills/productivity/teach/SKILL.md)** —— 跨多个会话教用户一项新技能或概念，将当前目录用作一个有状态的教学工作区。
- **[to-questionnaire](./skills/productivity/to-questionnaire/SKILL.md)** —— 把一个你无法独自回答的决策，转化为一份面向那个唯一能回答的人的 Markdown 问卷 —— 异步填写，或在会议中一起填写。它就发送本身（发给谁、你需要拿回什么）对你进行拷问，而非就主题本身。
- **[wait-what](./skills/productivity/wait-what/SKILL.md)** —— 在某条消息没能让你理解的那一刻就触发它。智能体会用你所缺失的上下文、以平实的英文、使用你的 `CONTEXT.md` 词汇，把它重新讲一遍。

**模型调用型**

- **[grilling](./skills/productivity/grilling/SKILL.md)** —— 就某个计划、决策或想法不留情面地访谈用户，直到决策树的每个分支都被解决。是 `grill-me`、`grill-with-docs`、`triage`、`wayfinder` 和 `improve-codebase-architecture` 背后可复用的访谈原语。
- **[writing-for-agents](./skills/productivity/writing-for-agents/SKILL.md)** —— 为智能体撰写文档：技能、AGENTS.md/CLAUDE.md，以及智能体通过某个指针触达的任何文档。
