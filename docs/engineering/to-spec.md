## 它做什么

`to-spec` 把你刚刚进行的对话变成一份 **[规范](https://www.aihero.dev/ai-coding-dictionary/spec)**，并作为单个 issue 发布到你的 issue 跟踪器。

它不会访谈你。当你使用它时，决定已经做完了，所以它综合已知的东西——来自对话线程、来自代码库、来自你的 `CONTEXT.md` 和 ADR——而不是开启新一轮提问。规范是一份对已经做出的决策的记录，而不是做出新决策的地方。

## 何时使用它

你通过输入 `/to-spec` 来调用它——[agent](https://www.aihero.dev/ai-coding-dictionary/agent) 不会自己去调用它。

当构建对单个 agent [会话](https://www.aihero.dev/ai-coding-dictionary/session)来说太大、必须能在被拆分到多个会话之间时存活时，使用它。这就是全部的触发条件：

| 你在哪里 | 运行什么 |
| --- | --- |
| 你还什么都没决定 | 先 [grill-with-docs](https://aihero.dev/skills-grill-with-docs) |
| 决定好了，而工作放得进一个[上下文窗口](https://www.aihero.dev/ai-coding-dictionary/context-window) | [implement](https://aihero.dev/skills-implement)——跳过规范 |
| 决定好了，而工作跨越多个会话 | `/to-spec`，然后 [to-tickets](https://aihero.dev/skills-to-tickets) |
| 一张 [wayfinder](https://aihero.dev/skills-wayfinder) 地图已经理清 | `/to-spec #<map_issue>` |

## 前置条件

`to-spec` 把规范作为一个 issue 发布，所以 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) 必须先为这个仓库配置好一个跟踪器和 triage 标签词汇。哪种都行：一个真实的跟踪器如 GitHub，或者 `.scratch/` 下的本地 markdown 文件，后者开箱即用受支持。

## 规范是一份决策记录

规范存在是因为上下文窗口会结束。你在 [grilling](https://www.aihero.dev/ai-coding-dictionary/grilling) 期间敲定的一切——解决方案的形状、你争论过的选择、你有意拒绝的东西——都在一场即将被清空的对话里。规范就是那场对话中存活下来的东西。

所以它不校验任何东西，也不决定任何东西。它捕获已经决定的东西，用你项目自己的词汇，好让一个全新的会话能接手工作而无需你重新解释。规范断言的任何你其实从没说过的东西都是一个缺陷。

## 接缝先于散文

在它写下一个字之前，`to-spec` 勾勒出这个功能将被测试所在的**接缝**，并与你核对。它偏好已经存在的接缝而非新的，并取它能取的最高接缝——一次改动上理想的数量是一个。

那些商定的接缝随后会传递。[tdd](https://aihero.dev/skills-tdd) 只在预先商定的接缝上工作，而 [code-review](https://aihero.dev/skills-code-review) 对照规范审查 diff，所以一个没人商定过的接缝会作为一条审查发现冒出来。这个绑定是间接的——它通过这份文档运行——而这正是为什么接缝这场对话值得在这里认真对待，而非推迟到实现阶段。

## 常见问题

**`/to-prd` 去哪了？**
它就是这个技能，在 v1.1 里被重命名了。"Spec"现在是唯一贯穿始终的术语，旧的 `to-prd` 别名作废了——用新名字重新安装。取代旧词汇的那一对是 *spec* 和 *tickets*：规范是目的地以及固定它的那些决策，[ticket](https://www.aihero.dev/ai-coding-dictionary/ticket) 是抵达那里的执行步骤。如果你转向，删掉未完成的 ticket，保留规范。

**规范为什么会得到 `ready-for-agent` 标签？我不想让 agent 照它去实现。**
这个标签的意思是"无需进一步 triage"——文档已经完整到足以让 agent 据以工作。它是一个输入标识，不是一个工作指令。但如果你运行会轮询 `ready-for-agent` 的 [AFK](https://www.aihero.dev/ai-coding-dictionary/afk) agent，那个区别对它们不可见，它们会乐呵呵地试图在一次运行里构建整份规范，而不是接手 ticket 切片。这是该技能被报告最多的粗糙之处。在它改变之前，在你的 AFK agent 提示里显式排除父规范，或者在 `/to-tickets` 跑完后剥掉那个标签。

**为什么不从 grilling 直接到 `/to-tickets`、跳过规范？**
你常常应该这么做——规范只在多会话工作上才对得起它这一步。它划算的地方在于 ticket 是一次性的而规范不是：每个 ticket 都被切成一个全新上下文窗口的大小，用完即删或关闭，而规范作为它们背后推理的唯一存放处保留。在单会话改动上这什么都买不到，而你还多付了一个综合步骤，[模型](https://www.aihero.dev/ai-coding-dictionary/model)可能在那里漂移。走 grilling → `/implement`。

**我刚做完一张 wayfinder 地图。我该喂给它什么？**
那个主地图 issue——`/to-spec #<map_issue>`，而不是单个的决策 ticket。[wayfinder](https://aihero.dev/skills-wayfinder) 产出的是决策而非交付物，散落在一张地图上；`to-spec` 是把它们坍缩成一份可构建文档的那一步。把地图直接绕进 `/implement` 就把那次坍缩扔掉了。

**规范是给我审查的，还是只给 agent 的？**
主要是给 agent 的，而且它读起来也是那样——完整、密集、大量引用。值得你亲眼看的部分是接缝和范围外小节，因为那是两个错误决策最便宜被抓住、且日后最昂贵被发现的地方。从头到尾读完整份东西是人们真实的抱怨，而且没有摘要模式：诚实的答案是，如果规范让你意外，那是 grilling 太浅，而非规范太长。

**ticket 开始后我该把规范冻结，还是让 agent 重写它？**
没有任何东西让它保持同步，所以实际上它是你在那一刻所知的一个快照，并且在实现第一次教会你某件事时就变得过时。工作发布后就把它当一次性的。意在比它更长寿的产物是你的 `CONTEXT.md` 和你的 ADR——如果实现期间学到的某件事值得长存，它属于那里，而非一份被编辑过的规范。

**我的工作是一次重构或一个模块边界，不是一个功能。这个模板合适吗？**
不太合适，而这是一个已知的局限。模板严重依赖用户故事，那对架构工作来说是错误的形状——你最终会围绕本质上关于接口和不变量的决策，写出没人要的故事。改为依赖实现决策和测试决策小节，并让那些持久的架构决定通过 [grill-with-docs](https://aihero.dev/skills-grill-with-docs) 落成 ADR，而不是试图让规范去承载它们。

**它会检查跟踪器里的相关工作、或引用它所尊重的 ADR 吗？**
两个都不会。它会读取并尊重覆盖它触及区域的 ADR，但它不链接它们，也不在起草前搜索跟踪器里重叠的 issue——所以一份规范可能悄悄重复某人已经提交的工作。如果那个区域很繁忙，先自己搜索跟踪器。

**`/to-tickets` 读不了我的规范——它一直在截断。**
非常大的规范可能超出一个跟踪器 issue 能干净地返回的量，而且没有本地副本可以退回。修复办法是上下文卫生：不要在 `/to-spec` 和 `/to-tickets` 之间[清空](https://www.aihero.dev/ai-coding-dictionary/clearing)或[压缩](https://www.aihero.dev/ai-coding-dictionary/compaction)。在同一个窗口里运行它们，规范就根本不必被重新抓取。

## 它生效的标志

- 它开始写作，而不是问你新一轮问题。
- 它在写作之前把接缝摆给你，并提议它能少提就少提的接缝数量。
- 它用你项目的名词回来，而不是通用的产品管理套话。
- 它里面的每个决策都是你能记得做过的。没有为了填满一个小节而发明什么。
- 范围外小节里有真实的东西——你拒绝掉的那些，通常是这一页上最有用的几行。

## 它的位置

`to-spec` 是主构建链条里的一步，而且只在它的多会话分支上：

```txt
grill-with-docs → to-spec → to-tickets → implement → code-review
```

它上游的邻居是 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)，做这个技能只记录的那些决定，以及 [wayfinder](https://aihero.dev/skills-wayfinder)，它完成的地图恰好在这里并入链条。下游，[to-tickets](https://aihero.dev/skills-to-tickets) 把规范切成曳光弹式的 ticket 供 [implement](https://aihero.dev/skills-implement) 构建。当你不确定哪个技能或流程合适时，[ask-matt](https://aihero.dev/skills-ask-matt) 为你做路由。
