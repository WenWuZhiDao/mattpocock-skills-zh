## 它做什么

`codebase-design` 固定你用来设计模块的那些词：**模块（module）**、**接口（interface）**、**深度（depth）**、**接缝（seam）**、**适配器（adapter）**、**杠杆（leverage）**、**局部性（locality）**。它精确定义每一个，禁用宽松的替代词（「组件」「服务」「API」「边界」），并陈述由它们推导出的那少数几条原则。

它是一份参考，而非一个流程。没有要跑的循环、没有它产出的产物、没有它向你提问的检查点。其他每一个触及设计的技能都借用它的词汇；就它自身而言，它给你语言，然后停下。这是你在调用它之前该知道的事，因为一个没有流程、没有停止规则的技能，如果你把一次[会话](https://www.aihero.dev/ai-coding-dictionary/session)指向它并说「开始」，它就会即兴编一个出来——见下面的问题。

## 何时使用它

输入 `/codebase-design`，或者当某个设计任务契合时，代理会自动使用它。

当你已经知道自己在重新设计哪段代码、并需要思考它的形状时，就使用它：接缝放在哪里、接口能小到什么程度、一次抽取是否物有所值。它也是你用来了结「某个词是什么意思」的争论时所使用的东西。

有几个技能与它相邻。你想要哪一个取决于真正的问题是什么：

| 问题 | 技能 |
|---|---|
| 单个模块的形状——它的接口、它的接缝、它的深度 | `codebase-design` |
| *领域的词语*——「account」有三种含义、两个人说「cancellation」时各指不同的东西 | [domain-modeling](https://aihero.dev/skills-domain-modeling) |
| 你还不知道该重新设计*哪个*模块 | [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture)——找出候选者的普查 |
| 你想让设计被论辩，而不只是被命名 | [grilling](https://aihero.dev/skills-grilling) |
| 有一项具体行为要构建，而你想要能挺过重构的测试 | [tdd](https://aihero.dev/skills-tdd) |

## 词汇

术语表就是这个技能。每个术语都对照其他术语来定义，且每个都附带它所取代的那个词。

| 术语 | 含义 | 不要说 |
|---|---|---|
| **模块** | 任何具有接口和实现的东西。刻意与规模无关——一个函数、一个类、一个包、一个跨层的切片。 | 单元、组件、服务 |
| **接口** | 调用者为正确使用它而必须知道的一切：类型签名，外加不变量、顺序约束、错误模式、必需配置、性能特征。 | API、签名 |
| **深度** | 接口处的杠杆——调用者或测试每学习一单位接口，能施展多少行为。**深**：小接口背后有大量行为。**浅**：接口几乎与实现一样复杂。 | — |
| **接缝** | Michael Feathers 的术语：一个你无需在该处编辑就能改变行为的地方。它是接口的*位置*，而把它放在哪里是它自己的一项决定，与它背后放什么相分离。 | 边界 |
| **适配器** | 在某接缝处满足某接口的一个具体之物。命名的是角色，而非实体——内存中的伪造件和一个 Postgres 仓库都是适配器。 | — |
| **杠杆** | 调用者从深度中所得：每学习一单位接口就获得更多能力。 | — |
| **局部性** | 维护者从深度中所得：变更、bug 与验证都集中在一处。一次修复，处处修复。 | — |

深度刻意*不*定义为实现行数与接口行数之比，那是 Ousterhout 本人的定义。该指标会鼓励往实现里灌水。这里改用「深度即杠杆」。

## 四条原则

- **深度是接口的属性，而非实现的属性。** 一个深模块内部可以由可替换的小部件构建而成。它们只是不浮现给调用者。一个模块可以有其自身测试所用的内部接缝，以及其接口处的一个外部接缝。
- **删除测试。** 设想把这个模块删掉。如果复杂性随之消失，它就是个直通件。如果复杂性在 N 个调用者中重新冒出来，它就是物有所值的。
- **接口就是测试面。** 调用者和测试穿过同一道接缝。如果你想测试接口*之后*的东西，那这个模块的形状就错了。
- **一个适配器意味着假想的接缝。两个适配器才意味着真实的接缝。** 在真有东西跨越它而变化之前，不要切出一道接缝。单适配器的接缝只是一层间接。

两份支撑文件走得更远，技能是按需读取它们而非一上来就读。[DEEPENING.md](https://github.com/mattpocock/skills/blob/main/skills/engineering/codebase-design/DEEPENING.md) 对候选者的依赖分类——进程内、本地可替换、远程但自有、真正外部——因为类别决定了被加深的模块如何跨其接缝进行测试。[DESIGN-IT-TWICE.md](https://github.com/mattpocock/skills/blob/main/skills/engineering/codebase-design/DESIGN-IT-TWICE.md) 会拉起并行[子代理](https://www.aihero.dev/ai-coding-dictionary/subagent)，为同一个模块产出三个或更多截然不同的接口，然后就深度、局部性和接缝放置来比较它们。

## 常见问题

**我到底如何用 TypeScript 构建一个深模块？**

这是关于这个技能被问得最多的问题，而这个技能并不回答它。它定义了深模块*是什么*；它对如何阻止一个游离的 import 越过接口只字不提。[Issue #458](https://github.com/mattpocock/skills/issues/458) 说得很直白：「假设我们对接口满意了，它隐藏了细节等等。但我们如何强制执行它？我认为，没有 linting 或清晰的护栏，人类和 LLM 都会随时间把它搞乱。」Matt 在那个帖子里的回答是三个选项：把它裹进一个类或 IIFE，并接受这个类会变得庞大；把它做成 monorepo 里的一个包，并接受 monorepo 的工具链；或者用像 [dependency-cruiser](https://github.com/sverweij/dependency-cruiser) 这样的 linter 来禁止绕过接口的 import。他另外还称 Effect 是最好的机制，dependency-cruiser 是次好的。仓库的 `in-progress/` 桶里有一个 `setup-ts-deep-modules` 技能，它铺设了一套 `src/packages/<name>/index.ts` 约定，但它是一个 beta 通道技能，没有文档页，也没有随之附带的 lint 规则。

**我把一次会话指向它，它烧掉了 10 万 [token](https://www.aihero.dev/ai-coding-dictionary/token) 去重新设计我从没问过的东西。**

已知，并作为 [issue #449](https://github.com/mattpocock/skills/issues/449) 归档。这个技能是模型调用型且自称是词汇，但它内部没有任何东西硬性阻止代理把它当作一个可运行的流程。当被告知「在 /codebase-design 里恢复并推进开放的决策」时，一个代理伸手去够它能找到的最像动作的内容——`DESIGN-IT-TWICE.md` 里的并行子代理——重新探索了上一次会话已经映射过的代码，并且跑了很远才问任何问题。一个驱动型技能所具备的护栏（检查点、一次一个问题、不自动推进）在这里一个都没有，因为参考没有这些。绕行之法是指名一个驱动型技能，让这个技能坐在它下面：以 `/grill-with-docs`、`/improve-codebase-architecture` 或 `/tdd` 作为驱动，把 `codebase-design` 作为词汇。该 issue 仍开放。

**`design-an-interface` 去哪了？还有，有没有一个 `/interface-design` 技能？**

`design-an-interface` 已被移除并并入本技能。什么都没丢：它的「设计两次」技术——出自 Ousterhout，由并行子代理生成截然不同的设计——在这里以 `DESIGN-IT-TWICE.md` 发布。另外，有好几个人要求过一个专门针对深模块/薄接口哲学的 `/interface-design` 技能；那套哲学已经在这里了，也没有计划做单独的技能。如果你是来找这两个名字之一的，就是这个页面。

**这难道不是一套文件结构约定吗——文件夹、桶文件、功能切片？**

不是，而且这个技能在反复的回怼下守住了这条线。[Issue #95](https://github.com/mattpocock/skills/issues/95) 提议把一套形式化的分形树文件结构作为深模块的具体实现；回复是二者是正交的——「深模块讲的是接口的设计以及通过严格接口进行访问，无论文件系统长什么样。完全可能出现用这种方法却是浅模块的情况。」同样的问题在 #458 里又出现：「我觉得你可能把模块这个概念和文件系统绑得太紧了。文件系统当然可以作为模块形状的有用提示，但构建深模块并不需要用到文件系统。」词汇表刻意把**模块**定义为与规模无关。

**`tdd` 真的用了这套词汇吗？**

现在用了。很长一段时间它没用。曾经内嵌在 `tdd` 里的深模块笔记在 v1.0 里被移除，改用这个共享技能，但取代它们的那个指针从未被加上——于是 `tdd` 自己定义了「seam」而没引用任何东西。这个缺口已被补上：指针现在在技能里了，当接口的形状而非测试成为待解问题时就会被触及。`tdd` 仍然拥有「seam」作为你*进行测试*所在的边界；本技能拥有它背后的模块形状。

**设计两次的模式在 Claude Code 之外能用吗？**

不干净。`DESIGN-IT-TWICE.md` 说「用 Agent 工具并行派生 3 个以上子代理」，那是 Claude Code 的[工具](https://www.aihero.dev/ai-coding-dictionary/tool)，用的是 Claude Code 的叫法。仓库为其他[载体](https://www.aihero.dev/ai-coding-dictionary/harness)（包括 Codex）附带了元数据，而那些载体在那个名字下可能什么都不暴露——所以并行设计阶段的可移植性不如技能元数据所暗示的那么好。追踪于 [issue #564](https://github.com/mattpocock/skills/issues/564)，开放中。

**我能把自己的概念加进词汇表吗——连接性（connascence）、模块秘密、[渐进式披露](https://www.aihero.dev/ai-coding-dictionary/progressive-disclosure)？**

有人提议的正是这些。[Issue #180](https://github.com/mattpocock/skills/issues/180) 加入 Parnas 的模块秘密和 Page-Jones 的连接性，作为为*什么*在跨接缝泄漏而命名的一层，并附带了一份可用的差异；[issue #303](https://github.com/mattpocock/skills/issues/303) 提议在实现内部做渐进式披露，好让一个在其公开接口处很深的模块，其底下不是一整块未加区分的板砖。两者都开放且未合并。已发布的词汇表是刻意精简的，而它保持精简的原因在技能本身里就有陈述：一致的语言就是全部意义所在，而一个没人一致使用的术语比没有术语更糟。

## 它生效的标志

- 设计对话不再产出「组件」「服务」「边界」这些词，而开始产出「模块」「接口」「接缝」。
- 有人能指着一个提议的抽取，毫不含糊地说出它是否通过删除测试。
- 一个提议的接缝会附带指名第二个适配器，而不只是第一个。
- 对某个接口的讨论会覆盖不变量、顺序和错误模式——而不只是类型签名。
- 调用它不会启动一次会话。如果代理仅凭 `/codebase-design` 就开始读文件并提出重构，那它就把参考错当成了驱动。

## 它的位置

`codebase-design` 是一个**随时可用的独立技能**，是工程类技能之下的词汇层，而非任何链条中的一步。它最近的邻居是 [domain-modeling](https://aihero.dev/skills-domain-modeling)，那是针对*问题领域*的词语而非模块形状的对应参考——二者通常需要一起用，因为把一个深模块命名好需要两者兼备。另一个邻居是 [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture)：它普查一个代码库以寻找可加深的候选者，并把每一个都用这套词汇写下来，所以它找出模块，而本技能是你据以设计它的工作台。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
