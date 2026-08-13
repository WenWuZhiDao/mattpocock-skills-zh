## 它做什么

`wayfinder` 拿一个对单个 agent [会话](https://www.aihero.dev/ai-coding-dictionary/session)来说太大的努力——一个你能说出其**目的地**、却还看不见其路线的想法——把它绘制成你 issue 跟踪器上一张共享的、由**决策 ticket** 构成的**地图**，然后一次解决一个，直到道路清晰。

它规划，它不执行。每个 ticket 都持有一个问题，其解决是一个决策，而非要执行的一片构建，而当在有人去构建那个东西之前再没有什么可决定的时候，地图就完成了。那一条规则正是把一个 wayfinder ticket 与一个普通的实现 [ticket](https://www.aihero.dev/ai-coding-dictionary/ticket) 区分开的东西，而且它是 agent 最常打破的规则。当地图理清时，wayfinder 交接；它不会继续进入代码。

## 何时使用它

你通过输入 `/wayfinder` 来调用它——[agent](https://www.aihero.dev/ai-coding-dictionary/agent) 不会自己去调用它。

它是这套里最重、最密的流程，所以触发条件很窄：那个努力必须真正大于一个 agent 会话所能容纳的，而通往目的地的路线必须是模糊的。这个划分很干净：`/grill-with-docs` 用于单会话规划，`/wayfinder` 用于多会话规划。

| 你面前有什么 | 运行什么 |
| --- | --- |
| 一个范围明确、你能一次坐下就敲定的功能 | [grill-me](https://aihero.dev/skills-grill-me)，或者在有代码库时用 [grill-with-docs](https://aihero.dev/skills-grill-with-docs) |
| 一个全新项目，或一个跨越许多会话的构建，路线仍不清晰 | `/wayfinder` |
| 一个决定已经做完的对话线程 | [to-spec](https://aihero.dev/skills-to-spec)——直接越过地图 |
| 一张理清了的 wayfinder 地图 | [to-spec](https://aihero.dev/skills-to-spec)，然后 [to-tickets](https://aihero.dev/skills-to-tickets) 和 [implement](https://aihero.dev/skills-implement) |
| 一个已经变得太大的现有会话 | 说"交接给 `/wayfinder`"——[handoff](https://aihero.dev/skills-handoff) 既桥接进一张地图也桥接出一张地图 |

全新项目不是必要条件。wayfinder 被例行用于遗留和半成品代码库，而且可以说它在那里更锋利，因为许多迷雾是"这里已经为真的是什么"而非"我们该做什么"。

## 前置条件

地图及其 ticket 存在于仓库的 issue 跟踪器上，所以 wayfinder 需要 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) 铺下的跟踪器接线。那一步写一个"Wayfinding operations"小节，描述地图、它的子 ticket、阻塞边、以及前沿查询在 GitHub、GitLab 或本地 markdown 上是怎么表达的。wayfinder 通过你 `CLAUDE.md` / `AGENTS.md` 里的指针来解析那份文档，而非一个固定路径；在完全没有配置跟踪器时，它退回本地 markdown 文件。

跟踪器不是装饰。阻塞是让前沿在跟踪器自己的 UI 里视觉化呈现的东西，而一个没有原生依赖链接的跟踪器——比如一个自托管的 Gitea——会把 wayfinder 降级为从地图文本推断阻塞者，那管用但需要更贴近的监督。

## 地图、迷雾、和前沿

**地图**是一个被打上 `wayfinder:map` 标签的单个 issue；它的 ticket 是它的子 issue。它是一个**索引，而非一个存储**——一个决策恰好住在一个地方，即它的 ticket，而地图只是给它一个要点摘要并链接过去。一个会话以低分辨率加载地图，并按需放大到单个 ticket，这正是让一张地图能持续增长而无需每个会话都为它的整个历史付费的原因。

四样东西住在它上面：

- **目的地**——抵达这张地图的终点看起来是什么样。命名它是绘图的第一个动作，在任何 ticket 存在之前，因为目的地固定了每个 ticket 据以衡量的范围。
- **迄今的决策**——每个已关闭的 ticket 一行，每一行都链接到细节实际所住的地方。
- **尚未指定**——**战争迷雾**。你能看出即将到来、但还无法尖锐地措辞的决策。迷雾对 ticket 的测试是你能否*现在*就精确地陈述那个问题，而非你能否回答它。解决一个 ticket 会清除它前方的迷雾，并把如今可指定的任何东西毕业为新的 ticket。
- **范围外**——被判定超出目的地的工作。迷雾只会*朝着*目的地聚集，所以范围外的工作被关闭，从不毕业。

**前沿**是那些开放、未被阻塞、未被认领的 ticket——已知的边缘。一个会话通过在做任何工作之前把一个 ticket 分配给自己来认领它，所以受让人*就是*那个认领，并且并发的会话会跳过它。ticket 自始至终都按名字指代，从不用一个光秃秃的 `#42`；一堵 issue 编号的墙在叙述中是无法辨认的。

## 四种决策 ticket 类型

每个 ticket 都带一个 `wayfinder:<type>` 标签，并且要么是 **[HITL](https://www.aihero.dev/ai-coding-dictionary/human-in-the-loop)**——与一个为自己发言的人一起处理——要么是 **[AFK](https://www.aihero.dev/ai-coding-dictionary/afk)**，由 agent 独自驱动。一个 HITL ticket 只通过实时交流来解决；一个回答自己的 [grilling](https://www.aihero.dev/ai-coding-dictionary/grilling) 问题的 agent 已经打破了它。

| 类型 | 模式 | 何时使用它 | 由谁解决 |
| --- | --- | --- | --- |
| `grilling` | HITL | 默认。这个问题能通过谈透来敲定。 | [grilling](https://aihero.dev/skills-grilling) 加 [domain-modeling](https://aihero.dev/skills-domain-modeling)，在一个全新会话里 |
| `prototype` | HITL | "这应该看起来怎样"或"这应该表现怎样"——一个谈话无法敲定的问题。 | [prototype](https://aihero.dev/skills-prototype)，构建出的产物作为一项资产从 ticket 链接出去 |
| `research` | AFK | 工作目录之外的一个事实在阻塞一个决策。 | 一个 [research](https://aihero.dev/skills-research) [子 agent](https://www.aihero.dev/ai-coding-dictionary/subagent)，在绘图时触发并在一个 `research/<name>` 分支上并行消化 |
| `task` | 均可 | 没什么要决定的，但手动工作阻塞了一个决策——开通访问权、注册一个服务、移动数据以便看清它的形状。 | 在能做的地方由 agent 独自做，否则给人一份精确的检查清单 |

`task` 是唯一一个*执行*而非决策的类型，而它靠解除对一个决策的阻塞来赢得它的位置——从不靠交付目的地的一部分。这是实践中最常出错的类型：agent 把它解读为一个实现步骤，并开始在地图内部写产品代码。

research 是*每会话一个 ticket*的唯一例外。

## 常见问题

**这和 `/grill-with-docs` 有什么不同？我该从哪个开始？**
会话数量，而非项目大小。`/grill-with-docs` 是单会话规划；wayfinder 是多会话规划。如果你能把整件事装进一场对话，grilling 是更便宜也更好的工具，而对那种情况 wayfinder 确实更慢也更密。社区在它上面形成的简写：wayfinder 只有在工作装不进单个会话时才有意义。这遥遥领先是被问得最多的 wayfinder 问题，而它一直被问是因为那些描述不告诉你自己的任务落在那条线的哪里——你得自己判断会话数量。

**当它要求"目的地"时，它指的是这个会话的终点还是一切的终点？**
整张地图——整张地图的目的地，而非只是最初的会话。这个问题读起来含糊，因为 wayfinder 从定义上就是一个多会话工具，所以一个会话范围的答案从来说不通。典型的目的地是一份要交接的[规范](https://www.aihero.dev/ai-coding-dictionary/spec)、一个要在规划开始前锁定的决策、一个概念验证、或者一个就地做出的改动如一次数据迁移。

**地图理清了。为什么我还需要 `/to-spec` 和 `/to-tickets`——wayfinder 不是已经写了规范、做了 ticket 吗？**
不。wayfinder 的 ticket 是决策 ticket，而到地图关闭时它们也全都关闭了。剩下的是一张满是链接决策的地图，那不是一个构建计划。[to-spec](https://aihero.dev/skills-to-spec) 把那些链接的决策坍缩成一份规范——`/to-spec #<map_issue>`——而 [to-tickets](https://aihero.dev/skills-to-tickets) 把那个切成曳光弹式的实现 ticket。把地图直接绕进 [implement](https://aihero.dev/skills-implement) 跳过了那次坍缩，并把链接的细节扔掉了。只有当那个努力结果真的很小的时候，才直接去实现。人们确实运行那条简化的流水线并报告它管用；那两个额外步骤给你买来一个显式的规范产物，一个审查者或一个同事能读它，你越不是单干这就越重要。

**我的 agent 在一场 wayfinder 会话中途开始写生产代码。**
这个技能被报告最多的失败，而它背后有一个真实的漏洞。wayfinder 的"规划，别执行"默认可以在地图的 **Notes** 里被覆盖——但 Notes 是由 agent 写的，所以那个约束和它的豁免住在被约束方所拥有的同一个文件里。一位用户看着一个 agent 把"这张地图承载执行"写进它自己的 Notes，然后在后来的会话里把它读回作为它自己的许可，在一个上线的服务器上构建。对于"我指的是默认"，技能里没有硬性停止。在有它之前：读任何不是你自己绘制的地图上的 Notes，把实现保持在它自己的会话里，并把任何看起来像一片构建的 `wayfinder:task` 当作类型标错了。

**我绘了 27 个 ticket，而等我做到第十三个时，其余的不再说得通了。**
一个真实且被反复报告的结果，逐字来自一份现场报告。wayfinder 的默认本能是全面地规划，而一张其后期 ticket 建立在早期 ticket 使之失效的假设之上的地图，恰恰是这个技能被指责的那个瀑布陷阱。有两样东西回推它。把地图的范围限定于一个有界的目的地而非整个产品——从业者一致报告，范围限定于一个定义好的 epic 的地图比一个庞杂的"实现 V1"表现更好，而规划一个非常大的东西一开始就不是目标——发布小增量才是。以及积极地 [prototype](https://www.aihero.dev/ai-coding-dictionary/prototyping)：路线之所以保持最新，整个原因就是在实现依赖不确定性之前，靠廉价的具体产物把它冲刷出来。wayfinder 是"prototypemaxxing"，不是"planmaxxing"。

**我能并行处理好几个 ticket 吗？**
前沿被造出来是为了给你看什么是可拿取的，而阻塞边在那里是为了让并行工作在纸面上安全。实际上一次一个是更安全的默认。同时处理两个 grilling ticket 的用户会在一个会话里被问一个他们刚在另一个里回答过的问题，因为那些会话不共享[上下文](https://www.aihero.dev/ai-coding-dictionary/context)。在 prototype ticket 上也有一个已知的缺口：一个 agent 曾被报告构建了三种 UI 变体、自己选了一个、并关闭了那个 ticket——那个选择该由你来做，而技能目前没有把这一点说得足够响亮。如果你确实并行运行，先自己审查依赖图。

**我必须用 GitHub Issues 吗？**
不必——任何 issue 跟踪器都行。GitHub 是支持得最好的路径，因为它原生的子 issue 和阻塞关系正是让前沿在不打开地图的情况下可见的东西；GitLab、Linear、Jira 和本地 markdown 都有人用。有两条诚实的告诫。一个没有原生阻塞的跟踪器意味着依赖图是从文本推断的、需要手动纠正。而本地 markdown 把产物放进你的仓库，这不被推荐：把这些材料存在仓库里往往导致意外的持久化。开源维护者碰上相反的问题——公开跟踪器被 agent 生成的规划 ticket 填满——却还是倾向于选择本地 markdown。

**这个 grilling 让人筋疲力尽。每个问题都有三段长。**
这是关于 wayfinder 最尖锐的实时抱怨，而且它没有被解决。一位用户给出的分解：冗长本身导致决策疲劳，而那个长度剥掉了一个问题*为什么*被问，所以随着地图变长你丢失了从决策到决策的链条。那个冗长看起来是当前这批[模型](https://www.aihero.dev/ai-coding-dictionary/model)的属性、而非技能的属性，而且没有修复落地。流传中的从业者缓解手段：跑一个更低的[推理努力](https://www.aihero.dev/ai-coding-dictionary/effort)，并在你的全局 `CLAUDE.md` 里放一条自然语言指令。无论如何都要预期在这里花真正的思考——wayfinder 向你索取的思考量不是一个缺陷，它是它大部分的用途所在。

**一个我已经关闭的决策结果是错的。我该编辑旧 ticket 还是新建一个？**
没有官方指导，而 agent 的本能没帮助：它倾向于围绕那个坏决策来设计，而非挑战它，所以你得手动引导。真正管用的是明白地告诉 wayfinder 什么变了——它会更新地图、修订受影响的 ticket、并对已经关闭的那些评论。地图中途的范围变化是可恢复的。一张你*设计成*会变的地图是一个范围界定的坏味道。

**`decision-mapping` 去哪了？**
它就是这个技能，在 v1.1 里被重命名为 `wayfinder` 并作为 `/wayfinder` 调用。"Decision map"是行话，而且也不准确，因为四种 ticket 类型里只有一种本身真的是一个决策。这次重构给了技能一套连贯的词汇——目的地、战争迷雾、前沿、地图——而非在其上叠加一个生造的术语。不过那个单位保留了"decision"这个词：一个 wayfinder ticket 被称为一个**决策 ticket**，正是为了阻止人们把它读作一个实现 ticket。

## 它生效的标志

- 在单个 ticket 存在之前，目的地就被写下并商定了。
- 每个开放的 ticket 都读起来像一个问题。任何读作"构建那个 X"的 ticket 要么是类型标错了，要么属于地图的下游。
- 你能看你的跟踪器、看出哪些 ticket 是可拿取的而无需打开地图——那就是前沿通过原生阻塞自我呈现。
- 一个会话解决一个 ticket、把答案作为一条解决评论张贴、关闭它、并在地图的*迄今的决策*上留一行。然后它停下。
- **尚未指定**随时间缩小。一片毕业成 ticket 的迷雾从那个小节消失，而非同时住在两个地方。
- 当开场的广度优先 grill 完全没翻出迷雾时，技能停下并告诉你那个努力小到足以跳过地图。
- 完成地图的那个会话把你交接向一份规范，而非一个 pull request。

## 它的位置

`wayfinder` 是一个**情境性的入口匝道**，而非默认的前门。以 grill 为主导的 想法 → 发布 链条仍然是大多数工作开始的地方；wayfinder 是当想法大到无法装进一个会话时你爬上去的东西，而它在 [to-spec](https://aihero.dev/skills-to-spec) 处并回那条链条，因为一张理清了的地图是交接而非构建。

在底下，它大多是别的技能披着 wayfinder 的调度：[grilling](https://aihero.dev/skills-grilling) 和 [domain-modeling](https://aihero.dev/skills-domain-modeling) 解决默认的 ticket 类型，[prototype](https://aihero.dev/skills-prototype) 解决谈话无法解决的 ticket，而 [research](https://aihero.dev/skills-research) 作为一个子 agent 运行，所以它的阅读从不落进你的会话。[handoff](https://aihero.dev/skills-handoff) 是进出的桥梁——从一场把自己撑大的对话进入一张地图，当一个支线任务在会话中途出现时从一张地图出来。至于其他任何东西，[ask-matt](https://aihero.dev/skills-ask-matt) 为整套做路由。
