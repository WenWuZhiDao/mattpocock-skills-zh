# mattpocock-skills

## 1.1.0

### Minor Changes

- [#406](https://github.com/mattpocock/skills/pull/406) [`930a450`](https://github.com/mattpocock/skills/commit/930a450089f77a49af09001d955db8452a4b867d) 感谢 [@mattpocock](https://github.com/mattpocock)！——让 **`ask-matt`** 路由器跟上完整的技能集。它现在映射了之前缺失的五个技能：**`tdd`**（作为 `implement` 驱动的红-绿引擎织入主流程）、**`diagnosing-bugs`**（一个新的"有东西坏了"的入口——此前没有 bug 的路由）、**`domain-modeling`** 和 **`codebase-design`**（一个新的"底层的词汇"章节），以及 **`grilling`**（共享的访谈原语）。`prototype` 被充实为一个独立技能，描述也从"用户调用型技能"拓宽为"这些技能"。`CLAUDE.md` 中加入了一条维护规则，让未来任何技能的添加／重命名／移除或流程变更都触发一次 `ask-matt` 复查，与既有的文档页重新同步规则并列。

- [#464](https://github.com/mattpocock/skills/pull/464) [`639df6e`](https://github.com/mattpocock/skills/commit/639df6e7386dfddc739b2aecdeff37a876f2483b) 感谢 [@mattpocock](https://github.com/mattpocock)！——推广并加固 **`code-review`**。进行中的 **`review`** 技能被重命名为 **`code-review`**，并从 `in-progress/` 移入 `engineering/`：它现在随插件发布，被列入顶层与 Engineering README（模型调用型），并在 `docs/engineering/code-review.md` 有一个文档页。`/implement` 技能和文档都指向 `/code-review`。

  它还在其 Standards 轴上获得了一个常开的 **Fowler 坏味道基线**——一份精选的约 12 个高信号的"代码中的坏味道"（神秘命名、重复代码、依恋情结、数据泥团、基本类型偏执、重复的 switch、霰弹式修改、发散式变化、夸夸其谈通用性、过长的消息链、中间人、被拒绝的遗赠），内联进 `SKILL.md` 作为一个固定基线，与仓库所记录的任何内容并存，而不是一个新的第三轴。两条约束性规则保证它的安全：仓库中记录的标准优先于基线，且每个坏味道都作为一个判断性意见来报告，而绝不是一个硬性违规。

- [#464](https://github.com/mattpocock/skills/pull/464) [`639df6e`](https://github.com/mattpocock/skills/commit/639df6e7386dfddc739b2aecdeff37a876f2483b) 感谢 [@mattpocock](https://github.com/mattpocock)！——从两个方面磨砺 **`grilling`**。

  **一个确认关卡。** 代理在你确认已达成共识之前不会执行计划——把技能既有的"达成共识"完成标准变成一个明确的停止关卡。`description` 还调用了预训练的 **`grill`** 领头词（"无情地拷问用户"）来磨砺调用，文档页也已重新同步。

  **事实 vs. 决策。** Grilling 现在把_事实_（去查它们——探索代码库）与_决策_（把每一个交给人并等待他们的回答）区分开来。旧的那条一刀切的话——"如果一个问题可以通过探索代码库来回答，那就去探索代码库"——是为面对真人的情形写的，但一旦另一个技能在"解决工单"的框架下运行 grilling，它就被读成了也可以自主回答_决策_的许可。把两者分开，就能防止一个 grilling 代理抢跑、自问自答。

- [#463](https://github.com/mattpocock/skills/pull/463) [`af6d692`](https://github.com/mattpocock/skills/commit/af6d6922c3e2b5288eef155346cbe319e4ed3bd0) 感谢 [@mattpocock](https://github.com/mattpocock)！——给 **`writing-great-skills`** 添加两个相邻的 Steering（引导）失败模式，两者都关乎你以为"关掉了"的语言其实仍在引导代理。**Negation（否定）**——那头_大象_——是通过禁止来引导：点名_不要_做什么，反而把被禁止的行为拽进了上下文，让它_更_容易被想到，而不是更少（_别去想一头大象_），所以解药是去提示**正面的**行为。**Negative Space（负空间）**——那片虚空——是对"你所省略的东西"所做引导的盲视：一个技能所回避的每个决策，都是被委托给了代理的先验，而不是被留作中立，所以解药是读一份草稿时读它的沉默，并刻意地决定每一处省略（填上它，或作为一个真正的**分岔**留待开放）。保留为两个条目而非一个——它们带有不同的诊断和不同的解药——各自是一条完整的 `GLOSSARY.md` 条目加一条 `SKILL.md` 失败模式要点，与其他每个失败模式的承载方式一致。

- [`850873c`](https://github.com/mattpocock/skills/commit/850873cd73d5f81826ebf512ad35d2b1e113001f) 感谢 [@mattpocock](https://github.com/mattpocock)！——让 **`prototype`** 技能变为模型调用型，这样代理可以自主地伸手去用它（其他技能也可以）。它的描述围绕领头词 _prototype_ 重写——回答一个设计问题的一次性代码——每个分支带一个触发条件（状态／逻辑合理性检查，或 UI 探索）。

- [#409](https://github.com/mattpocock/skills/pull/409) [`0d74d01`](https://github.com/mattpocock/skills/commit/0d74d01cbc64ca27778a49b38599f70c534e76a0) 感谢 [@mattpocock](https://github.com/mattpocock)！——添加 **`research`** 技能——一个小巧的、模型调用型的技能，它启动一个**后台代理**，针对**一手来源**（官方文档、源代码、规范、第一方 API）调查一个问题，然后在仓库存放此类笔记的任何位置留下一个带引用的 Markdown 文件。这是可委派的阅读跑腿活：你继续工作，它去读，然后你拿回一份文档来拷问、规划或据以设计。已列入顶层和 Engineering README（模型调用型），已加入 `.claude-plugin/plugin.json`，在 `docs/engineering/research.md` 给了一个文档页，并在 `ask-matt` 中作为一个独立技能路由。

- [#469](https://github.com/mattpocock/skills/pull/469) [`a0329ba`](https://github.com/mattpocock/skills/commit/a0329ba95751f58566ed7ab484475917a68f1629) 感谢 [@mattpocock](https://github.com/mattpocock)！——把 **`to-issues`** 技能拆分为精简的 **Process** 和一个 **Reference** 章节，并教会它处理一次**宽泛重构**——一个单一的机械性变更（比如重命名一个列），其**波及范围**扇形扩散到整个代码库，一次性破坏成千上万个调用点，以致没有哪个垂直切片能够绿灯落地。起草步骤现在指向两个同处一地的参考块：用于普通曳光弹的**垂直切片规则**，以及**宽泛重构**——它用**扩展-收缩**来切分变更（在旧形式旁扩展出新形式，按波及范围大小分批迁移调用点，然后收缩掉旧形式），使 CI 逐批保持绿灯——或者，当做不到时，只在最后一个集成并验证的 issue 处才不绿。issue 正文模板也移入了 Reference。

- [#464](https://github.com/mattpocock/skills/pull/464) [`386d4ff`](https://github.com/mattpocock/skills/commit/386d4ff719a7c420ad1454232d0436b01f1b8c17) 感谢 [@mattpocock](https://github.com/mattpocock)！——统一各个规划技能。**`to-prd` 被重命名为 `to-spec`**——"spec" 现在是唯一贯穿始终的术语（它仍以"你可能把这份文档称作 PRD"开头以便被发现）。**`to-plan` 和 `to-issues` 被合并为一个 `to-tickets` 技能，`to-issues` 被删除。**

  `to-tickets` 把一个计划、规范或对话拆解成一组**工单**——曳光弹式的垂直切片，每个都声明它的**阻塞边**。这一件制品有两种读法，取决于 `/setup-matt-pocock-skills` 配置了哪种跟踪器：一个**本地文件**（`tickets.md`）把这些边写成文本，你自上而下手动推进它；一个**真实跟踪器**把它们写成原生的阻塞链接，于是任何阻塞项都已完成的工单就处在前沿上，多个代理可以同时开工。无论哪种方式，边都存在工单里——媒介只决定是否有东西去并行地对它们采取行动。

  发布优先使用跟踪器的**原生子问题**来表达父 → 切片，用**原生阻塞边**表达 `Blocked by`（在跟踪器支持的地方），并保留 `## Parent` / `## Blocked by` 正文章节作为后备。"What to build" 模板指向 `/prototype` 的代码所在之处，而不是从中内联一段片段。

  `ask-matt` 的主流程现在路由 `idea → /to-spec → /to-tickets → /implement`，并有面向人的文档页 `docs/engineering/to-spec.md` 和 `docs/engineering/to-tickets.md`。

- [#464](https://github.com/mattpocock/skills/pull/464) [`0557d57`](https://github.com/mattpocock/skills/commit/0557d57579d9b3d39839fdaf8d4a6542b17539ce) 感谢 [@mattpocock](https://github.com/mattpocock)！——把 wayfinder 在文档中的位置确定为一个**情境性入口**，而非新的主入口流程——以 grill 为主导的 _idea → ship_ 链条仍是正门（把 wayfinder 加冕为默认主干是一个 v2 级别的动作，不是 1.1 的份内事）。**`ask-matt`** 路由器现在点明了 wayfinder 的具体触发条件——一个全新项目，或一次庞大的功能构建，大到一次会话装不下——而两个 grill 正门（**`grill-me`**、**`grill-with-docs`**）会向_上_指引至 wayfinder，用于那种一次会话装不下的工作，好让这个入口从读者实际起步的地方就能被发现。

- [#464](https://github.com/mattpocock/skills/pull/464) [`639df6e`](https://github.com/mattpocock/skills/commit/639df6e7386dfddc739b2aecdeff37a876f2483b) 感谢 [@mattpocock](https://github.com/mattpocock)！——毕业并重构 **`wayfinder`**——那个用来规划一大块工作、超过单次代理会话所能容纳的技能。它从 `in-progress/` 移出进入 `engineering/`（插件条目、顶层 + Engineering README 中列于**用户调用型**下、`docs/engineering/wayfinder.md` 的文档页，以及 `ask-matt` 中的一条路由），作为一个成熟的技能落地。让它得以走到这一步的重命名与重构：

  - **`decision-mapping` 被重命名为 `wayfinder`**，以 `/wayfinder` 调用。"决策地图"既行话又不准确——实际上只有一种工单类型是决策。这次重构改为在一个迷雾般的问题中标绘出一条路线，给出一个连贯的领头词框架——**战争迷雾**、**前沿**、**地图**——而不是在其上叠加一个生造的术语。
  - **以目的地作为领头词。** Wayfinding 是找到通往一个目的地的_路_；它不会一头冲去构建它。命名目的地是标绘的第一步——它固定了范围并塑造每一个工单——所以地图获得了一个 `## Destination` 字段，每次会话都以它为准，而 triage 在任何工单存在之前就先钉住它。
  - **规划，别动手。** 地图产出的是**决策，而非交付物**；当在有人开始构建那东西之前已无任何待决之事时，它就完成了。一项工作可以在它的 Notes 中覆盖这一点。
  - **地图是索引，不是仓库。** 一个决策只存在于恰好一个地方——它的工单——所以地图只做要点概括并链接，绝不复述；把迷雾毕业为一个工单会清除毕业掉的那块，这样没有东西滞留在两处。
  - **默认协作。** 地图从一个本地 Markdown 文件搬到仓库的问题跟踪器上：一个单一的 `wayfinder:map` issue，其工单是它的子 issue——一个团队可以观看的共享 URL。会话以低分辨率加载地图，并按需放大到具体工单。Wayfinder 保持跟踪器无关（GitHub、GitLab、本地 markdown），藏在 `docs/agents/issue-tracker.md` 的一个指针之后，而 `setup-matt-pocock-skills` 播种"Wayfinding operations"章节。
  - **靠指派而非标签认领。** 一次会话通过把工单指派给驾驶的开发者来认领它——受指派人_就是_认领——从而把标签词汇解放为仅 `wayfinder:<type>`。
  - **原生阻塞。** 阻塞优先使用跟踪器的原生依赖关系，它在跟踪器自己的 UI 里把前沿可视化地呈现出来，于是人无需打开地图就能看到哪些是可取的。GitHub 和 GitLab 模板写明了原生做法，并有一个正文约定的后备。
  - **迷雾 vs. 范围之外，分开。** 两个明白命名的地图章节——`## Not yet specified`（范围内的迷雾，随前沿推进而毕业）和 `## Out of scope`（被裁定超出目的地的工作，关闭，永不毕业）——这样超出目的地的工作就不再被读成可取的前沿。
  - **第四种 `task` 工单类型。** 用于阻塞一个决策的、字面意义上的手工活（开通访问权限、迁移数据、注册一项服务）——这是唯一一种_做事_而非做决策的类型，凭借解除对某个决策的阻塞而赢得它的位置。
  - **HITL / AFK 工单分类。** 每种工单类型要么是 **HITL**（human in the loop，人在环内——grilling、prototype），要么是 **AFK**（代理独自完成——research；task 两者皆可）。一个 HITL 工单只有通过实时交流才能解决，所以"等待人"从这个标签里自然导出——一个自问自答的 grilling 代理，按定义就已经破坏了 HITL。（这修复了学生们报告的 `/wayfinder` 拷问_自己_而非人的问题。）
  - **恢复了无迷雾时的提前退出。** 如果开场的广度优先 grilling 没有浮现出任何迷雾，那么这段旅程小到一次会话就能搞定——于是它停下并询问你想如何继续，而不是构建一张没人需要的地图。

### Patch Changes

- [#464](https://github.com/mattpocock/skills/pull/464) [`639df6e`](https://github.com/mattpocock/skills/commit/639df6e7386dfddc739b2aecdeff37a876f2483b) 感谢 [@mattpocock](https://github.com/mattpocock)！——把 **`tdd`** 重塑为一个仅供参考的技能，并补上一个缺失的反模式。

  **仅供参考。** 红 → 绿 → 重构循环由模型已经持有的领头词锚定，所以那份分步 Workflow 大体上是在复述这个循环。删掉了 Workflow 和每个循环的检查清单；把它们唯一持久的理念——垂直切片／曳光弹——折叠进 Anti-patterns 章节和一份简短的循环规则列表。引入 **seam（接缝）**作为测试所在之处的领头词：只在预先商定的接缝处测试，并在写任何测试之前与用户确认。同时删掉了重构阶段——TDD 现在是红 → 绿；重构属于评审阶段，所以重构规则和 `refactoring.md` 被移出（它的家在 `code-review`）。

  **同义反复的测试。** 添加了同义反复测试的反模式：一个断言以代码计算它的同样方式重新计算的测试，是靠构造就通过的，给出零信心——与已经涵盖的实现耦合反模式不同。作为一个同级项添加到相同的位置：一条 Philosophy 原则（期望值必须来自一个独立的事实来源）、一个检查清单关卡，以及 `tests.md` 中的一对 BAD/GOOD 示例。

- [`e00eadb`](https://github.com/mattpocock/skills/commit/e00eadb4bb32c3d5a631ead1a5ed5d6a7c5f74e2) 感谢 [@mattpocock](https://github.com/mattpocock)！——扩展 **`triage`** 技能以分诊外部拉取请求，把一个 PR 当作一个带有附带代码的 issue，让它走过同样的角色和状态机。PR 与 issue 并排内联流动（由一个按仓库的 setup 开关控制），发现只浮现外部 PR，仅针对 bug 的"reproduce"步骤被泛化为一个单一的"verify the claim"步骤，并且一个冗余检查把已实现的请求解析为 `wontfix`，而不污染范围之外的知识库。`setup-matt-pocock-skills` 为 GitHub/GitLab 获得了"把 PR 作为请求来源"的开关。

- [#472](https://github.com/mattpocock/skills/pull/472) [`d869d45`](https://github.com/mattpocock/skills/commit/d869d45afc32beab1c2d1350f8de5e81589512cd) 感谢 [@mattpocock](https://github.com/mattpocock)！——修复 **`wayfinder`** 硬编码问题跟踪器文档路径的问题，它破坏了套件其余部分所依赖的间接寻址。

  `to-issues`、`to-prd` 和 `triage` 从不命名一个路径——它们通过 `setup-matt-pocock-skills` 写入 `CLAUDE.md` / `AGENTS.md` 的 `### Issue tracker` 块来解析跟踪器，该块指向跟踪器文档所在的任何位置。而 Wayfinder 却钉死了字面的 `docs/agents/issue-tracker.md`，于是在一个把代理文档放在别处的仓库里，它会悄悄退回到本地 markdown 跟踪器——即便其 `CLAUDE.md` 明确声明了使用 GitHub issues。它现在通过那同一个指针来解析文档，并按名读取其 "Wayfinding operations" 章节，从而让间接寻址在整个套件中保持一致。

## 1.0.1

### Patch Changes

- [`d20ee26`](https://github.com/mattpocock/skills/commit/d20ee2684e2a9442698ac3c1e0f2c5b68c4cf296) 感谢 [@mattpocock](https://github.com/mattpocock)！——让 **`teach`** 技能以复用为先。课程现在由 `./assets/` 中可复用的**组件**构建——样式表、测验小部件、模拟器、图表助手。复用是默认：代理在撰写一节课之前先读 `./assets/`，从已有的东西构建，并把任何新的可复用之物抽取成一个组件，而不是内联它。

## 1.0.0

### Major Changes

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！——添加 **`ask-matt`** 技能——一个用户调用型路由器，为你的处境指向正确的技能或流程。

  **破坏性变更：** `ask-matt` 在本仓库其他用户调用型技能之上路由，所以它预期这些技能已安装。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！——添加共享的设计技能，并把现有技能重新接线到它们之上。

  - 新的 **`codebase-design`** 技能——深模块词汇（module、interface、depth、seam、adapter）以及把大量行为放到一个小接口之后的原则。此前存在于 `improve-codebase-architecture/LANGUAGE.md` 的语言现在存于此处，经泛化以便跨技能复用。
  - 新的 **`domain-modeling`** 技能——主动构建并磨砺一个项目的领域模型，针对术语表压力测试各术语，并让 `CONTEXT.md` 和 ADR 保持最新。
  - `improve-codebase-architecture` 现在从 `/codebase-design` 汲取其架构词汇，从 `/domain-modeling` 汲取其领域模型。
  - `tdd` 现在在接口设计指引上依赖 `/codebase-design`——它内联的 `deep-modules.md` / `interface-design.md` 笔记被移除，改用共享技能。
  - `grill-with-docs` 现在通过 `/domain-modeling` 内联地构建领域模型。

  **破坏性变更：** 这些技能现在依赖新的 `codebase-design` / `domain-modeling` 技能，所以你必须也安装它们。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！——移除 **`caveman`** 和 **`zoom-out`** 技能。

  - `caveman` 是我当时在测试的另一个技能的副本，本就不该公开。
  - `zoom-out` 在实践中一直没被用到，所以已从仓库移除。

  **破坏性变更：** 两个技能都已被移除。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！——把 **`diagnose`** 技能重命名为 **`diagnosing-bugs`**。

  **破坏性变更：** 以 `/diagnosing-bugs` 调用它——旧的 `/diagnose` 名称不再存在。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！——用 **`writing-great-skills`** 替换 **`write-a-skill`**。

  - 移除了 `write-a-skill`。
  - 添加了 `writing-great-skills`（以及它的 `GLOSSARY.md`）——一份把技能写好、编辑好的参考：让一个技能可预测的词汇和原则，把无操作（no-op）追杀到句子层面。
  - 把 `grilling` 暴露为一个模型调用型技能——`grill-me` 和 `grill-with-docs` 背后那个可复用的访谈循环。

  **破坏性变更：** `write-a-skill` 已被移除；改用 `writing-great-skills`。

### Minor Changes

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！——添加 **`resolving-merge-conflicts`** 技能——一个用于解决进行中的 git 合并或变基冲突的循环。独立技能，不依赖其他技能。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！——把技能分类法从 **Commands / Skills** 重命名为 **User-invoked / Model-invoked**，贯穿各文档，并添加 `docs/invocation.md` 来定义这一划分：用户调用型技能只有在你输入它们时才能触达，其存在是为了编排；模型调用型技能在任务合适时也能被自动触达。一个用户调用型技能可以调用模型调用型技能，但绝不能调用另一个用户调用型技能。

### Patch Changes

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！——收紧 **`review`** 技能：快速失败的 ref 检查、单一来源的规则，以及无操作的删减。
