快速开始：

```bash
npx skills add mattpocock/skills --skill=to-tickets
```

```bash
npx skills update to-tickets
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/to-tickets)

## 它做什么

`to-tickets` 把一个计划、一份规格或当前对话拆成一组**工单**——每一张都是一颗曳光弹式的垂直切片——并发布到你配置好的跟踪器，每张工单都声明阻塞它的那些工单。

每张工单都是一颗**曳光弹**——一片薄薄的*垂直*切片，端到端地贯穿所有集成层（schema、API、UI、测试），绝不是某一层的水平切片。一片完成的切片自身即可演示或可验证，这正是让每张工单都能安全交给智能体的原因。

## 何时使用它

你通过输入 `/to-tickets` 来调用它——智能体不会自行触发它。

一旦你有了一个商定的计划或一份写就的规格，而你想把它拆成工单时，就用它。把它指向对话，或者传入一份规格或 issue 引用，它会先取回正文和评论。如果改动还没被写成规格，先产出一份——为此请用 [to-spec](https://aihero.dev/skills-to-spec)。

## 前置条件

`to-tickets` 发布到你的 issue 跟踪器，所以 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) 必须先为这个仓库配置好跟踪器及其分诊标签词汇。在真实的跟踪器上，它会在发布时贴上 ready-for-agent 标签。

## 一份产物，两种读法

阻塞边是关键所在。它们让同一组工单有两种读法，取决于跟踪器：

- **本地文件** → `.scratch/<feature>/issues/` 下每张工单一个文件，按阻塞者优先编号，边以文本写出。你自上而下、手动地推进它们，始终在回路之中。
- **真实的跟踪器（GitHub、Linear）** → 每张工单一个 issue，边作为原生的阻塞链接（或子 issue）。任何阻塞者都已完成的工单就处在**前沿**上，可以被抓取——所以多个智能体能同时运行。

无论媒介如何，边都活在工单里；媒介只决定是否有东西会并行地对它们采取行动。`to-tickets` 产出产物——你如何运行它（手动串行，还是并行的机群）由你决定。

## 垂直切片，而非水平切片

整个技能围绕一个区别转动。一片**水平**切片交付改动的一层——全部 schema，或全部 API——而在每一层都落地之前什么都不能用。一片**垂直**切片，即曳光弹，一次性交付一条穿过*每一*层的窄路径，所以它一完成就能被演示。

在切片之前，`to-tickets` 寻找预重构——"让改动变容易，然后做那个容易的改动"——并把那份工作排在最前。然后它就拆分方式（粒度、阻塞边、要合并还是拆开什么）盘问你，之后才发布任何东西，并且先发布阻塞者，好让每张工单的"Blocked by"都能引用一张真实的工单。

## 宽重构例外

有一种形状打破了曳光弹规则：**宽重构**——一次单一的机械改动（重命名一列、给一个共享符号重新定型），其**冲击半径**扇形散布到整个代码库，所以一次编辑会同时弄坏数千个调用点，没有任何垂直切片能落地为绿。`to-tickets` 转而把它切为**扩张—收缩**：扩张（在旧形式旁边加上新形式，好让什么都不坏）、迁移（按冲击半径大小分批把调用点迁过去，每批一张工单，全程 CI 为绿因为旧形式仍然存在），然后收缩（一旦没有调用者残留就删掉旧形式）。当连各批次都无法单独保持为绿时，它们共享一条集成分支，全都阻塞一张最终的集成并验证工单，而绿只在那里被承诺。

## 它的位置

`to-tickets` 是主构建链中的一步：

```txt
grill-with-docs → to-spec → to-tickets → implement → code-review
```

它坐落在 [to-spec](https://aihero.dev/skills-to-spec) 和 [implement](https://aihero.dev/skills-implement) 之间——前者递给它一份带用户故事的敲定规格供其切分，后者构建每一张工单，在内部驱动 [tdd](https://aihero.dev/skills-tdd) 测试先行地写测试，然后再走它的 [code-review](https://aihero.dev/skills-code-review) 环节。在前沿上推进时每张工单用一个全新的上下文，彼此之间清空上下文。当你不确定该用哪个技能或流程时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你指路。
