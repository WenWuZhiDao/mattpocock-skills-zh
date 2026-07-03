Quickstart:

```bash
npx skills add mattpocock/skills --skill=grill-with-docs
```

```bash
npx skills update grill-with-docs
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/grill-with-docs)

## 它做什么

`grill-with-docs` 就一个计划或设计不停地访谈你，一次一个问题，直到你和智能体达成共同理解——并在过程中把词汇和决策写下来。

这场拷问**留下书面痕迹**。一场普通的访谈磨快你的思考，然后在会话结束时蒸发；这一场在每个术语解决的那一刻就把它捕捉进一个 `CONTEXT.md` 术语表，并把那些困难的、单向的决策记录为 ADR。对齐存活于对话之外，而不只是活在你脑子里。

## 何时使用它

你通过输入 `/grill-with-docs` 来调用它——智能体不会自行触及它。

在一次改动的最开始触及它，那时计划还模糊、领域语言尚未稳定，而你想在任何代码存在之前对两者都做压力测试。如果你只想要访谈、不需要产物，用 [grilling](https://aihero.dev/skills-grilling)；如果计划已经清晰，你只需要敲定或记录术语，用 [domain-modeling](https://aihero.dev/skills-domain-modeling)。

## 前置条件

这个技能是有状态的——它在拷问时写入你的仓库。已解决的术语落入根目录的 `CONTEXT.md` 术语表（或者，如果 `CONTEXT-MAP.md` 标记了一个多上下文仓库，则落入相关上下文的 `CONTEXT.md`），而真正难以逆转的决策作为 ADR 落入 `docs/adr/`。两者都是惰性创建的——在第一个术语或决策成型之前什么都不存在——所以你不需要事先搭建任何东西，但你确实需要处在一个写这些文件是安全的地方。

## The grill

引擎是一场**拷问（grill）**：一次不停地、一次一个问题地沿设计树往下走，在继续之前先解决决策之间的依赖，且每个问题都附一个推荐答案。代码库能回答的问题，通过读代码库来回答，而不是问你。

让这个变体成为它自己技能的，是答案的去向。在拷问运行时，模糊的语言被磨成规范术语并就地写入术语表——不在末尾批量处理。术语表保持为术语表：纯词汇，没有实现细节，没有规格。ADR 被吝啬地提出，只在一个决策难以逆转、没有背景就令人意外、并且是一次真实权衡的结果时。大多数会话产出一个更锐利的术语表和很少或没有 ADR，而那正是预期的形态。

## 它生效的标志

- 它一次问一个问题并等待，而不是倾倒一份问卷。
- 术语在解决的那一刻就被写入 `CONTEXT.md`，用你项目自己的措辞。
- 在它能做的地方，它伸手进代码库回答它自己的问题。
- ADR 保持稀少——你不会被要求为可逆的选择盖橡皮图章。

## 它的位置

`grill-with-docs` 是主构建链的开端步骤：

```txt
grill-with-docs → to-prd → to-issues → implement → code-review
```

它排在最前，早于任何东西被写成规格：它产出共同理解和稳定的词汇，[to-prd](https://aihero.dev/skills-to-prd) 随后把它们综合成一份 PRD 而不再访谈你。它的近邻是 [grilling](https://aihero.dev/skills-grilling)，即不带文档的同一场访谈，以及 [domain-modeling](https://aihero.dev/skills-domain-modeling)，即它所驱动的术语表-与-ADR 纪律。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
