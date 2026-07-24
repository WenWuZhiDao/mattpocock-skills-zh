快速开始：

```bash
npx skills add mattpocock/skills --skill=to-spec
```

```bash
npx skills update to-spec
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/to-spec)

## 它做什么

`to-spec` 把当前对话和你对代码库的理解变成一份规格（你可能把这份文档称作 PRD），然后把它发布到你的 issue 跟踪器。

它**不会**再访谈你一遍。等你取用它的时候，对齐的工作已经完成——`to-spec` 综合已经知道的东西，而不是问一轮全新的问题。

## 何时使用它

你通过输入 `/to-spec` 来调用它——智能体不会自行触发它。

一旦一次改动已经谈透、领域语言已经敲定，而你想在任何代码写就之前把那份共享理解写下来时，就用它。如果你*还没*对齐，先拷问——为此请用 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)。要把完成的规格拆成工单，请用 [to-tickets](https://aihero.dev/skills-to-tickets)。

## 前置条件

`to-spec` 发布到你的 issue 跟踪器，所以 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) 必须先为这个仓库配置好跟踪器和分诊标签。它会自己贴上 `ready-for-agent` 标签——无需单独的分诊环节。

## 规格包含什么

- **问题陈述**——什么坏了或缺了，以及为什么值得解决，用项目自己的词汇。
- **解决方案**——修复方案在高层次上的形状，先于任何实现细节。
- **用户故事**——一份详尽、编号的清单，列出改动必须支持的具体行为，每一条都可独立核对。
- **实现决策**——在对话期间已经敲定的选择，好让它们日后不被重新争论。
- **测试决策**——特性将在其上被测试的接缝，以及"完成"看起来是什么样。
- **范围外事项**——这次改动刻意*不*涵盖什么，好让工单保持有界。
- **补充说明**——任何其他值得带往下游、又不适合放进上述小节的东西。

## 深模块

在写规格之前，`to-spec` 勾勒特性将在其上被测试的**接缝**，并寻找**深模块**机会——大量功能隐藏在一个小而稳定的接口之后。它偏好已有的接缝而非新的接缝，也偏好尽可能高的接缝，理想情况下整个改动只有一条。

这对智能体式开发很重要：一个好的接口给了测试一个持久的瞄准点，所以底下的代码可以改变而测试不必挪动。

## 它生效的标志

- 它直接开始写规格，而不是问你一轮全新的问题。
- 它在写之前和你核对接缝，并提出尽可能少的接缝。
- 规格回来时用的是你项目的领域词汇，而不是泛泛的样板。

## 它的位置

`to-spec` 是主构建链中的一步：

```txt
grill-with-docs → to-spec → to-tickets → implement → code-review
```

在计划和领域语言已解决之后、把工作拆成实现工单之前用它。它的关键邻居是 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)——它磨利上下文好让规格精确，以及 [to-tickets](https://aihero.dev/skills-to-tickets)——它把规格变成一组工单供 [implement](https://aihero.dev/skills-implement) 构建。当你不确定该用哪个技能或流程时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你指路。
