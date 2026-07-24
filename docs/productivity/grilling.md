快速开始：

```bash
npx skills add mattpocock/skills --skill=grilling
```

```bash
npx skills update grilling
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/productivity/grilling)

## 它做什么

`grilling` 是那场穷追不舍的访谈，在你动手构建之前就一个计划或设计做压力测试。它一条分支接一条分支地走下决策树，一次一个地解决决策之间的依赖，直到你和智能体共享同一份理解。

它**一次只问一个问题**并在下一个之前等你的答案——绝不是一份成批的清单，那会让人晕头转向。每个问题都附带智能体自己的推荐答案，凡是代码库能敲定的问题它都去探索而不是问你。在你确认已达成共享理解之前，它不会开始实施计划。

## 何时使用它

输入 `/grilling`，或者当任务契合时智能体会自动触发它——这是底层的原语，而不是仅限用户的入口点。

当一个计划或设计仍有软肋、而你想在代码写就之前把它们浮现出来时，就用它。实践中你通常是通过它的两个包装器之一来调用它，而非直接点名：想要一场普通的拷问会话，用 [grill-me](https://aihero.dev/skills-grill-me)；想让会话在进行的同时也写下 ADR 和一份术语表，用 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)。

## 决策树

心智模型是一棵**决策树**：每个计划都分岔成决策，而决策彼此依赖。`grilling` 一次一个节点地往下走这棵树，所以一个早期的答案能重塑接下来该问哪些问题。这正是为什么问题单个地、按依赖顺序到来——一股并行问题的洪流会丢失那种让访谈收敛到共享理解的结构。

## 有意拆分出来

`grilling` 是访谈技法的**唯一真实来源**，被拆分成一个模型可调用的**原语**，以便每个需要访谈的技能都能取用它,而不必重新发明一个。[grill-me](https://aihero.dev/skills-grill-me) 和 [grill-with-docs](https://aihero.dev/skills-grill-with-docs) 是它两个用户调用型的正门，但 [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture) 和 [triage](https://aihero.dev/skills-triage) 也倚赖它来对它们自己的决策做压力测试。

把技法放在一个地方，意味着当你只想要那场访谈时也可以直接取用它——而不带它的包装器在其之上附加的 ADR 写入或工单成型。

## 它的位置

`grilling` 是主构建链之下的访谈**原语**：[grill-with-docs](https://aihero.dev/skills-grill-with-docs) 运行它，在 [to-spec](https://aihero.dev/skills-to-spec) 写规格之前磨利上下文。当你不确定该用哪个入口点时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你指路。
