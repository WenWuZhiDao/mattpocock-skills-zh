快速开始：

```bash
npx skills add mattpocock/skills --skill=wayfinder
```

```bash
npx skills update wayfinder
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/wayfinder)

## 它做什么

`wayfinder` 接手一项大到一个智能体会话装不下的工作——笼罩在迷雾中，从此处到目标的道路尚不可见——把它绘制成你 issue 跟踪器上一张由**决策工单**构成的**共享地图**，然后一次一个地解决它们，直到道路清晰。它**做规划，不做执行**：每张工单解决的是一个决策——一个要敲定的问题，而非一片要执行的构建切片——当在有人去构建那样东西之前再没有什么可决定时，地图就算完成——所以它产出的是决策，而非交付物。

## 何时使用它

你通过输入 `/wayfinder` 来调用它——智能体不会自行触发它。

当一项工作**超出一个智能体会话所能承载**、而通往其**目的地**的路线仍然朦胧时——你能感到工作的形状却还写不成一份规格或计划——就用它。若要把一段*已经清晰*的思路变成规格，请用 [to-spec](https://aihero.dev/skills-to-spec)；若要把一个已经理解的计划切成可构建的工单，请用 [to-tickets](https://aihero.dev/skills-to-tickets)。Wayfinder 坐落在二者的上游：当迷雾太重、无法直接写规格时，你运行的就是它。

## 前置条件

地图及其工单活在仓库的 issue 跟踪器上，所以 wayfinder 需要 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) 铺设的跟踪器接线——它会播下一个"Wayfinding operations"小节，描述地图、子工单、阻塞和前沿查询在 GitHub、GitLab 或 local-markdown 中如何表达。缺了那份文档，wayfinder 默认使用一张 local-markdown 地图。

## 地图是索引，迷雾是前沿

**地图**是单个 `wayfinder:map` issue，其工单是它的子 issue——一个整个团队都能盯着看的共享 URL。它是**索引，而非仓库**：每个决策恰好活在一个地方（它的工单里），而地图只作要点摘录并链接，绝不重述。一个会话以低分辨率加载地图，并按需放大到单个工单。

在活跃的工单之外躺着**战争迷雾**——你能感到正在到来、却还无法锁定的决策。判断某样东西是工单还是仍是迷雾的检验标准，是你能否*此刻精确地陈述那个问题*，而不是你能否回答它。解决一张工单会清散它前方的迷雾，把如今可明确表述的东西**毕业**成新的工单。**前沿**是那些开放的、未被阻塞的、未被认领的工单——已知的边缘——这正是跟踪器原生的阻塞机制在视觉上所呈现的，于是你不打开地图就能看到什么是可取的。迷雾只*朝着***目的地**聚集；越过它的工作被判为**范围之外**，关闭，绝不毕业。

每张工单要么是 **HITL**（human in the loop，人在回路中——grilling、prototype），要么是 **AFK**（智能体独自处理——research）；一张 HITL 工单只通过一次实时交流来解决，所以智能体绝不自问自答。Research 仍是一张真实的工单——一个下游决策悬挂其上的共享阻塞者——但因为它是 AFK，一个会话不会停下来阅读：它发射一个 `/research` **子智能体**来并行地把工单烧掉，让前沿保持快速，并把发现捕捉到一条用完即弃的 `research/<name>` 分支上。

## 它生效的标志

- 命名**目的地**是第一个动作——早于任何工单存在——因为它锚定了衡量每张工单的范围。
- 一张地图就是一个 `wayfinder:map` issue；工单是它的子 issue，以**名字**指代，绝不用光秃秃的 `#42`。
- 一个会话**至多解决一张工单**（research 工单除外），把答案记录为一条解决评论，关闭工单，并向 *Decisions so far* 追加一行指针。
- 如果开场的拷问浮现出**没有迷雾**，它就停下来，告诉你这趟旅程小到可以跳过地图。

## 它的位置

`wayfinder` 是一条大构想的**入口匝道**：一项大到、雾到无法一次坐下来就写成规格的工作，生成一张清散过的决策地图，然后汇入主构建流程。当迷雾被推散、道路清晰时，交接给 [to-spec](https://aihero.dev/skills-to-spec) 去排布这场多会话的构建（或者，如果这项工作最后发现很小，就直接实现）。它倚赖 [grilling](https://aihero.dev/skills-grilling) 和 [domain-modeling](https://aihero.dev/skills-domain-modeling) 来解决单张工单，并倚赖 [prototype](https://aihero.dev/skills-prototype) 和 [research](https://aihero.dev/skills-research) 来处理需要它们的工单类型。当你不确定该用哪个技能或流程时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你指路。
