快速开始：

```bash
npx skills add mattpocock/skills --skill=grill-me
```

```bash
npx skills update grill-me
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/productivity/grill-me)

## 它做什么

`grill-me` 就一个计划或设计运行一场穷追不舍的访谈，走遍决策树的每一条分支，直到你和智能体达成**共享的理解**。

它**一次只问一个问题**并等待。它绝不甩给你一批问题——那会让人晕头转向——而在一个问题能通过读代码库来回答的地方，它会去读而不是发问。每个问题都附带智能体自己的推荐答案，所以你是在对一个提案做反应，而不是盯着一个空白的提示。

## 何时使用它

你通过输入 `/grill-me` 来调用它——智能体不会自行触发它。

在你动手构建之前用它，那时计划感觉大致对了、但你能察觉到有未解决的决策藏在其中——你想把那些软肋找出来、逼到明面上的那一刻。如果你想让同样的盘问也在身后留下一串 ADR 和一份术语表，请改用 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)。而如果这项工作大到一次会话装不下、通往目标的路线仍然朦胧——一个全新项目、一次庞大的特性构建——那就从更上游的 [wayfinder](https://aihero.dev/skills-wayfinder) 起步，它先把它绘制成一张决策地图，然后再汇回这条流程。

## 决策树

会话把计划当作一棵决策之树来走，逐个解决它们之间的依赖——一个父决策先于挂在它下面的那些选择被敲定。要点不是快速达成一致；而是让每一个隐含的判断都变得显式，好让没有重要的东西被悄悄地假定掉。你从另一头出来时，会得到一个所有分支都被走访过的计划。

`grill-me` 是**无状态的**：它什么都不写，也不留下任何工作区。它在任何地方都能运行，唯一的产物就是对话本身之中被磨利的理解。这正是与 [grill-with-docs](https://aihero.dev/skills-grill-with-docs) 的刻意对照，后者把同一场访谈捕捉为持久的 ADR 和一份术语表。

## 它的位置

`grill-me` 是一个随时可取用的独立技能——每当一个计划需要加固时你就运行的构建前压力测试。它是通往 [grilling](https://aihero.dev/skills-grilling) 这个原语的无状态、用户调用型正门；它最近的邻居是 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)，那个有状态的兄弟运行同一场访谈，但额外把决策记录为 ADR 和一份术语表。如果结果是一份你想写下来的规格，就交接给 [to-spec](https://aihero.dev/skills-to-spec)，它把敲定的理解综合成一份规格而无需再访谈你一遍。当你不确定该用哪个流程时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你指路。
