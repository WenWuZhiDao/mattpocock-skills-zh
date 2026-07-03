Quickstart:

```bash
npx skills add mattpocock/skills --skill=improve-codebase-architecture
```

```bash
npx skills update improve-codebase-architecture
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/improve-codebase-architecture)

## 它做什么

`improve-codebase-architecture` 扫描代码库寻找**加深机会（deepening opportunities）**——那些一个浅模块（接口几乎和它所隐藏的东西一样复杂）本可以变成一个深模块的地方——把它们作为一份自包含的可视化 HTML 报告呈现，然后就你挑选的那个进行拷问。

它**不**递给你一份扁平的重构清单。每个候选都必须通过**删除测试（deletion test）**——移除这个模块会把复杂性_集中_到一个更小的接口之后，还是只是把它挪来挪去？只有"集中"的情形才配得上一张卡片。正是那个过滤器阻止报告沦为泛泛的清理建议。

## 何时使用它

你通过输入 `/improve-codebase-architecture` 来调用它——智能体不会自行触及它。

把它当作周期性的健康检查触及：每隔几天，或每当一个代码库开始让人觉得要在众多小模块间来回弹跳太多才能理解一个概念时。它读取既有架构并提议在哪里加深它。如果你已经知道想要重新设计的模块，只需要词汇来把它想清楚，改用 [codebase-design](https://aihero.dev/skills-codebase-design)——这个技能是找出候选的勘测；那个是设计工作台。

## Deepening opportunities

整个技能围绕一个理念转：**深度（depth）**。一个深模块在小而稳定的接口后面隐藏大量功能；一个浅模块通过一个几乎和它底下代码一样宽的接口泄漏它的实现。报告猎捕浅薄——那些仅为可测试性而提取的纯函数（真正的 bug 藏在它们如何被调用之中，没有**局部性（locality）**）、跨其**接缝**泄漏的模块、不打开五个文件就无法理解的概念——并提议能修复它的加深。

它说共享的设计词汇（**module**、**interface**、**depth**、**seam**、**adapter**、**leverage**、**locality**），也说来自 `CONTEXT.md` 的你项目自己的领域语言，因此一个候选读起来像"加深 Order 接收模块"，绝不是"重构 FooBarHandler"。

## The report, then the grill

输出是一个写入你操作系统临时目录的、可在浏览器中打开的 HTML 文件——没有东西落进仓库。每个候选是一张卡片，含涉及的文件、摩擦点、平实英语的解决方案、以局部性和杠杆表述的收益、一张前后对比图，以及一个 `Strong` / `Worth exploring` / `Speculative` 徽章。它以它会最先着手的那个收尾。

然后它停下并询问你想探索哪一个。挑一个，它就在那个设计上运行 [grilling](https://aihero.dev/skills-grilling) 回路——约束、接缝后面是什么、哪些测试幸存——并在决策成型时就地更新领域模型。

## 它的位置

`improve-codebase-architecture` 是**周期性维护**——每隔几天运行一次，而不是作为一条链中的步骤。它的邻居有 [codebase-design](https://aihero.dev/skills-codebase-design)，后者拥有每个候选据以书写的深度-与-接缝词汇；[grilling](https://aihero.dev/skills-grilling)，它在你选定候选后走过设计树；以及 [domain-modeling](https://aihero.dev/skills-domain-modeling)，它在重新设计尘埃落定时让 `CONTEXT.md` 和 ADR 保持最新。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
