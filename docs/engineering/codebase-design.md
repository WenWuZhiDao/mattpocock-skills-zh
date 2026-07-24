快速开始：

```bash
npx skills add mattpocock/skills --skill=codebase-design
```

```bash
npx skills update codebase-design
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/codebase-design)

## 它做什么

`codebase-design` 给你一套共享而精确的词汇，用来设计**深模块**——大量行为隐藏在一个小接口之后，安置在一条干净的接缝处，并可透过该接口进行测试。

它是一门**语言，不是一套流程**。它不会重构你的代码，也不会给你一份重构计划——它锚定用词（模块、接口、深度、接缝、适配器、杠杆、局部性），从而让每一次设计对话、以及每一个触及设计的其他技能都用同一种方式说话。语言一致才是关键所在；"组件（component）"、"服务（service）"、"API"和"边界（boundary）"被刻意禁用，因为它们模糊了那些真正重要的区别。

## 何时使用它

输入 `/codebase-design`，或者当任务契合时智能体会自动触发它。

当你在设计或改进一个模块的接口、寻找加深的机会、决定接缝该落在何处，或者让代码更可测、更便于 AI 导航时，就用它。其他技能只要需要深模块的词汇，就会把它拉进来。如果你想打磨的是项目的*领域*术语而非其模块设计，请改用 [domain-modeling](https://aihero.dev/skills-domain-modeling)；若要对一个已有的代码库做一整轮架构梳理，请用 [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture)。

## 深，而非浅

当大量行为坐落在一个小接口之后时，模块就是**深**的；当接口几乎和实现一样复杂时，它就是**浅**的。深度以**杠杆**来衡量——调用方（或测试）为其必须学习的每单位接口，能撬动多少行为。关键在于，深度是*接口*的属性，而非实现的属性：一个深模块内部完全可以由许多可替换的小部件组成，只是这些部件从不浮现到调用方面前。

两项检查做了大部分工作。**删除测试**：设想删掉这个模块——如果复杂度就此消失，那它只是个直通管道；如果复杂度在 N 个调用方处重新冒出来，那它就物有所值。以及**一个适配器意味着假想的接缝；两个适配器才意味着真实的接缝**——在真正有东西跨接缝变化之前，别急着切出一条接缝。

## 接口就是测试面

调用方和测试跨越的是同一条接缝，因此一个安置得当的接口给了测试一个持久的瞄准点，而底下的代码可以自由挪动。这正是为什么这套词汇坚持用**接缝**（Feathers 的术语——一个你无需在原地编辑就能改变行为的位置），而不是被过度使用的"边界"；也是为什么这里的"接口"意味着*调用方必须知道的每一个事实*：不只是签名，还有不变式、顺序、错误模式和性能——而不仅仅是类型层面的表面。

## 有意拆分出来

`codebase-design` 是深模块词汇的**唯一真实来源**，被拆分成它自己的模型可调用技能，以便任何东西都能取用它。其他技能指向它,而不是重述这些用词：[tdd](https://aihero.dev/skills-tdd) 借用它在写测试前安置一条接缝，[improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture) 在重构现有代码时倚赖它，[to-spec](https://aihero.dev/skills-to-spec) 在写规格前勾勒接缝与加深机会时说着它的语言。

保持它独立的意义在于，你也可以单独取用它——作为一份关于如何思考模块设计的**参考**——而不必触发那些技能所强制的更大流程。把用词一次性地在一个地方锚定好，之后每一次设计对话都会继承它们。

## 它的位置

`codebase-design` 是一个**随时可取用的独立技能**——工程技能之下的共享词汇层。它最近的邻居是 [domain-modeling](https://aihero.dev/skills-domain-modeling)，那是面向问题领域而非模块结构的平行词汇技能。当你不确定该用哪个技能或流程时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你指路。
