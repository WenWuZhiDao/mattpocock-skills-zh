Quickstart:

```bash
npx skills add mattpocock/skills --skill=codebase-design
```

```bash
npx skills update codebase-design
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/codebase-design)

## 它做什么

`codebase-design` 给你一套共享、精确的词汇，用于设计**深模块（deep modules）**——在小接口后面藏起大量行为，放置在干净的接缝处，可通过该接口测试。

它是一种**语言，而非流程**。它不重构你的代码，也不递给你一份重构计划——它固定词语（module、interface、depth、seam、adapter、leverage、locality），使每一次设计对话以及每一个触及设计的其他技能都以同样的方式说话。一致的语言正是重点所在；"component"、"service"、"API"、"boundary"被刻意禁用，因为它们模糊了那些重要的区分。

## 何时使用它

输入 `/codebase-design`，或者当任务契合时智能体会自动触及它。

当你在设计或改进一个模块的接口、寻找加深机会、决定接缝放在哪里，或让代码更可测试、更利于 AI 导航时，触及它。其他技能在需要深模块词汇时会拉入它。如果你想打磨的是项目的_领域_术语而非它的模块设计，改用 [domain-modeling](https://aihero.dev/skills-domain-modeling)；要对既有代码库跑一整趟架构梳理，用 [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture)。

## Deep, not shallow

当大量行为位于小接口之后时，模块是**深**的；当接口几乎和实现一样复杂时，它是**浅**的。深度以**杠杆（leverage）**衡量——调用方（或测试）为它必须学习的每单位接口能操练多少。关键在于，深度是_接口_的属性，而非实现的：一个深模块内部可以由从不暴露给调用方的、小而可替换的部件组成。

两个检查完成了大部分工作。**删除测试（deletion test）**：设想删除该模块——如果复杂性消失，它就是一个直通（pass-through）；如果它在 N 个调用方处重新出现，它就物有所值。以及**一个适配器意味着一个假设的接缝；两个适配器才意味着一个真实的接缝**——在真正有东西跨它变化之前，别切出接缝。

## The interface is the test surface

调用方和测试跨越同一个接缝，所以一个放置得当的接口在底层代码自由移动的同时，给测试一个持久可瞄准的东西。这就是为什么该词汇坚持用 **seam（接缝）**（Feathers 的术语——一个你无需在那里编辑就能改变行为的地方）而非被过度使用的"boundary"，也是为什么这里的"interface"意味着_调用方必须知道的每一个事实_：签名，是的，还有不变式、顺序、错误模式和性能——不只是类型层面的表面。

## Pulled out on purpose

`codebase-design` 是深模块词汇的**单一真相来源**，被拆分成它自己的模型调用技能，使任何东西都能触及它。其他技能指向它而不是重述那些词语：[tdd](https://aihero.dev/skills-tdd) 借用它，在写测试之前放置一个接缝；[improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture) 在重构既有代码时依靠它；[to-prd](https://aihero.dev/skills-to-prd) 在写规格之前勾勒接缝和加深机会时说这套语言。

保持它独立的意义在于，你也可以单独触及它——作为一个思考模块设计的**参考**——而不触发上述任何技能所强制的更大流程。把词语固定一次，固定在一个地方，每一次设计对话都继承它们。

## 它的位置

`codebase-design` 是一个**随时可触及的独立技能**——工程技能之下的共享词汇层。它最近的邻居是 [domain-modeling](https://aihero.dev/skills-domain-modeling)，即针对问题领域而非模块结构的平行词汇技能。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
