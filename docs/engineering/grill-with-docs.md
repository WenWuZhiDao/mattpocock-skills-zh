## 它做什么

`grill-with-docs` 就一个计划或设计对你进行访谈，直到你和[代理](https://www.aihero.dev/ai-coding-dictionary/agent)对它共享同一份理解，并在此过程中把词汇和硬决定写进你的仓库。这与 [grill-me](https://aihero.dev/skills-grill-me) 运行的访谈相同——一轮问题，然后等待，然后下一轮——只是指向一个代码库。

它是**[有状态的](https://www.aihero.dev/ai-coding-dictionary/stateful)**。其他每个盘问技能都把[会话](https://www.aihero.dev/ai-coding-dictionary/session)留在你脑子里；这一个把文件留在磁盘上。一个术语被解决，它就在解决的那一刻落进 `CONTEXT.md`，而非在结尾批处理。一个决定过了三道关卡，它就落成一份 ADR。这就是全部区别，也是人们对这个技能大多数麻烦的来源：产物是真实仓库里的真实文件，所以它们可能在你以为会有时缺席，也可能在不止一个人在写它们时漂移。

## 何时使用它

你通过输入 `/grill-with-docs` 来调用它——代理不会主动使用它。

在一次改动的开端、在一个仓库里、当计划还模糊、描述这件事的词语还没敲定时使用它。它是单会话工具。你想要哪个盘问技能取决于你面前是什么：

| 你有什么 | 使用 |
| --- | --- |
| 你根本不在一个工作目录里工作 | [grill-me](https://aihero.dev/skills-grill-me) |
| 一个仓库，以及一次你能在一次会话里搞定的改动 | `grill-with-docs` |
| 一项大到无法装进一次会话的工作——一次绿地构建、一个大功能 | [wayfinder](https://aihero.dev/skills-wayfinder) |
| 一个完全没有领域文档、也没有特定功能在心里的仓库 | `grill-with-docs`，瞄准仓库而非一次改动 |
| 一个卡在别人脑子里的知识上的决定 | [to-questionnaire](https://aihero.dev/skills-to-questionnaire) |

wayfinder 的分野归结为会话数量：`/grill-with-docs` 用于单会话规划，`/wayfinder` 用于多会话规划。

## 前置条件

这个技能写入你的仓库，所以你需要身处一个可以安全写入的地方。被解决的术语进入根目录的 `CONTEXT.md` 词汇表——或者，如果根目录的 `CONTEXT-MAP.md` 把仓库标记为多上下文，则进入相关上下文的 `CONTEXT.md`。决定进入 `docs/adr/`。两者都是惰性创建；在第一个术语或决定结晶之前什么都不存在，所以一开始没有什么要搭建的。

它还需要另外两个技能在场，因为它自己的 `SKILL.md` 是委派给它们的一行：[grilling](https://aihero.dev/skills-grilling) 提供访谈，[domain-modeling](https://aihero.dev/skills-domain-modeling) 提供写入。单独安装 `grill-with-docs` 得到的是一个不工作的技能。

## 纸面记录

一次会话产出三样东西，而它们并不对等。

| 解决了什么 | 落在哪里 |
| --- | --- |
| 一个术语——项目对某样东西自己的词 | `CONTEXT.md`，内联，解决的那一刻 |
| 一个难以逆转、没有背景就令人意外、且是一次真实权衡的决定 | `docs/adr/` 下的一份 ADR |
| 你决定的其他一切 | 对话里，别无他处 |

第三行是让人栽跟头的那一行。`CONTEXT.md` 是一份词汇表，并被刻意保持为词汇表——没有实现细节、没有[规格](https://www.aihero.dev/ai-coding-dictionary/spec)、没有草稿笔记。ADR 同时受三个条件把关，所以大多数决定不合格，大多数会话一份也不产出。一次产出更锐利的词汇表和零份 ADR 的会话是按设计工作，但这意味着你所同意的大部分只存在于你同意它时的那个[上下文窗口](https://www.aihero.dev/ai-coding-dictionary/context-window)里。把那同一场对话交给 [to-spec](https://aihero.dev/skills-to-spec)，而不是[清空](https://www.aihero.dev/ai-coding-dictionary/clearing)它。

词汇表就是意义所在。领域语言才是这个技能实际在构建的东西——项目自己的词，一次商定好，好让你、代理和你的同事不再花代价去重新推导它们。值得一提的是，并非人人都同意这为你买来了代理性能：最尖锐的公开回怼是，一个术语和它的平实英语展开从[模型](https://www.aihero.dev/ai-coding-dictionary/model)那里得到同样的结果，而词汇真正压缩的是共享它的人之间的沟通。那种解读仍让词汇表有价值；只是把价值挪了个地方。

## 它假定单一撰写者

有状态的产出假定单独一人在策展它们。一个两名开发者、在一个仓库里跑了四个月的团队报告，在被抽样的已合并 PR 中约 20% 存在状态漂移，其中 ADR 引用和 README 声明是漂移最严重的面——刻意的、由人策展的文档漂移得比代理记忆还糟。修剪过时文档没能守住；同一次清扫在几天内又过时了。奏效的是彻底删掉影子状态，并往 CI 里加一个确定性的引用与链接 linter。

相关地：在一个仓库里就不相关的改动反复运行这个技能，往往会积累混合主题的文档，因为没有任何东西把一次会话的产出与另一次的分开。这两点在今天的技能里都未被修复。

## 常见问题

**我该用这个还是 `/wayfinder`？**
范围决定它。凡是你能在一次会话里搞定的都用这个；当工作大到无法装进一次会话时用 [wayfinder](https://aihero.dev/skills-wayfinder)，它会先把工作绘制成一张决策[工单](https://www.aihero.dev/ai-coding-dictionary/ticket)的地图。Wayfinder 更慢更密，在一个范围界定良好的功能上动用它是常见的错误。它不取代这个技能——它可以在地图里适合单会话的部分落进一次盘问会话。

**它跑了，但没有出现 `CONTEXT.md`，也没有 ADR。**
两个已知原因。平淡的那个：没有东西合格。ADR 需要全部三道关卡，一次关于没有新词汇的改动的会话确实没什么可写。真正的 bug：当这个技能跑在另一个编排层内部时——一个规格驱动开发的包装器、一个多代理框架、一条把它作为别人管道中一步来调用的规则——据报告写文件那一半会悄无声息地不发生，而访谈仍照跑。此事已归档且未修复。如果你处在那种配置里，在信任会话产出之前先检查工作目录。

**它一次性问了所有问题、没有推荐，也从没提过 `CONTEXT.md`。**
那是这个技能没能加载它的两个依赖。因为 `SKILL.md` 是一行委派，一个没接住 [grilling](https://aihero.dev/skills-grilling) 和 [domain-modeling](https://aihero.dev/skills-domain-modeling) 的代理会去猜 grilling 是什么意思，于是你得到一堆未加区分的问题倾泻。部分加载是更让人困惑的情况——`grilling` 加载了，`domain-modeling` 没有，于是你得到一次好访谈却没有纸面记录。它与模型和[努力度](https://www.aihero.dev/ai-coding-dictionary/effort)水平相关，是这个技能被报告最多的问题。如果你怀疑是它，直接问代理它加载了哪些技能。

**我其他所有的决定都去哪了？**
只进了对话里。这是关于这个技能最实质的开放抱怨：词汇表不是规格，大多数答案配不上一份 ADR，而且没有一个账本把每个被解决的答案一路串到一份规格、一个工单和一个测试。精确的答案——顺序保证、否定式需求、数值默认值——在下游被软化成更弱的散文，结果可能看起来完整却漏掉了你真正决定的东西。今天可用的缓解办法是保留会话并把它径直喂给 [to-spec](https://aihero.dev/skills-to-spec)，并对照你自己的答案重读规格，而不是假定它捕捉到了它们。

**我能把它指向一个完全没有文档的现有仓库吗？**
能。对于一个没有 ADR、没有领域语言、没有设计原则的代码库，这是对的技能——调用它并说「帮我记录我的仓库」。社区的做法是把它和 [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture) 配对来构建或修复一份 `CONTEXT.md`。要预料到你得引导它：它会读代码并就它发现的东西问你，而由你来说代码库里已有的词哪些是对的。

**会话结束时我该做什么？**
这个技能的收尾消息往往是开放式的，这是一个已知的粗糙边缘。在主流程里，答案是在同一场对话里用 [to-spec](https://aihero.dev/skills-to-spec)。如果改动小到可以立即构建，就直接去 [implement](https://aihero.dev/skills-implement)。

**它为什么叫这个名字？**
没人对这个名字满意。有一个开放的建议要把它重命名为 `grill-domain-model`，那更诚实地描述了行为。此事没有任何进展。如果重命名哪天落地，文档页会随之搬迁、URL 会变。

## 它生效的标志

- `CONTEXT.md` 在会话*期间*一个术语一个术语地变化，而不是在结尾一整块地出现。
- 词汇表读起来是纯粹的词汇——你项目的词加上紧凑的定义——不含实现细节或类似规格的散文。
- 代码库能回答的问题靠读代码库回答，而不是问你。
- 你得到很少或没有 ADR，而你得到的那些都是你若得重新辩一遍会恼火的决定。
- 它挑战一个你用了的词，因为你现有的词汇表对它的定义不同。

## 它的位置

`grill-with-docs` 是主构建链的起点：

```txt
grill-with-docs → to-spec → to-tickets → implement → code-review
```

它先于任何东西被写成规格——它产出共享的理解和敲定的词汇，[to-spec](https://aihero.dev/skills-to-spec) 随后据此合成，而无需再次访谈你。它的近邻是 [grill-me](https://aihero.dev/skills-grill-me)（同样的访谈，没有仓库也没有文件）和 [domain-modeling](https://aihero.dev/skills-domain-modeling)（它所驱动的词汇表与 ADR 训练）；两者都建立在 [grilling](https://aihero.dev/skills-grilling) 这个原语之上。在它的上游，[wayfinder](https://aihero.dev/skills-wayfinder) 绘制大到无法装进一次会话的工作，并能把地图的一部分交回给它。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
