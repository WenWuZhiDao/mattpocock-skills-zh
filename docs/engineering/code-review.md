快速开始：

```bash
npx skills add mattpocock/skills --skill=code-review
```

```bash
npx skills update code-review
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/code-review)

## 它做什么

`code-review` 评审 `HEAD` 与你指定的某个固定点之间的差异——一个提交、分支、标签或合并基点——沿两条彼此独立的轴线展开：**标准**（代码是否遵循本仓库有文档记录的约定？）和**规格**（它是否实现了原始 issue 或规格所要求的内容？）。它把每条轴作为各自独立的并行子智能体运行，并把结果并排呈现。它从不合并或重新排序这两组发现——保持它们分离才是关键所在，因为一个改动可能通过一条轴却在另一条轴上失败，而单一的混合结论会让一条掩盖另一条。

## 何时使用它

输入 `/code-review`，或者当你要求评审一个分支、一个 PR、进行中的改动，或任何"自 X 以来"的内容时，智能体会自动触发它。

当存在一个差异需要对照一个已知良好的点来评判，并且你想让两个问题——*它是否构建得对？*和*它是不是该做的东西？*——各自独立地得到回答时，就用它。它运行在构建循环的末尾；若要真正测试先行地写代码，请用 [tdd](https://aihero.dev/skills-tdd)；若要把整份规格构建成代码，请用 [implement](https://aihero.dev/skills-implement)，它会在提交前运行自己的 `/code-review` 环节。

## 前置条件

**规格**轴需要一个地方来找到原始规格——提交信息中的 issue 引用、你传入的路径，或者 `docs/`/`specs/` 下的某份规格。那套 issue 跟踪系统的接线来自 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills)；没有规格时，规格轴会直接跳过并如实说明。**标准**轴不需要任何设置——即使在一个没有任何约定文档的仓库里，它也始终自带一套内置的 Fowler 坏味道基线。

## 两条轴，绝不合并

其定义性的理念是**两条轴**。**标准**追问差异是否符合本仓库写代码的方式——它的 `CODING_STANDARDS.md` 或 `CONTRIBUTING.md`，外加一套约 12 种 Fowler 代码坏味道的固定基线（神秘命名、重复代码、依恋情结、数据泥团……）。两条规则保证这套基线安全：仓库有文档的标准始终覆盖它，并且每种坏味道都是一次判断,而非硬性违规。**规格**则追问那个正交的问题——代码是否做了 issue 或规格实际要求的事，没有遗漏需求，也没有夹带范围蔓延？

它们作为并行子智能体运行，以免彼此污染对方的上下文，最终报告在各自独立的 `## Standards` 和 `## Spec` 标题下呈现,并给出每条轴的小结。跨轴之间刻意不设单一赢家。

## 它生效的标志

- 它先固定并确认那个固定点（`git rev-parse`），遇到坏的引用或空差异会快速失败，而不是在子智能体内部才失败。
- 标准与规格的发现分成两个清晰的区块，各自引用来源——一个引用仓库标准或基线坏味道，另一个引用被援引的规格行。
- 当找不到任何规格时，规格轴会报告"没有可用规格"，而不是凭空捏造需求。

## 它的位置

`code-review` 是主构建链尾部的评审步骤：

```txt
grill-with-docs → to-spec → to-tickets → implement → code-review
```

它最近的邻居是 [implement](https://aihero.dev/skills-implement)，后者驱动构建并在提交前把它作为自己的评审环节来调用；在上游，它所对照的规格由 [to-spec](https://aihero.dev/skills-to-spec) 和 [to-tickets](https://aihero.dev/skills-to-tickets) 产出。当你不确定该用哪个技能或流程时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你指路。
