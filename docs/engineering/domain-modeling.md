快速开始：

```bash
npx skills add mattpocock/skills --skill=domain-modeling
```

```bash
npx skills update domain-modeling
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/domain-modeling)

## 它做什么

`domain-modeling` 在你设计的同时构建并打磨项目的**通用语言（ubiquitous language）**——挑战含糊的术语，用具体场景压力测试各种关系，并在术语与决策刚刚成形的那一刻就把它们写下来。

这是**主动**的功夫，而非被动的。仅仅读一读 `CONTEXT.md` 借用其中的词汇，是任何技能都能做的一行习惯动作；而这个技能是为你*正在改变*模型的时刻准备的——铸造一个规范术语、抓住代码与你刚说的话之间的矛盾、记录一个难以逆转的决策。它还让术语表保持干净：`CONTEXT.md` 只是一份术语表,别无其他——没有实现细节，没有规格，没有草稿本。

## 何时使用它

输入 `/domain-modeling`，或者当任务契合时智能体会自动触发它——当你在敲定术语、化解一个多义词，或记录一项架构决策时。

当*用词*本身就是问题时，就用它：两个人对"取消（cancellation）"各有所指，"账户（account）"同时承担着三种职责，或者一次设计对话总在某个从未被精确命名的概念上卡壳。如果反过来，是模块的*形状*才是问题——接缝该落在哪、接口有多深——那就用 [codebase-design](https://aihero.dev/skills-codebase-design)。如果你想在动手构建之前让计划本身受到盘问，那就用 [grilling](https://aihero.dev/skills-grilling)。

## 前置条件

这个技能写入两个地方，两者都是惰性创建——只在有东西要记录时才创建。已敲定的术语进入根目录的 `CONTEXT.md`（或者，在一个由 `CONTEXT-MAP.md` 标记的多上下文仓库中，进入各上下文自己的 `CONTEXT.md`）。决策进入 `docs/adr/`。事先什么都不需要存在；第一个敲定的术语会创建术语表，第一次真正的权衡会创建 ADR。

## 术语表 vs. ADR

两种产物，两条不同的标准：

- **术语表**（`CONTEXT.md`）捕捉语言。每当一个含糊的术语被定为规范，就当场写下来——不批量攒着——好让共享词汇与对话保持同步。它冷酷地不含任何实现细节。
- **ADR** 捕捉一项决策，而且门槛很高：仅当这个选择**难以逆转**、**没有上下文就令人意外**、且**是一次真实权衡的结果**时才提出。三者缺一，就没有 ADR。正是这一点让 `docs/adr/` 成为重大分岔的记录，而不是一本流水账。

让这一切豁然开朗的动作是：当你陈述某样东西如何运作时，这个技能会交叉引用代码并把矛盾摆出来——"你的代码取消的是整个 Order，可你刚才说部分取消是可能的——到底哪个对？"语言与代码被迫达成一致。

## 有意拆分出来

`domain-modeling` 是构建项目通用语言的**唯一真实来源**，被拆分成它自己的模型可调用技能，以便任何其他技能都能取用它。[grill-with-docs](https://aihero.dev/skills-grill-with-docs) 倚赖它在一次拷问会话进行的同时记录术语与决策，[triage](https://aihero.dev/skills-triage) 用它让工单保持项目自己的用词，[improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture) 在工作时也会取用它。

保持它独立意味着你也可以直接取用它——作为一份关于如何打磨模型的**参考**——而不必投入那些技能所强制的步骤。语言活在一个地方，而所有需要它的东西都指向那里。

## 它的位置

`domain-modeling` 是一个**随时可取用的独立技能**，它*在其他技能之下*运行的频率不亚于作为某个固定步骤运行。它最近的邻居是 [codebase-design](https://aihero.dev/skills-codebase-design)，因为正是共享语言让你能精确地命名一个深模块及其接缝；在下游，一份稳定的术语表恰恰是 [to-spec](https://aihero.dev/skills-to-spec) 综合成一份用项目自己的用词写就的规格所需的东西。当你不确定该用哪个技能或流程时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你指路。
