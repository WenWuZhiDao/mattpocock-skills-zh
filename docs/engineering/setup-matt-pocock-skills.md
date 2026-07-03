Quickstart:

```bash
npx skills add mattpocock/skills --skill=setup-matt-pocock-skills
```

```bash
npx skills update setup-matt-pocock-skills
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/setup-matt-pocock-skills)

## 它做什么

`setup-matt-pocock-skills` 教会一个仓库工程技能在其中该如何表现——issue 存放在哪里、分诊标签叫什么、领域文档放在哪儿——并把这些答案记录为其他技能读取的**配置（config）**。

它写配置，不硬编码行为。工程链假定 `docs/agents/` 下存在三个文件；这个技能就是产出它们的一次性引导，从你实际的仓库中发现（`git remote`、既有标签、既有的 `CONTEXT.md`）并与你确认，而不是猜测。它是提示驱动的——探索、呈现它发现的、确认、然后写入——而不是一个确定性的脚手架。

## 何时使用它

你通过输入 `/setup-matt-pocock-skills` 来调用它——智能体不会自行触及它。

**每个仓库一次，在首次使用任何其他工程技能之前**触及它。如果 [triage](https://aihero.dev/skills-triage)、[to-prd](https://aihero.dev/skills-to-prd) 或 [to-issues](https://aihero.dev/skills-to-issues) 开始猜测你的 issue 存放在哪里，或应用不存在的标签，那它们还没在这里被设置过。只在切换 issue 追踪器或重头再来时才重新运行它——日常的小调整只是对 `docs/agents/*.md` 的编辑。

## The three decisions

它带你走过三个选择，一次一个，每个都配一段平实语言的讲解（它假定你还不懂这些术语）：

- **Issue 追踪器**—— 工作在哪里被追踪，好让 `triage`/`to-prd`/`to-issues` 知道该调用 `gh`、`glab`、在 `.scratch/` 下写 markdown，还是遵循你描述的某个工作流。GitHub、GitLab、本地 markdown，或其他。
- **分诊标签**—— 五个规范角色（`needs-triage`、`needs-info`、`ready-for-agent`、`ready-for-human`、`wontfix`）背后的字符串，映射到你实际配置过的标签，好让 `triage` 应用真实的标签而不是创建重复的。
- **领域文档**—— 仓库是有一个 `CONTEXT.md` 还是一张多上下文的地图，好让读取领域语言的技能在正确的地方查找。

输出是三个文件——`docs/agents/issue-tracker.md`、`docs/agents/triage-labels.md`、`docs/agents/domain.md`——外加一个指向它们的 `## Agent skills` 块，放进 `CLAUDE.md` / `AGENTS.md` 中仓库已经在用的那一个。那些文件是整套工具链所立足的共享基底。

## 它生效的标志

- 三个文件落在 `docs/agents/` 下，且一个 `## Agent skills` 小节出现在你的 `CLAUDE.md` 或 `AGENTS.md` 中。
- 它提议的追踪器与你真实的 `git remote` 相符，标签与你仓库中已存在的字符串相符。
- 此后，`triage` 和 `to-issues` 在正确的地方、用正确的标签行动，而不是询问或猜测。

## 它的位置

`setup-matt-pocock-skills` 是一个**一次性设置**——整套工程技能所立足的地基，而不是一个你重复的步骤。它的邻居是那些读取它所写内容的技能：[triage](https://aihero.dev/skills-triage)，因为它应用这里配置的标签词汇；以及 [to-prd](https://aihero.dev/skills-to-prd) / [to-issues](https://aihero.dev/skills-to-issues)，因为它们发布到这里配置的 issue 追踪器。先运行它；下游一切都假定它已运行。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
