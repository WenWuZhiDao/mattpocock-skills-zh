<p>
  <a href="https://www.aihero.dev/s/skills-newsletter">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skills-repo-dark_2x.png">
      <source media="(prefers-color-scheme: light)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png">
      <img alt="Skills" src="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png" width="369">
    </picture>
  </a>
</p>

# 给真正工程师的技能集（Skills For Real Engineers）
## 原项目地址： https://github.com/mattpocock/skills
使用claude code 将项目翻译成中文。

[![skills.sh](https://skills.sh/b/mattpocock/skills)](https://skills.sh/mattpocock/skills)

这是我每天用来做真正工程工作的 agent 技能——不是凭感觉瞎写代码（vibe coding）。

开发真正的应用很难。GSD、BMAD、Spec-Kit 这类方法试图通过接管流程来帮你。但在这样做的同时，它们也夺走了你的控制权，让流程中的 bug 难以解决。

这些技能被设计得小巧、易于改造、可组合。它们适用于任何模型。它们建立在数十年的工程经验之上。尽情折腾它们吧。把它们改造成你自己的。好好享受。

如果你想及时了解这些技能的变化，以及我创建的任何新技能，可以加入我的 newsletter，与另外约 60,000 名开发者一起：

[订阅 Newsletter](https://www.aihero.dev/s/skills-newsletter)

## 快速开始（30 秒搞定）

1. 运行 skills.sh 安装器：

```bash
npx skills@latest add mattpocock/skills
```

2. 选择你想要的技能，以及你想把它们安装到哪些编码 agent 上。**确保你选中了 `/setup-matt-pocock-skills`**。

3. 在你的 agent 中运行 `/setup-matt-pocock-skills`。它会：
   - 询问你想使用哪个 issue tracker（GitHub、Linear，或本地文件）
   - 询问你在 triage（分类处理）工单时会打哪些标签（`/triage` 会用到标签）
   - 询问你想把我们创建的文档保存到哪里

4. 搞定——可以开始用了。

## 这些技能为何存在

我构建这些技能，是为了修复我在 Claude Code、Codex 以及其他编码 agent 上常见的失败模式。

### #1：Agent 没做我想要的

> “没有人确切知道自己想要什么”
>
> David Thomas & Andrew Hunt，[《程序员修炼之道》（The Pragmatic Programmer）](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**问题**。软件开发中最常见的失败模式是“没对齐”。你以为开发者知道你想要什么。然后你看到他们做出来的东西——才意识到他对你的理解完全错了。

在 AI 时代也一样。你和 agent 之间存在沟通鸿沟。解决办法是来一场 **拷问式追问（grilling session）**——让 agent 就你要构建的东西向你提出详细问题。

**解决办法** 是使用：

- [`/grill-me`](./skills/productivity/grill-me/SKILL.md) - 用于非代码场景
- [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md) - 与 [`/grill-me`](./skills/productivity/grill-me/SKILL.md) 相同，但增加了更多好东西（见下文）

这是我最受欢迎的技能。它们帮你在动手之前与 agent 对齐，并深入思考你要做的改动。每次你想做改动时都用它们。

### #2：Agent 太啰嗦了

> 有了统一语言（ubiquitous language），开发者之间的对话和代码的表达都源自同一个领域模型。
>
> Eric Evans，[《领域驱动设计》（Domain-Driven-Design）](https://www.amazon.co.uk/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215)

**问题**：项目刚开始时，开发者和他们为之构建软件的人（领域专家）通常说着不同的语言。

我和我的 agent 之间也有同样的张力。Agent 通常被丢进一个项目里，被要求一边干一边搞懂术语。于是它们用 20 个词去表达 1 个词就能说清的事。

**解决办法** 是建立一套共享语言。这是一份帮助 agent 解码项目中所用术语的文档。

<details>
<summary>
示例
</summary>

这是一个来自我的 `course-video-manager` 仓库的 [`CONTEXT.md`](https://github.com/mattpocock/course-video-manager/blob/076a5a7a182db0fe1e62971dd7a68bcadf010f1c/CONTEXT.md) 示例。哪一句更容易读？

- **改之前**：“当一门课程某个章节内的一节课被‘变成真实的’（即在文件系统中获得一个位置）时，会出现一个问题”
- **改之后**：“materialization cascade（物化级联）存在一个问题”

这种简洁在一次次会话中持续带来回报。

</details>

这个能力已内置于 [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md)。它是一场拷问式追问，但能帮你与 AI 构建共享语言，并把难以言说的决策记录到 ADR 中。

很难形容它有多强大。它可能是这个仓库里最酷的一项技术。试试看，你就知道了。

> [!TIP]
> 共享语言除了减少啰嗦外，还有许多其他好处：
>
> - **变量、函数和文件的命名更一致**，因为都用同一套共享语言
> - 因此，**代码库对 agent 来说更易导航**
> - Agent 在思考上 **花费更少的 token**，因为它能用上更简洁的语言

### #3：代码跑不起来

> “永远迈出小而审慎的步子。反馈的速率就是你的限速。永远不要接下一个太大的任务。”
>
> David Thomas & Andrew Hunt，[《程序员修炼之道》（The Pragmatic Programmer）](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**问题**：假设你和 agent 已经对要构建什么达成一致。可当 agent _仍然_ 产出垃圾时，会发生什么？

是时候审视你的反馈循环了。如果对它产出的代码实际运行情况没有反馈，agent 就只能盲飞。

**解决办法**：你需要那一整套常规的反馈循环：静态类型、浏览器访问，以及自动化测试。

对于自动化测试，red-green-refactor（红-绿-重构）循环至关重要。即 agent 先写一个失败的测试，然后让测试通过。这能给 agent 持续稳定的反馈，从而产出好得多的代码。

我做了一个 **[`/tdd`](./skills/engineering/tdd/SKILL.md) 技能**，你可以把它嵌入任何项目。它鼓励 red-green-refactor，并就什么是好测试、什么是坏测试给 agent 大量指引。

对于调试，我还做了一个 **[`/diagnose`](./skills/engineering/diagnose/SKILL.md)** 技能，把最佳调试实践包装成一个简单的循环。

### #4：我们搭出了一团烂泥（Ball Of Mud）

> “_每天_ 都要投资于系统的设计。”
>
> Kent Beck，[《解析极限编程》（Extreme Programming Explained）](https://www.amazon.co.uk/Extreme-Programming-Explained-Embrace-Change/dp/0321278658)

> “最好的模块是深的。它们让大量功能能够通过一个简单的接口被访问。”
>
> John Ousterhout，[《软件设计的哲学》（A Philosophy Of Software Design）](https://www.amazon.co.uk/Philosophy-Software-Design-2nd/dp/173210221X)

**问题**：大多数用 agent 构建的应用都复杂且难以更改。因为 agent 能极大地加速编码，它们也加速了软件熵增。代码库以前所未有的速度变得越来越复杂。

**解决办法** 是一种全新的 AI 驱动开发方法：在意代码的设计。

这一点内置于这些技能的每一层：

- [`/to-prd`](./skills/engineering/to-prd/SKILL.md) 在创建 PRD 之前先就你将触碰哪些模块向你提问
- [`/zoom-out`](./skills/engineering/zoom-out/SKILL.md) 让 agent 在整个系统的语境下解释代码

而最关键的是，[`/improve-codebase-architecture`](./skills/engineering/improve-codebase-architecture/SKILL.md) 能帮你拯救一个已经变成一团烂泥的代码库。我建议每隔几天就在你的代码库上运行一次。

### 小结

软件工程的基本功比以往任何时候都更重要。这些技能是我把这些基本功凝练成可重复实践的最大努力，旨在帮你交付职业生涯中最好的应用。好好享受。

## 参考清单

### Engineering（工程）

我每天做代码工作时使用的技能。

- **[diagnose](./skills/engineering/diagnose/SKILL.md)** — 针对疑难 bug 和性能回归的严谨诊断循环：复现 → 最小化 → 提出假设 → 插桩 → 修复 → 回归测试。
- **[grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md)** — 拷问式追问会话，用现有领域模型来挑战你的计划，打磨术语，并就地更新 `CONTEXT.md` 和 ADR。
- **[triage](./skills/engineering/triage/SKILL.md)** — 通过一套 triage 角色的状态机对 issue 进行分类处理。
- **[improve-codebase-architecture](./skills/engineering/improve-codebase-architecture/SKILL.md)** — 在代码库中寻找“加深模块”的机会，依据 `CONTEXT.md` 中的领域语言和 `docs/adr/` 中的决策。
- **[setup-matt-pocock-skills](./skills/engineering/setup-matt-pocock-skills/SKILL.md)** — 搭建每个仓库的配置（issue tracker、triage 标签词汇、领域文档布局）供其他工程技能使用。在使用 `to-issues`、`to-prd`、`triage`、`diagnose`、`tdd`、`improve-codebase-architecture` 或 `zoom-out` 之前，每个仓库运行一次。
- **[tdd](./skills/engineering/tdd/SKILL.md)** — 采用 red-green-refactor 循环的测试驱动开发。每次构建一个垂直切片来开发功能或修复 bug。
- **[to-issues](./skills/engineering/to-issues/SKILL.md)** — 用垂直切片把任何计划、规格或 PRD 拆解成可被独立领取的 GitHub issue。
- **[to-prd](./skills/engineering/to-prd/SKILL.md)** — 把当前对话语境变成一份 PRD 并作为 GitHub issue 提交。不做访谈——只综合你已经讨论过的内容。
- **[zoom-out](./skills/engineering/zoom-out/SKILL.md)** — 让 agent “拉远镜头”，对一段不熟悉的代码给出更宏观的语境或更高层的视角。
- **[prototype](./skills/engineering/prototype/SKILL.md)** — 构建一个一次性原型来充实设计——要么是用于状态/业务逻辑问题的可运行终端应用，要么是几个可从同一路由切换的、差异极大的 UI 变体。

### Productivity（生产力）

通用的工作流工具，不针对代码。

- **[caveman](./skills/productivity/caveman/SKILL.md)** — 极度压缩的沟通模式。通过去掉废话把 token 用量削减约 75%，同时保持完整的技术准确性。
- **[grill-me](./skills/productivity/grill-me/SKILL.md)** — 就一个计划或设计接受不留情面的盘问，直到决策树的每个分支都被解决。
- **[handoff](./skills/productivity/handoff/SKILL.md)** — 把当前对话压缩成一份交接文档，让另一个 agent 能接着干。
- **[teach](./skills/productivity/teach/SKILL.md)** — 跨多次会话教用户一项新技能或概念，把当前目录用作一个有状态的教学工作区。
- **[write-a-skill](./skills/productivity/write-a-skill/SKILL.md)** — 创建结构规范、采用渐进式披露、并打包好资源的新技能。

### Misc（杂项）

我留着但很少用的工具。

- **[git-guardrails-claude-code](./skills/misc/git-guardrails-claude-code/SKILL.md)** — 设置 Claude Code hook，在危险的 git 命令（push、reset --hard、clean 等）执行前将其拦截。
- **[migrate-to-shoehorn](./skills/misc/migrate-to-shoehorn/SKILL.md)** — 把测试文件从 `as` 类型断言迁移到 @total-typescript/shoehorn。
- **[scaffold-exercises](./skills/misc/scaffold-exercises/SKILL.md)** — 创建带有章节、问题、解答和讲解的练习目录结构。
- **[setup-pre-commit](./skills/misc/setup-pre-commit/SKILL.md)** — 设置带 lint-staged、Prettier、类型检查和测试的 Husky pre-commit hook。
