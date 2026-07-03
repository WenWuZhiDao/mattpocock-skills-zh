Quickstart:

```bash
npx skills add mattpocock/skills --skill=implement
```

```bash
npx skills update implement
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/implement)

## 它做什么

`implement` 构建一份 PRD 或一组 issue 所描述的工作——驱动它走过测试驱动开发、类型检查和完整的测试套件，然后交接给审查并提交到当前分支。

它**不**决定要构建什么。规格已经敲定，接缝已经商定；`implement` 执行那份计划，而不是重新打开它。它是手，不是脑——思考在上游已经发生。

## 何时使用它

你通过输入 `/implement` 来调用它——智能体不会自行触及它。

一旦工作被写成一份 PRD 或拆成 issue，你准备把它变成代码时，触及它。如果规格还不存在，先写它——为此，用 [to-prd](https://aihero.dev/skills-to-prd)，或用 [to-issues](https://aihero.dev/skills-to-issues) 把一份 PRD 拆成工单。如果你只想在没有完整规格的情况下以测试先行的方式构建某个东西，直接落到 [tdd](https://aihero.dev/skills-tdd)。

## Pre-agreed seams

`implement` 所依据的理念是**接缝（seam）**——一个功能被测试所在的稳定接口，在任何代码写就之前选定。它不在构建中途发明接缝；它使用已经选好的那些（在 [to-prd](https://aihero.dev/skills-to-prd) 期间），并通过 [tdd](https://aihero.dev/skills-tdd) 对它们写测试。在事先商定的接缝处工作，正是让实现保持诚实的东西：测试瞄准某个持久的东西，因此底层代码可以移动而测试不必移动。

围绕那个核心，它让回路保持紧凑——频繁类型检查，边做边运行单个测试文件，末尾运行一遍完整套件——然后以一次审查和一次到当前分支的提交收尾。

## 它的位置

`implement` 是主链末尾附近的构建步骤，就在审查之前：

```txt
grill-with-docs → to-prd → to-issues → implement → code-review
```

在工作已经被写成规格并排好序之后触及它，而非之前。它的关键邻居是 [to-issues](https://aihero.dev/skills-to-issues)，后者产出它所处理的可独立认领的工单，以及 [tdd](https://aihero.dev/skills-tdd)，它在内部驱动后者，在每个接缝处写测试，然后跑它自己的 [code-review](https://aihero.dev/skills-code-review) 一遍并提交。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
