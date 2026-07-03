# 编写文档页面

`engineering/` 和 `productivity/` 中的每个技能都在 `docs/<bucket>/<skill-name>.md` 有一个面向人的**文档页面**——文档树镜像 `skills/` 下的这两个 bucket 文件夹。它发布在 `https://aihero.dev/skills-<skill-name>`；无论属于哪个 bucket，URL 始终是 `skills-<skill-name>`，因此文档路径只是仓库组织方式。该页面不是技能，也不是 `SKILL.md` 的副本。只有这两个 bucket 是推广的；其余（`misc/`、`personal/`、`in-progress/`、`deprecated/`）不发布文档页面。

这些技能大多是**用户调用**的：智能体永远不会替你触发它们，所以_你_就是那个必须记住它们存在、以及何时去触及它们的索引。那份记忆就是**认知负荷（cognitive load）**。文档页面的职责就是缓解它——让一位读者围绕一个技能建立方位感，使他们能把它装进脑子里，知道何时去触及它，并看清它在系统中所处的位置。这些页面共同构成一个分布式路由器；每一页都是一个节点。

每当一个推广技能被添加、重命名或改变了行为时就要行动：创建或重新同步它的文档页面。重命名也会移动文件（`docs/<bucket>/<old>.md` → `docs/<bucket>/<new>.md`），因为发布的 URL 跟随名字；在 `engineering/` 和 `productivity/` 之间迁移的技能，会把它的文档文件移到相应的文件夹。`misc/`、`personal/`、`in-progress/` 和 `deprecated/` 中的技能没有页面——这些 bucket 都不是推广的。一个技能从其中之一迁_出_到 `engineering/` 或 `productivity/` 会获得页面；反方向迁移则失去它。

因为这些页面发布在 `aihero.dev` 上，**每个链接都是绝对链接**——绝不用仓库相对路径。指向另一个技能的链接指向 `https://aihero.dev/skills-<name>`；指向仓库的链接指向它完整的 `https://github.com/mattpocock/skills/...` URL。在仓库里能工作的相对链接一经发布就会失效。

没有 H1——发布的页面从 slug 获取标题。

## 页面结构

填写下面的模板。**固定框架**（Quickstart 块、source 链接、`## What it does`、`## When to reach for it`、`## Where it fits`）出现在每一页。**可变的中间部分**——`## Prerequisites` 以及自由发挥的实质小节——只承载这个特定技能应得的内容；其余删除。

<page-template>

Quickstart:

```bash
npx skills add mattpocock/skills --skill=<name>
```

```bash
npx skills update <name>
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/<bucket>/<name>)

## What it does

一到两段平实的语言。以技能一句话的职责开头，然后陈述**定义性约束**——那个让本技能行为不同于显而易见的默认做法的单一事实（对 `to-prd` 而言：它不再访谈用户，而是综合已知内容）。把它写成一句平实的陈述句——绝不要写成带标签的旁注，比如 "The defining constraint:" 或 "The key thing:"；这种套路读起来像填充物。这一行是页面上最有价值的一行；绝不省略。

## When to reach for it

你如何、何时去触及这个技能——两个要点，二者实际上总是同时存在：

- **调用模式。** 说明是你输入它，还是智能体触发它。用户调用技能："You invoke this by typing `/<name>` — the agent won't reach for it on its own." 模型调用技能："Type `/<name>`, or the agent reaches for it automatically when a task fits."
- **触发边界。** 索引条目："reach for this when …"。在该技能与某个同类容易混淆之处，补上另一半——"for <X> instead, use [<sibling>](https://aihero.dev/skills-<sibling>)."

## Prerequisites

可选——仅当技能需要某些前置条件才能运作时才包含；否则整个标题都省略。涵盖：它**写入的工作区**（像 `grill-with-docs` 这样的有状态技能会写入 `CONTEXT.md` 和 ADR；`teach` 会构建一整个目录——说明它写什么、写到哪里）、**前置设置**（`triage`/`to-prd`/`to-issues` 需要 `setup-matt-pocock-skills` 已配置好 issue 追踪器），或**仓库特定的工具**。一个能在任何地方运行的无状态技能没有前置条件——去掉该小节。

## <free-form middle>

一到三个简短小节，用技能_自己的词汇_，让它一目了然——选任何契合该技能的标题：它运行的回路、它产出的产物、它做出的分叉、它消灭的那个反模式。没有规定的标题；这些技能太异构，无法统一。

唯一不可让步的一点：**呈现技能的领头词 / 定义性理念**——`tight` 反馈回路、`deep module`（深模块）、一次性代码回答一个问题、红-绿。它有双重回报：读者既学到该技能_是什么_，也学到那个他们日后会用来_触及_它的词。

## It's working if

可选。一份简短、可核对的清单，列出那些告诉读者技能确实在起作用的可观察信号——它触发时应该看到什么，以及在缺失时表明它没触发。当一个技能有清晰的迹象时才包含它（例如 `to-prd` 不再访谈你就写出内容；一个领头词在轨迹中反复出现）；当信号模糊时省略该标题。几个要点即可，不要更多。

## Where it fits

总是存在。用一两句话把技能安置在系统中：

- **角色。** 给它命名：一个**链条步骤**（`grill-with-docs → to-prd → to-issues → implement → code-review`）、一个**一次性设置**（`setup-matt-pocock-skills`）、**周期性维护**（`improve-codebase-architecture`，"每隔几天"），或一个**随时可触及的独立技能**（`diagnosing-bugs`、`prototype`、`handoff`）。独立技能的定位就是一句诚实的话——远胜于省略该小节。
- **邻居。** 那一两个重要的同类，每个都带一个 because 从句，用绝对链接。
- **这张图。** 指向 [ask-matt](https://aihero.dev/skills-ask-matt)，整套之上的路由器，好让本页保持为一个节点，永远不必重绘整张图。

</page-template>

## 约定

- 解释**为什么**，而不是流程。页面为技能建立方位、安置位置；它绝不复述 `SKILL.md` 的步骤或倾倒模板——一个在选工具的人不需要操作手册。
- 使用技能的**领头词**（_接缝_、_深模块_、_曳光弹_），让页面和技能说同一种语言。
- 让页面本身保持低负荷。它是_关于_低认知负荷技能的文档；家具（多余的标题、重述的链接）正是它所反对的东西。

## Done when

- 页面存在于 `docs/<bucket>/<name>.md`，且没有过时的页面在重命名或 bucket 迁移后残留。
- Quickstart 块和 source 链接命名了正确的 bucket 和技能；update 行命名了技能。
- `## What it does` 陈述了定义性约束，作为平实散文而非带标签的旁注。
- `## When to reach for it` 陈述了调用模式和触发边界。
- `## Where it fits` 命名了角色并链接到 `ask-matt`。
- 在存在前置条件（工作区、前置设置、工具）的地方陈述了它，在不存在的地方省略该小节。
- 中间部分呈现了领头词。
- 每个链接都是绝对链接，且每个都能解析。
