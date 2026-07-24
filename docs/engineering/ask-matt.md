快速开始：

```bash
npx skills add mattpocock/skills --skill=ask-matt
```

```bash
npx skills update ask-matt
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/ask-matt)

## 它做什么

`ask-matt` 是本仓库中所有技能之上的路由器。你描述自己所处的情境，它会告诉你哪个技能或流程最合适，以及按什么顺序运行它们。

它**自己不做任何工作**。它不拷问、不写规格、也不修任何东西——它只负责指路。它的存在首先是为了那些**用户主动调用**的技能：没有任何东西会替你触发它们，所以*你*必须记得它们的存在，而 `ask-matt` 就是你把这份记忆卸载出去的地方。它也会指向那些你会按名字直接调用的模型可调用技能——`/tdd`、`/diagnosing-bugs`、`/prototype`、`/code-review`，以及两个术语参考：`/domain-modeling` 和 `/codebase-design`。它回答"用哪个、什么时候用"，然后把你交接给真正干活的那个技能。

## 何时使用它

你通过输入 `/ask-matt` 来调用它——智能体不会自行触发它。

每当你不确定某个情境该用哪个技能或流程时，就用它：你有个想法但不知从何下手，你手头一堆 bug 报告但不确定它们是不是该走 `/triage`，或者两个技能看起来可以互换而你分不清它们。如果你已经知道自己想要哪个技能，就跳过路由器，直接调用它。

## 是流程，不只是技能

`ask-matt` 给你的思考工具是**流程**——一条*穿过*多个技能的路径，而不是单个技能。大部分工作都沿着一条**主流程**运行（想法 → 上线：拷问 → 规格 → 工单 → 实现 → 评审），两条**入口匝道**汇入其中（一条处理进来的 bug 与需求的分诊车道；一条产生想法的代码库健康车道），其余的一切都是你单独取用的**独立技能**。问一个问题，你就会被安置到正确的流程、正确的步骤上——而不只是拿到一个工具。

## 它的位置

`ask-matt` 是**路由器**——凌驾于整套技能之上的独立地图。它是其他每个文档页都会链接回来的节点 [ask-matt](https://aihero.dev/skills-ask-matt)，所以它从不身处任何链条*之中*；它指向每一条链条。从这里出发，你最常落到 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)——主流程的开端，或者 [triage](https://aihero.dev/skills-triage)——处理非你创建的工作的入口匝道。当连路由器自身的图景都过时了，它的[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/ask-matt)就是权威的地图。
