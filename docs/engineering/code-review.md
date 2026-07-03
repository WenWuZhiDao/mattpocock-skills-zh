Quickstart:

```bash
npx skills add mattpocock/skills --skill=code-review
```

```bash
npx skills update code-review
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/code-review)

## 它做什么

`code-review` 审查 `HEAD` 与你提供的一个固定点之间的 diff——某个提交、分支、标签或 merge-base——沿两个彼此分离的轴：**标准（Standards）**（代码是否遵循本仓库有记录的约定？）与**规格（Spec）**（它是否实现了源头 issue 或 PRD 所要求的？）。它把每个轴作为各自的并行子智能体运行，并把它们并列报告。它绝不合并或重新排列这两组发现——保持它们分离正是重点所在，因为一个改动可以通过一个轴而在另一个轴上失败，而单一混合的裁决会让一个掩盖另一个。

## 何时使用它

输入 `/code-review`，或者当你要求审查一个分支、一个 PR、进行中的改动或任何"since X"的内容时，智能体会自动触及它。

当有一份要对照已知良好点评判的 diff，且你想让两个问题——_它构建得对吗？_ 与 _它是对的东西吗？_——被独立回答时，触及它。它在构建回路的末尾运行；要真正以测试先行的方式写代码，用 [tdd](https://aihero.dev/skills-tdd)，要把整份规格构建成代码则用 [implement](https://aihero.dev/skills-implement)，后者在提交前会跑它自己的 `/code-review` 一遍。

## 前置条件

**规格**轴需要一个能找到源头规格的地方——提交信息中的 issue 引用、你传入的路径，或 `docs/`/`specs/` 下的 PRD。那套 issue 追踪器的接线来自 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills)；没有规格时，规格轴就直接跳过并如实说明。**标准**轴不需要任何设置——即使在一个未记录任何约定的仓库里，它也始终带着一个内建的 Fowler 坏味道基线。

## Two axes, never merged

定义性理念是**两个轴**。**标准**问的是 diff 是否符合本仓库的写码方式——它的 `CODING_STANDARDS.md` 或 `CONTRIBUTING.md`，加上约 12 条 Fowler 代码坏味道的固定基线（Mysterious Name、Duplicated Code、Feature Envy、Data Clumps……）。两条规则保证基线安全：仓库中已记录的标准始终覆盖它，且每条坏味道都是判断性意见，绝不是硬性违规。**规格**问的是正交的问题——代码是否做了 issue 或 PRD 实际要求的事，没有遗漏需求，也没有夹带范围蔓延？

它们作为并行子智能体运行，使两者互不污染上下文，最终报告在分开的 `## Standards` 和 `## Spec` 标题下呈现它们，并附每轴摘要。刻意不设跨轴的单一胜者。

## 它生效的标志

- 它先固定并确认那个固定点（`git rev-parse`），在坏的 ref 或空 diff 上快速失败，而不是在子智能体内部才失败。
- 标准和规格的发现出现在两个不同的块中，各自引用其来源——一个是仓库标准或基线坏味道，另一个是被引用的规格行。
- 当找不到规格时，规格轴报告"no spec available"，而不是虚构需求。

## 它的位置

`code-review` 是主构建链尾部的审查步骤：

```txt
grill-with-docs → to-prd → to-issues → implement → code-review
```

它最近的邻居是 [implement](https://aihero.dev/skills-implement)，后者驱动构建并在提交前把它作为自己的审查一遍来调用；上游，它对照检查的规格由 [to-prd](https://aihero.dev/skills-to-prd) 和 [to-issues](https://aihero.dev/skills-to-issues) 产出。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
