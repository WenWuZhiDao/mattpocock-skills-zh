Quickstart:

```bash
npx skills add mattpocock/skills --skill=writing-great-skills
```

```bash
npx skills update writing-great-skills
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/productivity/writing-great-skills)

## 它做什么

`writing-great-skills` 是你据以编写和编辑技能的参考——那套让技能变得可预测的共享词汇与原则。

一个技能的职责是从一个随机系统中拧出确定性，所以目标不是每次运行都有相同的_输出_，而是相同的_过程_。**可预测性（predictability）**是根本美德，每一个设计选择都据它评判——而不是据技能读起来有多聪明、多完整、多详尽。

## 何时使用它

你通过输入 `/writing-great-skills` 来调用它——智能体不会自行触及它。

每当你在创作一个新技能或编辑一个既有技能、并想让它每次都以同样方式表现时触及它：决定调用模式、写一段描述、选择什么放进 `SKILL.md` 还是一个链接的文件，或诊断一个技能为何误触发。

## Cognitive load

整个参考所围绕的概念是**认知负荷（cognitive load）**——以及它的对应物，**上下文负荷（context load）**。每个技能花掉其一：

- 一个**模型调用**技能每一轮都在窗口里留着一段描述，所以它花**上下文负荷**，但会自行触发。
- 一个**用户调用**技能剥掉那段描述；它花零上下文负荷，但现在_你_就是那个必须记住它存在的索引——那就是**认知负荷**。

这些技能大多是用户调用的，这正是为什么认知负荷是整个系统被建来管理的压力：当用户调用技能多到超出你脑子装得下的量时，解药是一个命名其余技能、并说明何时去触及每一个的**路由器技能**。一旦你开始用这两种负荷来思考，大多数创作决策——拆分还是不拆、内联还是披露、模型调用还是用户调用——就变成同一笔权衡在不同地方的体现。

## The other levers

参考的其余部分是把那些负荷花得好的工具箱：

- **领头词（Leading words）**—— 一个模型预训练中已有的紧凑概念（_tight_、_red_、_tracer bullet_），智能体在运行技能时用它来思考。它以最少的 token 同时锚定执行_和_调用；猎捕那些一个词就能退休的重述。
- **信息层级（Information hierarchy）**—— 从技能内的步骤，到技能内的参考，再到藏在一个**上下文指针（context pointer）**后面的外部参考的阶梯。**渐进披露（progressive disclosure）**是沿那架梯子往下走的动作，好让顶层保持可读。
- **修剪（Pruning）**—— 单一真相来源、相关性，以及逐句施加的无操作（no-op）测试，对抗**沉积（sediment）**和**蔓延（sprawl）**。
- **失败模式（Failure modes）**—— **过早完成（premature completion）**、**重复（duplication）**、**沉积（sediment）**、**蔓延（sprawl）**、**无操作（no-op）**——用来诊断一个表现不佳的技能。

## 它的位置

这是一个随时可触及的独立参考——你在构建其余整套技能时查阅的元技能，而非某条链中的步骤。它天然的邻居是你维护的任何路由器，因为路由器是用户调用技能所堆积的认知负荷的直接解药；当你不确定哪个技能或流程契合一个任务时，[ask-matt](https://aihero.dev/skills-ask-matt) 在整套之上为你路由。
