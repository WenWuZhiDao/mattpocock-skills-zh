Quickstart:

```bash
npx skills add mattpocock/skills --skill=to-issues
```

```bash
npx skills update to-issues
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/to-issues)

## 它做什么

`to-issues` 把一个计划、规格或 PRD 拆成一组可独立认领的 issue，并按依赖顺序发布到你项目的 issue 追踪器。

每个 issue 都是一颗**曳光弹（tracer bullet）**——一个薄薄的_垂直_切片，端到端地穿过所有集成层（schema、API、UI、测试），绝不是某一层的水平切片。一个完成的切片可以独立演示或验证，这正是让由此产生的工单能安全交给独立智能体的东西。

## 何时使用它

你通过输入 `/to-issues` 来调用它——智能体不会自行触及它。

一旦你有了一个商定的计划或一份写好的规格，你想把它拆成智能体能拿起来做的工单时，触及它。把它指向对话，或传入一个既有的 issue 引用，它会先取回正文和评论。如果这个改动还没被写成规格，先产出一份——为此，用 [to-prd](https://aihero.dev/skills-to-prd)。

## 前置条件

`to-issues` 发布到你的 issue 追踪器，所以 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) 必须先为这个仓库配置好追踪器及其分诊标签词汇。它在发布时会自己应用 ready-for-agent 分诊标签。

## Vertical slices, not horizontal ones

整个技能围绕一个区分转。一个**水平**切片交付改动的一层——所有 schema，或所有 API——在每一层都落地之前什么都不工作。一个**垂直**切片，即曳光弹，一次交付一条穿过_每一_层的窄路径，因此它一完成就能被演示。

在切片之前，`to-issues` 寻找预重构——"先让改动变容易，再做那个容易的改动"——并把那份工作排在前面。然后它就拆分方式盘问你（粒度、依赖、要合并或拆分什么）再动笔，并先发布阻塞项，好让每个 issue 的"Blocked by"字段能引用一个真实的工单。

## 它的位置

`to-issues` 是主构建链中的一个步骤：

```txt
grill-with-docs → to-prd → to-issues → implement → code-review
```

它位于 [to-prd](https://aihero.dev/skills-to-prd)（它交给它一份带用户故事的稳定规格供切分）与 [implement](https://aihero.dev/skills-implement)（它构建每个可独立认领的 issue，在其 [code-review](https://aihero.dev/skills-code-review) 一遍之前，在内部驱动 [tdd](https://aihero.dev/skills-tdd) 以测试先行地写测试）之间。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
