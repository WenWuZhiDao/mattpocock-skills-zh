快速开始：

```bash
npx skills add mattpocock/skills --skill=implement
```

```bash
npx skills update implement
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/implement)

## 它做什么

`implement` 构建一份规格或一组工单所描述的工作——用测试驱动开发、类型检查和完整测试套件驱动它，然后交接给评审并提交到当前分支。

它**不**决定要构建什么。规格已经敲定，接缝也已经达成一致；`implement` 执行那个计划，而不是重新打开它。它是手，不是脑——思考在上游就发生了。

## 何时使用它

你通过输入 `/implement` 来调用它——智能体不会自行触发它。

一旦工作被写成一份规格或拆分成工单，而你准备好把它变成代码时，就用它。如果规格还不存在，先写它——为此请用 [to-spec](https://aihero.dev/skills-to-spec)，或用 [to-tickets](https://aihero.dev/skills-to-tickets) 把一份规格拆成工单。如果你只是想测试先行地构建点东西而不需要完整规格，那就直接降到 [tdd](https://aihero.dev/skills-tdd)。

## 预先商定的接缝

`implement` 运行所依托的理念是**接缝**——一个特性在其上被测试的稳定接口，在任何代码写就之前就已选定。它不在构建途中发明接缝；它使用那些已经选好的（在 [to-spec](https://aihero.dev/skills-to-spec) 期间选好的），并通过 [tdd](https://aihero.dev/skills-tdd) 对着它们写测试。在预先商定的接缝处工作，正是让实现保持诚实的关键：测试瞄准的是持久的东西，所以底下的代码可以挪动而测试不必挪动。

围绕这个核心，它把循环保持得紧凑——频繁类型检查，边做边跑单个测试文件，在末尾跑一遍完整套件——然后以一轮评审和一次向当前分支的提交收尾。

## 它的位置

`implement` 是主链接近末尾的构建步骤，就在评审之前：

```txt
grill-with-docs → to-spec → to-tickets → implement → code-review
```

在工作被写成规格并排好序之后用它，而不是之前。它的关键邻居是 [to-tickets](https://aihero.dev/skills-to-tickets)——它产出那些工单（每张都声明自己的阻塞边），供 `implement` 逐一推进，以及 [tdd](https://aihero.dev/skills-tdd)——`implement` 在内部驱动它,在每条接缝处先写测试，然后再运行自己的 [code-review](https://aihero.dev/skills-code-review) 环节并提交。当你不确定该用哪个技能或流程时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你指路。
