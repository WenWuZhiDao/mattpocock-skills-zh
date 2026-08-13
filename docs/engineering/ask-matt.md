## 它做什么

`ask-matt` 是本仓库中各技能之上的路由器。你描述自己所处的情境——一个无从下手的想法、一堆涌入的 bug 报告、一次[会话](https://www.aihero.dev/ai-coding-dictionary/session)已经拖得太长——它会指出契合的那个技能或技能序列，以及该序列中人类决策所处的位置。

它只推荐，然后停下。它不会盘问、不会写[规格](https://www.aihero.dev/ai-coding-dictionary/spec)、不会打开文件，也不会触发它刚刚指名的技能；你得到的是下一步该输入什么，然后由你输入。它同时也是本仓库技能的一张手写地图，而非对你已安装内容的扫描，所以它不会把你路由到你自己的技能或其他作者的技能上。

## 何时使用它

你通过输入 `/ask-matt` 来调用它——代理不会主动使用它。

| 你的情境 | 路由器给回什么 |
| --- | --- |
| 有个想法，却不知从何下手 | 主流程的起点，以及这次构建是否小到可以跳过规格 |
| 来自他人的 bug 与请求不断涌入 | [triage](https://aihero.dev/skills-triage) 入口，以及为什么你自己生成的[工单](https://www.aihero.dev/ai-coding-dictionary/ticket)不该走这条路 |
| 两个看起来可以互换的技能 | 二者之间的分界线，而这通常是一个具体的判定标准而非口味问题。[grill-me](https://aihero.dev/skills-grill-me) 还是 [grill-with-docs](https://aihero.dev/skills-grill-with-docs) 取决于你是否身处一个工作目录；[grill-with-docs](https://aihero.dev/skills-grill-with-docs) 还是 [wayfinder](https://aihero.dev/skills-wayfinder) 取决于这项工作能否装进一次会话 |
| 一次漫长的会话，以及关于[上下文](https://www.aihero.dev/ai-coding-dictionary/context)的一个决定 | 在阶段边界处对五个选项排出的有序决策树 |
| 一个你已经选好的技能 | 没有什么有用的。直接调用那个技能。 |

## 前置条件

路由器指名技能，但不安装它们。它指向的一切都必须已安装，推荐才具有可操作性，而且它只了解本仓库中已推广的技能。

依赖追踪器的路由——triage、`to-spec`、`to-tickets`、`implement`——都假定 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) 已经在仓库中配置好了 issue 追踪器。而在此之前，路由器仍会乐呵呵地推荐它们。

## 是流程，而非技能

这个技能给你用来思考的词是**流程（flow）**：一条*穿过*诸多技能的路径，而非单个技能。为你的情境命名，会把你放在某条流程的某一步上，这与「这是匹配你关键词的那个技能」是截然不同的答案。存在四类路由，而技能本身完整承载了它们：

- **主流程**，从想法到交付。盘问、规格、工单、实现、评审，其内部有两条分支：当某个问题需要可运行的代码来定夺时的原型岔路，以及规格与工单的拆分——只有当构建跨越不止一次会话时，这次拆分才对得起它的成本。
- **入口（on-ramp）**，用于会产生工作、随后汇入主流程的情境：涌入的 bug 报告、某处坏掉了，或是一项既太模糊又太庞大、无法在一次会话中把握的工作。
- **独立技能（standalone）**，不属于任何流程，各按自身条件被使用——原型、问卷、你此刻正陷入的合并冲突。
- **底层的词汇层**，即当问题出在词语而非流程上时，其他技能会拉入的两份参考。

## 阶段边界

它交给你的另一个概念是**阶段边界（phase boundary）**。一个阶段是会话内部的一块工作——[盘问](https://www.aihero.dev/ai-coding-dictionary/grilling)、实现、QA——而两个阶段之间的边界，是「我该拿这份上下文怎么办？」这个问题唯一该出现的地方。阶段中途没什么可决定的：要么继续，要么把剩下的拆分给[子代理](https://www.aihero.dev/ai-coding-dictionary/subagent)。

| 选项 | 何时采用 |
| --- | --- |
| **继续** | 下一阶段需要一字不差地承接这一阶段，或者你还剩有[智能区间](https://www.aihero.dev/ai-coding-dictionary/smart-zone)。这是唯一能让会话保持为[一手来源](https://www.aihero.dev/ai-coding-dictionary/primary-source)的动作，所以先把它排除 |
| **`/clear`** | 你身后的一切都可以丢弃。棋盘上最便宜的一步，且一旦选错便无法回头 |
| **[handoff](https://aihero.dev/skills-handoff)** | 有东西必须转移：一个新的[载体](https://www.aihero.dev/ai-coding-dictionary/harness)、一个新目录、一位同事，或一项在阶段中途分叉出来的支线任务 |
| **子代理** | 任务界定得足够紧凑，可以在你[离开键盘](https://www.aihero.dev/ai-coding-dictionary/afk)时运行 |
| **`/compact`** | 以上皆非。默认选项，也是它经常落到的地方 |

其中两个经常被弄错，这正是路由器承载的是顺序而非清单的原因。`/handoff` 读起来像是窗口之间的通用桥梁，其实不是：可移植性就是它买到的全部。`/compact` 位于决策树的底部而非首选，因为它上面那四个问题各自都更便宜或更精确。

## 常见问题

**难道就没有一份把技能按正确顺序排好的清单吗？**

人们不断要求在 README 里放一份。这个技能就是那份清单——它就是为此而存在的。一张静态表格会写成 `wayfinder → to-spec → to-tickets → implement → code-review`，而对大多数情境来说是错的，因为有意思的部分都在分支上——是否已有代码库、构建是否跨越多次会话、这个问题能否靠交谈定夺。诚实的代价是：路由器靠手工维护，落后于仓库。`/grilling` 和 `/resolving-merge-conflicts` 都在路由器为它们命名很久之前就已发布了。

**它告诉我一半的技能没安装。**

这是个已知 bug，尚未修复。路由器带你穿过的大多数技能都设置了 `disable-model-invocation: true`，这意味着载体在注入代理上下文的技能清单里把它们排除了。代理把那份清单当作完整无遗漏，于是报告它们缺失。曾有一次会话报告说它宣称整条规格与工单流程都不存在，并改道去用光秃秃的 `/grilling` 和 `/tdd`。插件的二十二个技能中有十三个带着这个标志，所以这是常见情况而非边缘情况。它们其实已安装。照样输入斜杠命令，或者查看 `.claude-plugin/plugin.json`，那才是「有什么在场」的权威。

**它描述了某个技能的行为，而该技能并不那么做。**

同样真实，同样未修复。路由器是凭自己对每个技能的一行摘要作答，而非凭技能本身。一份详细报告在单次会话中记录了三处这样的情况，其中包括仅凭「把线程变成规格」这句概述就建议跳过 [to-spec](https://aihero.dev/skills-to-spec)——`to-spec/SKILL.md` 根本没被打开过。每一次它都只在用户回怼之后才去核实，从不主动。在那里跳过 `to-spec` 让一次真实的接缝检查落了空，产出的工单也少算了工作量。当路由器就另一个技能作出某个关键性论断时，先让它打开那份 `SKILL.md`。对于地图根本没覆盖的问题同理，比如是否要用[计划模式](https://www.aihero.dev/ai-coding-dictionary/agent-mode)：那个答案是[模型](https://www.aihero.dev/ai-coding-dictionary/model)的推断，而非这里写下的东西。

**为什么是散文而不是带编号的清单？**

一个合理的抱怨，已作为一个开放 issue 归档，主张大部分路由是确定性的，而叙述式行文难以快速扫读。没有什么能拦着你要压缩形式——「直接给我序列」就能得到序列。散文承载的是条件性的那一半：分支、预期人类决策所在之处、以及各步骤之间该在何处清空或压缩。一份扁平的清单恰恰会丢掉这些。

**它能路由到我自己的技能，或另一位作者的技能上吗？**

不能。已经有三个各自独立的提案要求一个能读取你本地 `skills/` 目录、并从已安装内容中给出推荐的路由器。`ask-matt` 不是那种东西。它是对某一套技能的地图，靠手工维护，对你自己写的或从别处安装的技能一无所知。

**它让我去编辑某个 SKILL.md。**

那条建议往往正确，却很少经久耐用。有人问它如何让 [implement](https://aihero.dev/skills-implement) 关闭工单，被告知往技能里加一行，随即就发现了问题：`npx skills update` 会覆盖该文件，而插件安装是只读的。把常驻行为放进你自己的 `CLAUDE.md` 或 `AGENTS.md`，或者在调用时说明。提示词层面的适配能挺过更新——把流程指向 Linear 而非 GitHub，或问它哪些未关闭的工单可以并行，人们都是这么做的。

**它指名了一个我没有的技能，或漏掉了一个我有的。**

在断定它已消失之前，先查一下更新日志里是否有过重命名。`writing-great-skills` 变成了 [writing-for-agents](https://aihero.dev/skills-writing-for-agents) 且没有别名，`to-prd` 变成了 [to-spec](https://aihero.dev/skills-to-spec)，`pathfinder` 变成了 [wayfinder](https://aihero.dev/skills-wayfinder)。有四个技能被彻底退役，并入吸收了它们的技能里：`ubiquitous-language`、`design-an-interface`、`qa` 和 `request-refactor-plan`。相反的情形则是路由器自身的滞后，见上文。

## 它生效的标志

- 它以指名该输入什么作结并就此停下，而不是自己动手开工。
- 它给回的路由会提到该在何处清空或压缩上下文、以及预期你在何处评审，而不只是一串技能名。
- 当两个技能很接近时，它会说明选哪一个以及为什么另一个不适合你。
- 它就另一个技能行为作出的任何论断，都会在轨迹中显示为它正在读取那个技能的 `SKILL.md`。
- 你能在它给回的东西里认出自己的真实情境，而不是最接近的通用场景。

## 它的位置

`ask-matt` 是一个凌驾于整套技能之上的**独立路由器**。它从不是某条链上的一步；它指向每一条链，也是其他文档页面回链的那个节点，好让它们谁都不必重画这张图。从这里出发，你最常落到 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)（主流程的起点），或 [triage](https://aihero.dev/skills-triage)（用于接住来到你面前而非你自己发起的工作的入口）。

它是它所描述的那些技能之上的一个[二手来源](https://www.aihero.dev/ai-coding-dictionary/secondary-source)。当路由器与某个 `SKILL.md` 冲突时，以 `SKILL.md` 为准。
