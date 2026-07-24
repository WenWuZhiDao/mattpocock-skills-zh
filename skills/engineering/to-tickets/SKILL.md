---
name: to-tickets
description: 把一个计划、规格说明或当前对话拆分成一组曳光弹式工单，每张声明它的阻塞边，发布到所配置的跟踪器——在本地为每张工单一个文件、边以文字形式，或在真实跟踪器上为原生阻塞链接。
disable-model-invocation: true
---

# To Tickets

把一个计划、规格说明或对话拆分成一组**工单**——曳光弹式的垂直切片，每张都声明**阻塞**它的那些工单。

issue 跟踪器和分诊标签词汇应该已经提供给你了——如果没有，运行 `/setup-matt-pocock-skills`。

## 流程

### 1. 收集上下文

从对话上下文中已有的任何东西出发。如果用户传入了一个引用（一个规格说明路径、一个 issue 编号或 URL）作为参数，就获取它并阅读其完整正文和评论。

### 2. 探索代码库（可选）

如果你还没探索过代码库，就探索一下以了解代码的当前状态。工单标题和描述应使用项目领域术语表的词汇，并尊重你所触及区域内的 ADR。

寻找预重构（prefactor）代码的机会，让实现更容易。"先让改动变容易，再做那个容易的改动。"

### 3. 起草垂直切片

把工作拆分成**曳光弹**式工单。

<vertical-slice-rules>

- 每个切片穿过每一层（schema、API、UI、测试）切出一条狭窄但完整的路径——是纵向的，而不是某一层的横向切片
- 一个完成的切片本身即可演示或可验证
- 每个切片的大小以能装进单个全新上下文窗口为准
- 任何预重构都应先做

</vertical-slice-rules>

给每张工单它的**阻塞边**——在它能开始之前必须完成的其他工单。没有阻塞项的工单可以立即开始。

**宽重构是垂直切片的例外。** 一次**宽重构**是一个机械性的改动——重命名一个列、重新给一个共享符号定类型——其**波及半径**扇形铺展到整个代码库，因此单次编辑一下子就破坏成千上万个调用点，没有任何垂直切片能落地变绿。不要硬把它塞进一颗曳光弹；用**扩展—收缩（expand–contract）**来编排它。先扩展：在旧形式旁边加上新形式，这样什么都不会坏。然后按波及半径的大小（每个包、每个目录）分批把调用点迁过去，每一批都是它自己的、被扩展所阻塞的工单，逐批保持 CI 变绿，因为旧形式依然存在。最后收缩：一旦没有调用方残留就删掉旧形式，放在一个被每一个迁移批次所阻塞的工单里。当连各批次也无法单独保持变绿时，保留这个序列但让它们共享一个集成分支，这些批次都阻塞一个最终的"集成并验证"工单——只在那里承诺变绿。

### 4. 盘问用户

把提议的拆分作为一个编号列表呈现。对每张工单，展示：

- **标题**：简短的描述性名称
- **Blocked by**：哪些其他工单（如有）必须先完成
- **它交付什么**：这张工单让其工作起来的端到端行为

问用户：

- 粒度感觉对吗？（太粗 / 太细）
- 阻塞边正确吗——每张工单是否只依赖真正对它设闸的工单？
- 有工单应该合并或进一步拆分吗？

反复迭代，直到用户批准这个拆分。

### 5. 把工单发布到所配置的跟踪器

发布已批准的工单。**如何**发布取决于 `/setup-matt-pocock-skills` 所配置的跟踪器——两种方式下工单都是一样的，只有阻塞边的形态改变：

- **本地文件** → 在 `.scratch/<feature-slug>/issues/<NN>-<slug>.md` 下每张工单写一个文件，按依赖顺序（阻塞项优先）从 `01` 编号。每个文件的"Blocked by"列出它所依赖的编号/标题。使用下面的每工单文件模板——每个文件一张工单，绝不是单个合并文件。
- **一个真实的 issue 跟踪器（GitHub、Linear……）** → 按依赖顺序（阻塞项优先）每张工单发布一个 issue，这样每张工单的阻塞边都能引用真实的标识符。使用平台的原生阻塞 / 子 issue 关系（如果它有的话）；否则把每张工单的"Blocked by"设为那些阻塞它的 issue。除非另有指示，否则应用 `ready-for-agent` 分诊标签——这些工单按构造就是 agent 可认领的。

处理**前沿**：任何阻塞项全部完成的工单。对于纯线性链，这意味着自上而下。

不要关闭或修改任何父 issue。

<local-ticket-template>

# <NN> — <Ticket title>

**What to build:** the end-to-end behaviour this ticket makes work, from the user's perspective — not a layer-by-layer implementation list.

**Blocked by:** the numbers/titles of the tickets that gate this one, or "None — can start immediately".

**Status:** ready-for-agent

- [ ] Acceptance criterion 1
- [ ] Acceptance criterion 2

</local-ticket-template>

<issue-template>

## Parent

A reference to the parent issue on the tracker (if the source was an existing issue, otherwise omit this section).

## What to build

The end-to-end behaviour this ticket makes work, from the user's perspective — not layer-by-layer implementation.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2

## Blocked by

- A reference to each blocking ticket, or "None — can start immediately".

</issue-template>

无论哪种形式，都避免使用具体的文件路径或代码片段——它们很快就会过时。例外：如果某个原型产出了一个比散文更精确地编码了某项决策的片段（状态机、reducer、schema、类型形态），就把它内联进来，并简短注明它来自一个原型。修剪到富含决策的部分——不是一个能运行的 demo，只是重要的那几处。
