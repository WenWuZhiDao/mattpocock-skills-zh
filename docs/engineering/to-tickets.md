## 它做什么

`to-tickets` 拿一份计划、一份[规范](https://www.aihero.dev/ai-coding-dictionary/spec)、或者你正身处其中的对话，把它拆分成你 issue 跟踪器上的一组 **[ticket](https://www.aihero.dev/ai-coding-dictionary/ticket)**。每个 ticket 声明它的**阻塞边**——那些必须在它能开始之前完成的其他 ticket。

每个 ticket 都是一颗**曳光弹**：一条穿过改动每一层的狭窄但完整的路径——schema、API、UI、测试——它一落地就能自己被演示。这就是让它的行为不同于那种显而易见的拆分方式的约束，那种方式是一次切一层、最后再集成。它也把每个 ticket 切成能放进一个全新[上下文窗口](https://www.aihero.dev/ai-coding-dictionary/context-window)的大小，因为将会接手这个 ticket 的，是一个从没见过你的规范的[会话](https://www.aihero.dev/ai-coding-dictionary/session)。

## 何时使用它

你通过输入 `/to-tickets` 来调用它——[agent](https://www.aihero.dev/ai-coding-dictionary/agent) 不会自己去调用它。

| 你在哪里 | 运行什么 |
| --- | --- |
| 你有一个规范 issue，而构建跨越多个会话 | `/to-tickets`，或 `/to-tickets #<spec_issue>` |
| 计划只在对话里，从没写成文 | `/to-tickets` 直接读取对话线程——无需规范 |
| 整个改动放得进一个上下文窗口 | [implement](https://aihero.dev/skills-implement)——跳过 ticket |
| 还什么都没决定 | [grill-with-docs](https://aihero.dev/skills-grill-with-docs)，然后 [to-spec](https://aihero.dev/skills-to-spec) |
| 一张 [wayfinder](https://aihero.dev/skills-wayfinder) 地图已经理清 | 先 [to-spec](https://aihero.dev/skills-to-spec) 坍缩地图，然后 `/to-tickets` |

`to-tickets` 产出的 ticket 从构造上就是 agent 就绪的。别对它们跑 [triage](https://aihero.dev/skills-triage)——triage 是给从别人那里来的工作用的。

## 前置条件

`to-tickets` 发布进一个跟踪器，所以 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) 必须已经为这个仓库配置好一个跟踪器，连同 triage 标签词汇。哪种都行：一个真实的跟踪器如 GitHub 或 Linear，或者 `.scratch/` 下的本地 markdown 文件，后者开箱即用受支持。

## 曳光弹，而非层

一个**水平**切片交付改动的一层。在每一层都落地之前什么都不工作，而且每个 ticket 的验收标准都不得不伸进另一个 ticket 拥有的工作里。一个**垂直**切片——曳光弹——一次交付穿过所有层的一条细路径，所以它能独自被验证，并拥有它所评判的一切。

这是人们最常打破的规则，其后果有充分的记录。有一个团队跑了一个 26 ticket 的栈，按层切分——语料、生产者、聚合器、选择器——结果每关闭一个 ticket 大约要 20 次 agent 运行，其中约四分之三是返工。他们自己的事后复盘把每一类失败都追溯回水平切片，而非追溯到实现。

在任何东西被发布之前会发生两件事。`to-tickets` 寻找预重构——"让改动变容易，然后做那个容易的改动"——并把那份工作排在最前。然后它把拆解结果作为一个带编号的列表呈现，并就它盘问你：粒度对不对、阻塞边是不是真实的、有没有什么该合并或拆开。在你批准之前没有任何东西抵达跟踪器，而那场盘问正是你回推的地方。

## 阻塞边

那些边是这个产物的重点所在。取决于跟踪器，它们有两种读法：

| 跟踪器 | 边存在于哪里 | 你如何处理它们 |
| --- | --- | --- |
| 本地 markdown | 文本，位于 `.scratch/<feature>/issues/<NN>-<slug>.md` 下每个 ticket 一个文件，按阻塞者优先编号 | 从上到下，手动 |
| 一个真实的跟踪器（GitHub、Linear） | 原生阻塞链接，或在跟踪器支持时用子 issue | 任何阻塞者都已完成的 ticket 就处在**前沿**，可以被抓取 |

无论哪种方式，边都存在于 ticket 里。媒介只决定是否有东西能并行地处理它们。`to-tickets` 产出这个产物；运行它——一次一个会话，或者一支舰队——是你的活，不是技能的。

## 宽重构例外

有一种形状打破曳光弹规则。一次**宽重构**是单个机械式改动——重命名一列、给一个共享符号重新定型——其**波及半径**扇形铺开覆盖整个代码库，所以一次编辑就弄坏成千个调用点，没有垂直切片能落地成绿。

`to-tickets` 改为把它排序为**展开–收缩**：

- **展开**——在旧形式旁边加上新形式，这样什么都不坏。
- **迁移**——分批把调用点迁移过去，批次按波及半径切（每个包、每个目录），每批一个 ticket，每个都被展开所阻塞。CI 保持绿色，因为旧形式仍然存在。
- **收缩**——一旦没有调用者残留，就删除旧形式，在一个被每个迁移批次所阻塞的 ticket 里。

在连批次都无法独自保持绿色的地方，它们共享一个集成分支，并全都阻塞一个最终的集成并验证 ticket。绿色只在那里被承诺。

## 常见问题

**它为一个三行的改动产出了十二个 ticket。**
过度分解是这个技能被报告最多的摩擦，而且它在从业者之间是一致的：[模型](https://www.aihero.dev/ai-coding-dictionary/model)默认切成原子单位，丢掉了那个能让它们有意义的分组。盘问步骤正是为此存在——让它合并，它就会。更深的答案是这些 ticket 有一个下限：如果整个改动放得进一个上下文窗口，你根本不需要这个技能。直接去 [implement](https://aihero.dev/skills-implement)。

**这些 ticket 出来是一层一个——所有 schema 在一个里，所有 API 在另一个里。**
这正是垂直切片规则所针对的失败，而技能有时仍会产出它。在盘问步骤抓住它，方法是对每个 ticket 问一个问题：这个做完后我能演示什么？一个没有答案的 ticket 就是水平切片。有些人为此给每个 ticket 加一行"演示路径"，并报告说这把模型推向垂直分解。

**在 GitHub 上这些 ticket 没有被创建为规范 issue 的子 issue。**
已知且未修复。它在十几次运行和好几个模型上被报告过，[最完整的是 issue #554](https://github.com/mattpocock/skills/issues/554)，而且在 Codex 上比在 Claude 上更糟。`gh` 自 v2.94 起原生支持这个：`gh issue create --parent <n>`，以及事后用 `gh issue edit <parent> --add-sub-issue <n>`。在跟踪器模板偏好那些之前，运行之后自己接上父链接才是可靠的做法。

**"Blocked by"被写进了 issue 正文，而不是一个真正的阻塞链接。**
同一类问题，[在 issue #513 中被报告](https://github.com/mattpocock/skills/issues/513)，其中 agent 甚至断言 GitHub 根本没有原生的阻塞关系。它有——`gh issue create --blocked-by 12,15`。因为阻塞者先被发布，它们的编号在创建时总是可用的。正文文本本意是给没有原生边的跟踪器的后备，而非默认。

**本地 ticket 放在哪里？v1.1 的说明说的是根级的 `tickets.md`。**
说过，而那是个 bug——一个单一的共享文件在并行 agent 写它时也会竞争。本地模式现在在 `.scratch/<feature-slug>/issues/<NN>-<slug>.md` 下每个 ticket 写一个文件，按依赖顺序，与本地跟踪器模板已经描述的布局相符。`NN` 前缀是一个真实的 ticket ID，所以 `/implement 03` 就能用，而不用重敲一个长标题。

**它在试图读我的规范时一直截断。**
一份非常大的规范可能超出一个跟踪器 issue 能干净返回的量，而且没有本地副本可以退回——agent 于是烧[工具调用](https://www.aihero.dev/ai-coding-dictionary/tool-call)反复抓取分块，永远到不了末尾。不要在 `/to-spec` 和 `/to-tickets` 之间[清空](https://www.aihero.dev/ai-coding-dictionary/clearing)或[压缩](https://www.aihero.dev/ai-coding-dictionary/compaction)。在同一个上下文窗口里运行它们，规范就根本不必被取回。

**验收标准什么都没评判——有些在任何工作做之前就通过了。**
模板要求标准，但对它们能否失败只字未提，所以这会发生。有三种形状反复出现：一个在基线提交时就已为真的标准、一个只能靠另一个 ticket 拥有的工作才能满足的标准、以及一个复述请求而非从产物推导的标准。垂直切片能防止其中大部分——一个交付此前不存在的行为的切片，从构造上就在基线提交时是红的——但这个检查值得手动做。对每个标准，命名那个能显示它为假的观察，并确认它在实现者出发的那个提交上失败。

**ticket 已经发布了。我究竟怎么运行它们？**
技能停在产物这里，没有自动派发模式。派发是手动的：看看看板，数一数没有未完成阻塞者的 ticket，然后开那么多个 agent 会话。一个新上下文一个 ticket，其间清空。要注意 [implement](https://aihero.dev/skills-implement) 在完成时不会可靠地关闭或勾掉 ticket，无论是在 GitHub 还是在本地 markdown，所以 ticket 的状态由你来更新。

## 它生效的标志

- 每个 ticket 对"这个做完后我能演示什么？"都有一个答案——而且答案是行为，不是一层。
- 在任何东西被发布之前，列表带着编号回到你这里，每个上面有一行"Blocked by"。
- 顶部那个 ticket 没有阻塞者，能立即开始。
- ticket 正文里没有任何东西是文件路径或行号，除了一段原型产出的片段。
- 每个 ticket 读起来都像是一个全新会话在你不在场的情况下就能完成的东西。
- 预重构，在它找到任何的地方，是排在顺序最前而非混进功能 ticket 里。

## 它的位置

`to-tickets` 是主构建链条里的一步：

```txt
grill-with-docs → to-spec → to-tickets → implement → code-review
```

上游是 [to-spec](https://aihero.dev/skills-to-spec)，它交给它一份敲定的规范去切分——把两者保持在一个不间断的上下文窗口里。下游是 [implement](https://aihero.dev/skills-implement)，它每个全新会话构建一个 ticket，驱动 [tdd](https://aihero.dev/skills-tdd) 做测试，并以 [code-review](https://aihero.dev/skills-code-review) 收尾。当你不确定哪个技能或流程合适时，[ask-matt](https://aihero.dev/skills-ask-matt) 为你做路由。
