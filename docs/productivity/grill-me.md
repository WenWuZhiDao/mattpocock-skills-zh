Quickstart:

```bash
npx skills add mattpocock/skills --skill=grill-me
```

```bash
npx skills update grill-me
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/productivity/grill-me)

## 它做什么

`grill-me` 就一个计划或设计运行一场不停的访谈，走过决策树的每个分支，直到你和智能体达成**共同理解**。

它**一次问一个问题**并等待。它绝不向你倾倒一批问题——那令人不知所措——而在一个问题可以通过读代码库回答时，它去读而不是问。每个问题都附上智能体自己的推荐答案，因此你是在对一个提案做反应，而不是盯着一个空白提示。

## 何时使用它

你通过输入 `/grill-me` 来调用它——智能体不会自行触及它。

在你构建之前触及它，那时一个计划感觉大致对，但你能感到里面藏着未解决的决策——就在你想把那些软肋找出来、逼到明面上的那一刻。如果你想让同一场盘问也在身后留下一串 ADR 和一个术语表的书面痕迹，改用 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)。

## The design tree

会话把计划当作一棵决策树来走，一个接一个地解决它们之间的依赖——一个父决策先于挂在它下面的选择被敲定。重点不是快速达成一致；而是让每一个隐含的判断变得明确，好让重要的东西没有被默默假定。你从另一头出来时，会得到一个所有分支都已被访问过的计划。

`grill-me` 是**无状态的（stateless）**：它什么都不写，身后不留工作区。它在任何地方运行，唯一的产物是对话本身中被磨快的理解。那是与 [grill-with-docs](https://aihero.dev/skills-grill-with-docs) 的刻意对照，后者把同一场访谈捕捉为持久的 ADR 和一个术语表。

## 它的位置

`grill-me` 是一个随时可触及的独立技能——每当一个计划需要加固时你运行的构建前压力测试。它是 [grilling](https://aihero.dev/skills-grilling) 原语无状态、用户调用的前门；它最近的邻居是 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)，即运行同一场访谈但额外把决策记录为 ADR 和术语表的有状态兄弟。如果结果是你想写下来的一份规格，交接给 [to-prd](https://aihero.dev/skills-to-prd)，它把已敲定的理解综合成一份 PRD 而不再访谈你。当你不确定哪个流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
