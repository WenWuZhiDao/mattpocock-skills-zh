Quickstart:

```bash
npx skills add mattpocock/skills --skill=ask-matt
```

```bash
npx skills update ask-matt
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/ask-matt)

## 它做什么

`ask-matt` 是本仓库中众技能之上的路由器。你描述你所处的情形；它告诉你哪个技能或流程契合，以及以什么顺序运行它们。

它**自己不做任何工作**。它不拷问、不写 PRD、不修任何东西——它只帮你建立方位。它首先是为了**用户调用**技能而存在：没有东西会替你触发那些技能，所以_你_必须记住它们存在，而 `ask-matt` 就是你把那份记忆卸载给它的对象。它也指向那些你会按名字触及的模型调用技能——`/tdd`、`/diagnosing-bugs`、`/prototype`、`/code-review`，以及两个词汇参考 `/domain-modeling` 和 `/codebase-design`。它回答"哪一个，以及何时"，然后把你交给真正干活的那个技能。

## 何时使用它

你通过输入 `/ask-matt` 来调用它——智能体不会自行触及它。

每当你不确定某个情形需要哪个技能或流程时就触及它：你有一个想法却不知从何入手，有一堆 bug 报告却不知它们是否该交给 `/triage`，或者两个看起来可以互换的技能你分不清。如果你已经知道你想要的技能，就跳过路由器直接调用它。

## Flows, not just skills

`ask-matt` 给你用来思考的理念是**流程（flow）**——一条_穿过_众技能的路径，而不是单个技能。大多数工作沿一条**主流程**运行（想法 → 交付：grill → PRD → issues → implement → review），两条**入口**汇入其中（针对进来的 bug 和请求的分诊车道；一条产生想法的代码库健康车道），其余一切都是你单独触及的**独立技能**。问一个问题，你就会被放到正确的流程、正确的步骤上——而不只是被塞了一个工具。

## 它的位置

`ask-matt` 是**路由器**——凌驾于整套之上的独立地图。它是每个其他文档页面以 [ask-matt](https://aihero.dev/skills-ask-matt) 回链的节点，所以它绝不_置身_于某条链中；它指_向_每条链。从这里你最常落到 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)，主流程的开端，或 [triage](https://aihero.dev/skills-triage)，你未创建之工作的入口。当连路由器自身的图景都过时了，它的 [Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/ask-matt) 就是权威地图。
