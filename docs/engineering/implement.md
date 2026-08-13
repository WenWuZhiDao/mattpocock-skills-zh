## 它做什么

`implement` 构建已经决定好的工作。你把它指向一个[工单](https://www.aihero.dev/ai-coding-dictionary/ticket)、一份[规格](https://www.aihero.dev/ai-coding-dictionary/spec)，或你刚在对话中商定的计划，它写代码、在接缝处驱动 [tdd](https://aihero.dev/skills-tdd)、边写边做类型检查、在结尾运行 [code-review](https://aihero.dev/skills-code-review)，并提交到当前分支。

它从不重启计划。没有访谈、没有澄清轮、没有对不同方案的提议。上游敲定的任何东西都是输入，而这个技能的全部工作就是把它变成一次提交。这正是它与对着一个全新[代理](https://www.aihero.dev/ai-coding-dictionary/agent)敲「构建这个」的区别——后者会乐呵呵地边构建边重新设计这项工作。

## 何时使用它

你通过输入 `/implement` 来调用它——代理不会主动使用它。它发布时带着 `disable-model-invocation: true`，所以其他任何技能也无法调用它。凡是 [ask-matt](https://aihero.dev/skills-ask-matt) 或 [to-tickets](https://aihero.dev/skills-to-tickets) 说「然后逐工单 `/implement`」的地方，那都是给你的指令，而非代理会不经提示就做的事。

工作当前在哪里，决定了这是不是对的技能：

| 工作是…… | 使用 |
| --- | --- |
| 追踪器上的一个工单 | `/implement #42`，每次[会话](https://www.aihero.dev/ai-coding-dictionary/session)一个工单，在工单之间[清空](https://www.aihero.dev/ai-coding-dictionary/clearing)上下文 |
| 一份规格，尚未拆分，且构建跨越多次会话 | 先 [to-tickets](https://aihero.dev/skills-to-tickets)，然后逐工单 `/implement` |
| 一份规格，且构建很小 | 直接对着规格 `/implement` |
| 只在你刚有的那场对话里，且它仍然很小 | 就在那儿、在同一个窗口里 `/implement` |
| 还没写在任何地方 | [grill-with-docs](https://aihero.dev/skills-grill-with-docs)，或者如果没有代码库则用 [grill-me](https://aihero.dev/skills-grill-me) |
| 一项你想测试先行、且没有规格的具体行为 | 直接 [tdd](https://aihero.dev/skills-tdd) |
| 已经构建好，你想检查它 | 直接 [code-review](https://aihero.dev/skills-code-review) |

同会话的情况值得点名，因为这个技能自己的第一行没覆盖它。`SKILL.md` 说「规格或工单」，这会把[模型](https://www.aihero.dev/ai-coding-dictionary/model)推去搜寻一个不存在的文件。如果计划只在线程里，就在调用时说明。

## 前置条件

`implement` 提交到你所在的分支。它不创建分支，也不询问。开始之前先确认你在你想让工作落在的那个分支上。

如果工单来自 [to-tickets](https://aihero.dev/skills-to-tickets)，它们所在的追踪器是由 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) 配置的。`code-review` 在收尾时读取同一份配置来找到发起它的规格。

## 一次运行做什么

一次运行是五拍，按顺序：

1. 读工单或规格，弄清接缝。
2. 在预先商定的接缝处驱动 [tdd](https://aihero.dev/skills-tdd)，一次一个红绿切片。
3. 频繁做类型检查，边走边跑单个测试文件。
4. 在结尾把完整测试套件跑一次。
5. 运行 [code-review](https://aihero.dev/skills-code-review)，然后提交到当前分支。

一次运行覆盖一个工单。[to-tickets](https://aihero.dev/skills-to-tickets) 产出的工单是曳光弹式的垂直切片，其大小恰好装进一个全新的[上下文窗口](https://www.aihero.dev/ai-coding-dictionary/context-window)，所以设想的节奏是：清空上下文、实现一个工单、提交、再次清空。每个工单都是自包含的，这正是让上一个工单的上下文可丢弃的原因。

## 预先商定的接缝

这个技能赖以运行的概念是**接缝**：你在其上观察行为、而不伸手进去的公共边界。测试住在接缝处。在任何代码写下之前就商定好的接缝处工作，正是让测试经久耐用的原因，因为其下的实现可以被重写而测试不必移动。

「预先商定」这个词在真正起作用，它也是这个技能最弱的关节。`implement` 内部没有任何东西商定接缝。`tdd` 才是发问的那个技能，而它拒绝在一个未确认的接缝处写测试。所以实际上，商定要么发生在上游的规格里，要么发生在运行的第一次交流里。如果哪里都没发生，这个前置条件就永远不触发，运行悄悄地变成「就把代码写了」。在规格里给接缝命名正是阻止那样的做法。

## 常见问题

**它完成了，但我的工单还开着，验收标准也还没勾。**

正确，且在预料之中。`implement` 没有完成步骤。它止于提交，从不碰工作项，这在 GitHub Issues 和本地 markdown 追踪器上都得到确认，所以这不是追踪器集成问题。它也不对 `code-review` 产出的发现采取行动，也不勾选发起它的 issue 上的 `- [ ]` 框。自己去关闭工单、核对标准。这在一条依赖链上咬得最狠，因为 `to-tickets` 把前沿定义为其阻塞项全部关闭的工单。如果什么都没被关闭，就永远没有什么会显式地变成解除阻塞。

**我能一次把它指向我所有的工单，或并行跑好几个吗？**

不能。一次调用，一个工单。跨工单队列的批量派发和[子代理](https://www.aihero.dev/ai-coding-dictionary/subagent)扇出都被反复要求，而两者都不存在。在一个检出里并排跑好几个 `/implement` 会话比不受支持更糟：一份现场报告描述了一个会话里的 `git commit --amend` 落到了另一个会话的提交上、一个 stash 从 `refs/stash` 里消失、以及提交落到了错误的分支上，全都在一个下午横跨三个 issue 里发生。这些会话共享一个工作目录、一个索引、一个 HEAD。Git worktree 是社区的绕行之法，且请注意 `refs/stash` 在 worktree 之间也是共享的，所以单靠 worktree 并不能修复 stash 那种情况。如果你今天想要并行，那是你自己在拼装它。

**它能开一个 pull request 而不是提交吗？**

未内置。它径直提交到当前分支，好几个人觉得这太急切：代码在他们有机会验证它是否工作之前就落地了。没有配置开关，也没有 PR 模式。人们在调用里覆盖它（「提交到一个分支并开一个 PR」），或者通过编辑他们本地的技能副本来做。

**`code-review` 说它看不到我的改动。**

`code-review` 评审的是 `git diff <固定点>...HEAD`，它排除已暂存和工作区的改动。`implement` 在提交之前运行它，所以除非已有一次中间提交，否则那个差异里没有东西可评审。多人报告过此事，且两边都未修复。先提交，再对着你分叉出来的那个点评审。

另外，有些人刻意根本不想在运行内部做评审，因为一个评审自己刚写的代码的代理会偏向自己的解法。在一个全新会话里对着一个固定点运行 [code-review](https://aihero.dev/skills-code-review) 是一个正当的替代，也正是那个技能在独立子代理里跑它两个维度的同一原因。

**一个工单烧掉了 15 万 token。我用错了吗？**

多半是工单太大，而非技能被误用。一次运行会做代码库探索、每个接缝一个红绿循环、一次完整套件、以及一次评审，所以一个非平凡的工单超过 10 万 [token](https://www.aihero.dev/ai-coding-dictionary/token) 是正常的，而非哪里坏了的迹象。杠杆在上游：在 [to-tickets](https://aihero.dev/skills-to-tickets) 里把工单调到合适大小，好让每个都装进一个全新窗口。如果单个工单老是爆掉，就拆分它，而不是抬高[努力度](https://www.aihero.dev/ai-coding-dictionary/effort)水平。

**在一个全新会话里 `/implement #2` 却干了一件完全不相关的事。**

`#2` 是对着代理能看到的任何带编号的列表来解析的，在一个全新会话里那可能是一个 todo 文件、一个清单，或另一份工作列表，而非已配置的追踪器。这个解析是自信的、而非默认失败关闭的，所以错误在它已经开始之前并不明显。传入完整引用，即 issue URL 或 `owner/repo#2`，并要它在开始之前把标题回读给你确认。

## 它生效的标志

- 会话以读工单或规格、并复述它将构建什么开场，而不是问你要构建什么。
- 你能在轨迹里看到一次实际的 `/tdd` 调用，而不只是测试在差异里冒出来。
- 类型检查和单个测试文件在运行期间反复运行，完整套件在临近结尾时跑一次。
- 运行在你无需提示它继续的情况下抵达一次在你当前分支上的提交。
- 差异是一个工单量的改动：一个穿过每一层的垂直切片，而不是好几个工单被一并扫进来。

## 它的位置

`implement` 是主链的构建步骤，倒数第二：

```txt
grill-with-docs → to-spec → to-tickets → implement → code-review
```

它的邻居是 [to-tickets](https://aihero.dev/skills-to-tickets)（它产出 `implement` 消费的工单，并声明决定其顺序的阻塞边）、[tdd](https://aihero.dev/skills-tdd)（它在每个接缝处内部驱动的那个）、以及 [code-review](https://aihero.dev/skills-code-review)（它在提交前运行的那个）。它位于规划技能的下游并信任它们。它不重新验证交给它的东西的形状，所以一张结构糟糕的地图或一个横向分层的工单会被照原样构建。

那份信任正是 [wayfinder](https://aihero.dev/skills-wayfinder) 在 [to-spec](https://aihero.dev/skills-to-spec) 处汇入主链、而非把它的地图直接绕进 `implement` 的原因。只有当工作最终确实很小时，才从一张地图直接去 `implement`。

当你不确定自己在哪条流程里时，[ask-matt](https://aihero.dev/skills-ask-matt) 是凌驾于整套技能之上的路由器。
