Quickstart:

```bash
npx skills add mattpocock/skills --skill=domain-modeling
```

```bash
npx skills update domain-modeling
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/domain-modeling)

## 它做什么

`domain-modeling` 在你设计的过程中构建并打磨项目的**通用语言（ubiquitous language）**——挑战模糊的术语，用具体场景对关系做压力测试，并在术语和决策成型的那一刻就把它们写下来。

这是**主动**的纪律，而非被动的那种。仅仅是读 `CONTEXT.md` 借用它的词汇，是任何技能都能做的一行习惯；这个技能是为你正在_改变_模型时准备的——生造一个规范术语、抓住代码与你刚说的话之间的矛盾、记录一个难以逆转的决策。而且它让术语表保持干净：`CONTEXT.md` 是术语表，别无其他——没有实现细节，没有规格，没有草稿本。

## 何时使用它

输入 `/domain-modeling`，或者当任务契合时智能体会自动触及它——当你在敲定术语、解决一个含义过载的词，或记录一个架构决策时。

当_词语_是问题时触及它：两个人对"取消"意思不同、"account"身兼三职，或一次设计对话总是卡在一个从未被精确命名的概念上。如果反过来问题在于模块的_形状_——接缝放哪里、接口有多深——用 [codebase-design](https://aihero.dev/skills-codebase-design)。如果你想在构建之前让计划本身受到盘问，用 [grilling](https://aihero.dev/skills-grilling)。

## 前置条件

该技能写入两个地方，都是惰性创建的——只有在有东西要记录时才创建。已解决的术语进入根目录的 `CONTEXT.md`（或者在由 `CONTEXT-MAP.md` 标记的多上下文仓库中，进入按上下文的 `CONTEXT.md`）。决策进入 `docs/adr/`。事先什么都不需要存在；第一个解决的术语创建术语表，第一个真实的权衡创建 ADR。

## Glossary vs. ADR

两种产物，两条不同的标准：

- **术语表**（`CONTEXT.md`）捕捉语言。每当一个含糊的术语被规范化，它就被就地写下来——不批量——使共享词汇与对话保持同步。它无情地保持无实现细节。
- **ADR** 捕捉一个决策，且标准很高：只有当选择**难以逆转**、**没有背景就令人意外**、并且**是一次真实权衡的结果**时才提出。三者缺一，就没有 ADR。这正是让 `docs/adr/` 成为一份关键分叉记录、而非一本日记的东西。

让它一目了然的动作：当你陈述某个东西如何运作时，该技能会交叉引用代码并把矛盾摆出来——"你的代码取消整个 Order，但你刚才说部分取消是可能的——哪个才对？"语言与代码被迫达成一致。

## Pulled out on purpose

`domain-modeling` 是构建项目通用语言的**单一真相来源**，被拆分成它自己的模型调用技能，使任何其他技能都能触及它。[grill-with-docs](https://aihero.dev/skills-grill-with-docs) 依靠它在拷问式会话进行时记录术语和决策，[triage](https://aihero.dev/skills-triage) 用它让工单保持项目自己的措辞，[improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture) 在工作时会触及它。

保持它独立意味着你也可以直接触及它——作为一个打磨模型的**参考**——而不必投入上述任何技能所强制的步骤。语言存在于一个地方，一切需要它的东西都指向那里。

## 它的位置

`domain-modeling` 是一个**随时可触及的独立技能**，它在其他技能_之下_运行的频率不亚于作为一个固定步骤。它最近的邻居是 [codebase-design](https://aihero.dev/skills-codebase-design)，因为共享语言正是让你能精确命名一个深模块及其接缝的东西；下游，一个稳定的术语表正是 [to-prd](https://aihero.dev/skills-to-prd) 综合成一份用项目自己措辞写就的规格的东西。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
