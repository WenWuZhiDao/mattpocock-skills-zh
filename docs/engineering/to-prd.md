Quickstart:

```bash
npx skills add mattpocock/skills --skill=to-prd
```

```bash
npx skills update to-prd
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/to-prd)

## 它做什么

`to-prd` 把当前对话和你对代码库的理解变成一份产品需求文档（PRD），然后把它发布到你的 issue 追踪器。

它**不**再次访谈你。等你触及它的时候，对齐的工作已经完成——`to-prd` 综合已知的内容，而不是问一轮新问题。

## 何时使用它

你通过输入 `/to-prd` 来调用它——智能体不会自行触及它。

一旦一个改动被谈透、领域语言已经稳定，你想在任何代码写就之前把那份共同理解写成规格时，触及它。如果你_还没_对齐，先拷问——为此，用 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)。要把完成的 PRD 拆成工单，用 [to-issues](https://aihero.dev/skills-to-issues)。

## 前置条件

`to-prd` 发布到你的 issue 追踪器，所以 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) 必须先为这个仓库配置好追踪器和分诊标签。它会自己应用 `ready-for-agent` 标签——无需单独的分诊一遍。

## What the PRD includes

- **问题陈述**—— 什么坏了或缺失了，以及为什么它值得解决，用项目自己的词汇。
- **解决方案**—— 修复在高层的形态，先于任何实现细节。
- **用户故事**—— 一份详尽、编号的列表，列出这个改动必须支持的具体行为，每一条都可独立核对。
- **实现决策**—— 在对话期间已经敲定的选择，好让它们日后不被重新争论。
- **测试决策**—— 这个功能将被测试所在的接缝，以及"完成"是什么样子。
- **范围外条目**—— 这个改动刻意_不_覆盖什么，以让工单保持有界。
- **补充说明**—— 任何其他值得带上、但不适合放进上面各小节的东西。

## Deep modules

在写 PRD 之前，`to-prd` 勾勒这个功能将被测试所在的**接缝（seam）**，并寻找**深模块（deep module）**机会——在一个小而稳定的接口后面隐藏大量功能。它偏好既有接缝而非新的，并偏好尽可能高的接缝，理想情况下整个改动只用一个。

那对于智能体式开发很重要：一个好接口给测试一个持久可瞄准的东西，因此底下的代码可以改变而测试不必移动。

## 它生效的标志

- 它开始动笔写 PRD，而不是问你一轮新问题。
- 它在动笔前和你核对接缝，并提议尽可能少的接缝。
- PRD 以你项目的领域词汇返回，而不是泛泛的样板文字。

## 它的位置

`to-prd` 是主构建链中的一个步骤：

```txt
grill-with-docs → to-prd → to-issues → implement → code-review
```

在计划和领域语言解决之后、在你把工作拆成实现工单之前触及它。它的关键邻居是 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)，它磨快上下文使 PRD 精确，以及 [to-issues](https://aihero.dev/skills-to-issues)，它把 PRD 变成可独立认领的 issue 供 [implement](https://aihero.dev/skills-implement) 构建。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
