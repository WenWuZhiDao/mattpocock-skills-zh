快速开始：

```bash
npx skills add mattpocock/skills --skill=improve-codebase-architecture
```

```bash
npx skills update improve-codebase-architecture
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/improve-codebase-architecture)

## 它做什么

`improve-codebase-architecture` 扫描一个代码库，寻找**加深机会**——那些浅模块（接口几乎和它所隐藏之物一样复杂）本可以变成深模块的地方——把它们呈现为一份自包含的可视化 HTML 报告，然后就你挑中的那一个进行拷问。

它**不会**甩给你一份扁平的重构清单。每个候选都必须通过**删除测试**——删掉这个模块会把复杂度*收拢*到一个更小的接口之后，还是只是把它挪个地方？只有"收拢"的情况才配拥有一张卡片。正是这道过滤器，阻止了这份报告沦为泛泛的清理建议。

除非你把它指向某个特定区域，否则它还会把自己的范围收拢到开发实际落地的地方——读取近期提交，向你仍在改动的代码倾斜。加深一个模块的回报在于让日后对它的改动更容易，因此它对仓库中近期有过改动的部分给予额外权重。

## 何时使用它

你通过输入 `/improve-codebase-architecture` 来调用它——智能体不会自行触发它。

把它当作定期体检来用：每隔几天，或者每当一个代码库开始让你觉得，要理解一个概念得在小模块之间来回蹦跶太多次时。它读取现有架构，并提出在哪里加深它。如果你已经知道想重新设计哪个模块，只是需要词汇来把它想清楚，请改用 [codebase-design](https://aihero.dev/skills-codebase-design)——这个技能是找出候选的勘测，那个技能是设计工作台。

## 加深机会

整个技能围绕一个理念转动：**深度**。深模块把大量功能隐藏在一个小而稳定的接口之后；浅模块则透过一个几乎和底下代码一样宽的接口漏出自己的实现。报告搜寻的是浅——仅仅为了可测试性而抽出的纯函数，而真正的 bug 藏在它们如何被调用之中（没有**局部性**）、跨自己**接缝**漏出的模块、不打开五个文件就理解不了的概念——并提出能修复它的加深方案。

它说的是共享的设计词汇（**模块**、**接口**、**深度**、**接缝**、**适配器**、**杠杆**、**局部性**），以及来自 `CONTEXT.md` 的你项目自己的领域语言，所以一个候选读起来是"加深 Order 收单模块"，而绝不是"重构 FooBarHandler"。

## 先报告，再拷问

输出是一个可在浏览器中打开的 HTML 文件，写入你操作系统的临时目录——没有任何东西落进仓库。每个候选是一张卡片，包含所涉及的文件、摩擦点、一份平实英文的解决方案、以局部性和杠杆来衡量的收益、一张前后对比图，以及一枚 `Strong` / `Worth exploring` / `Speculative` 徽章。它以自己会最先着手的那一个收尾。

然后它停下来，问你想探索哪一个。挑一个，它就对那份设计运行 [grilling](https://aihero.dev/skills-grilling) 循环——约束、接缝之后坐落着什么、哪些测试能存活——并在决策成形时当场更新领域模型。

## 它的位置

`improve-codebase-architecture` 是**定期维护**——每隔几天运行一次，而不是作为某条链条中的一步。它的邻居是 [codebase-design](https://aihero.dev/skills-codebase-design)——它拥有每个候选所用的深度与接缝词汇，[grilling](https://aihero.dev/skills-grilling)——一旦你选定一个候选,它就走下决策树，以及 [domain-modeling](https://aihero.dev/skills-domain-modeling)——它在重新设计尘埃落定时让 `CONTEXT.md` 与 ADR 保持最新。当你不确定该用哪个技能或流程时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你指路。
