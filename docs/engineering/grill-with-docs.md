快速开始：

```bash
npx skills add mattpocock/skills --skill=grill-with-docs
```

```bash
npx skills update grill-with-docs
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/grill-with-docs)

## 它做什么

`grill-with-docs` 就一个计划或设计对你穷追不舍地发问，一次只问一个问题，直到你和智能体达成共识——并且它会在过程中把词汇与决策写下来。

这场拷问**会留下书面痕迹**。一场普通的访谈能磨利你的思路，然后在会话结束时蒸发掉；而这一场会在每个术语被敲定的那一刻就把它捕捉进一份 `CONTEXT.md` 术语表，并把那些艰难的、单向的决策记录为 ADR。共识得以在对话之外存续，而不只是活在你的脑子里。

## 何时使用它

你通过输入 `/grill-with-docs` 来调用它——智能体不会自行触发它。

在一次改动的最开始就用它，那时计划还很模糊、领域语言还没敲定，而你想在任何代码存在之前就把二者都压力测试一遍。如果你只想要访谈而不需要那些产物，请用 [grilling](https://aihero.dev/skills-grilling)；如果计划已经清晰，你只需要敲定或记录术语，请用 [domain-modeling](https://aihero.dev/skills-domain-modeling)。而如果这次改动大到一次会话装不下、其路线仍然朦胧——一个全新项目、一次庞大的特性构建——那就从上游的 [wayfinder](https://aihero.dev/skills-wayfinder) 起步：它把这项工作绘制成一张决策地图，一旦路径清晰就把你交回这条主流程。

## 前置条件

这个技能是有状态的——它在拷问的同时会写入你的仓库。敲定的术语落进根目录的一份 `CONTEXT.md` 术语表（或者，若一份 `CONTEXT-MAP.md` 标记出这是个多上下文仓库，则落进相关上下文的 `CONTEXT.md`），而真正难以逆转的决策则作为 ADR 落进 `docs/adr/`。两者都是惰性创建——在第一个术语或决策成形之前什么都不存在——所以你无需事先搭建任何东西，但你确实需要待在一个能安全写入这些文件的地方。

## 拷问

引擎是一场**拷问**：一次穷追不舍、一问一停地走下决策树，在往前走之前先解决决策之间的依赖，并为每个问题给出一个推荐答案。凡是代码库能回答的问题，都通过读代码库来回答，而不是问你。

让这个变体成为它自己的技能的，是答案的去向。随着拷问的进行，含糊的语言被磨成规范术语并当场写入术语表——不是在末尾批量写入。术语表始终是术语表：纯粹的词汇，没有实现细节，没有规格。ADR 被节制地提出，仅当一项决策难以逆转、没有上下文就令人意外、且是一次真实权衡的结果时才提出。大多数会话产出的是一份更锋利的术语表和很少甚至没有 ADR，而这正是预期的形态。

## 它生效的标志

- 它一次只问一个问题并等待，而不是甩出一份问卷。
- 术语在敲定的那一刻就被写入 `CONTEXT.md`，用的是你项目自己的用词。
- 它会伸手进代码库,在力所能及处回答自己的问题。
- ADR 保持稀少——你不会被要求给可逆的选择盖橡皮图章。

## 它的位置

`grill-with-docs` 是主构建链的开场步骤：

```txt
grill-with-docs → to-spec → to-tickets → implement → code-review
```

它排在最前，早于任何东西被写成规格：它产出共享的理解和敲定的词汇，[to-spec](https://aihero.dev/skills-to-spec) 随后据此综合成一份规格,而无需再访谈你一遍。它亲近的邻居是 [grilling](https://aihero.dev/skills-grilling)——同一场访谈但不带文档，以及 [domain-modeling](https://aihero.dev/skills-domain-modeling)——它所驱动的术语表与 ADR 功夫。当你不确定该用哪个技能或流程时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你指路。
