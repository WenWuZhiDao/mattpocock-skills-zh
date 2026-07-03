Quickstart:

```bash
npx skills add mattpocock/skills --skill=grilling
```

```bash
npx skills update grilling
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/productivity/grilling)

## 它做什么

`grilling` 是那场在你构建之前对一个计划或设计做压力测试的不停访谈。它一个分支接一个分支地沿设计树往下走，一次解决一个决策之间的依赖，直到你和智能体共享同一份理解。

它**一次问一个问题**，并在下一个之前等待你的回答——绝不是一份成批的列表，那令人不知所措。每个问题都附上智能体自己的推荐答案，而任何代码库能敲定的问题，它去探索而不是问你。

## 何时使用它

输入 `/grilling`，或者当任务契合时智能体会自动触及它——这是底层原语，而不是一个仅供用户的入口。

当一个计划或设计仍有软肋、你想在代码写就之前把它们摊出来时，触及它。实践中你通常通过它的两个包装之一来调用它，而不是按名字：要一场普通的拷问式会话，用 [grill-me](https://aihero.dev/skills-grill-me)；要让会话在进行中也写 ADR 和术语表，用 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)。

## The design tree

心智模型是一棵**设计树（design tree）**：每个计划分叉成决策，而决策彼此依赖。`grilling` 一次一个节点地下降那棵树，因此一个早期的答案能重塑接下来哪些问题会来。这就是为什么问题单个地、按依赖顺序到达——一股并行问题的洪流会丢失那让访谈收敛到共同理解的结构。

## Pulled out on purpose

`grilling` 是访谈技术的**单一真相来源**，被拆分成一个模型调用的**原语（primitive）**，使每个需要访谈的技能都能触及它，而不必重新发明一个。[grill-me](https://aihero.dev/skills-grill-me) 和 [grill-with-docs](https://aihero.dev/skills-grill-with-docs) 是它两个用户调用的前门，但 [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture) 和 [triage](https://aihero.dev/skills-triage) 也依靠它来对它们自己的决策施压检验。

把这项技术放在一个地方，意味着你也可以在只想要访谈时直接触及它——而不带它的包装在其之上叠加的 ADR 写作或工单塑形。

## 它的位置

`grilling` 是主构建链之下的访谈**原语**：[grill-with-docs](https://aihero.dev/skills-grill-with-docs) 运行它，在 [to-prd](https://aihero.dev/skills-to-prd) 写规格之前磨快上下文。当你不确定哪个入口契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
