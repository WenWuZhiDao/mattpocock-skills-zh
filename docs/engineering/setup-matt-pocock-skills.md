快速开始：

```bash
npx skills add mattpocock/skills --skill=setup-matt-pocock-skills
```

```bash
npx skills update setup-matt-pocock-skills
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/setup-matt-pocock-skills)

## 它做什么

`setup-matt-pocock-skills` 教会一个仓库工程技能在其中应当如何表现——issue 存放在哪里、分诊标签叫什么名字、领域文档坐落何处——并把这些答案记录为其他技能会读取的**配置**。

它写入配置，而不是把行为写死。工程链条假定 `docs/agents/` 下存在三个文件；这个技能就是产出它们的一次性引导程序，它们从你真实的仓库中发现（`git remote`、已有的标签、已有的 `CONTEXT.md`），并与你确认而非靠猜。它是提示驱动的——探索、呈现所发现的内容、确认，然后写入——而不是一个确定性的脚手架。

## 何时使用它

你通过输入 `/setup-matt-pocock-skills` 来调用它——智能体不会自行触发它。

**每个仓库运行一次，在首次使用任何其他工程技能之前**用它。如果 [triage](https://aihero.dev/skills-triage)、[to-spec](https://aihero.dev/skills-to-spec) 或 [to-tickets](https://aihero.dev/skills-to-tickets) 开始猜测你的 issue 存放在哪里，或者贴上并不存在的标签，那说明它们在这里还没被设置好。只有在切换 issue 跟踪器或从头再来时才重新运行它——日常的微调只是对 `docs/agents/*.md` 的编辑。

## 三项决策

它为每项都先给出一个你可以一言接受的推荐答案，并跳过任何它已经能推断出来的东西——所以大多数运行就是几次快速确认：

- **Issue 跟踪器**——工作在哪里被跟踪，好让 `triage`/`to-spec`/`to-tickets` 知道该调用 `gh`、`glab`、在 `.scratch/` 下写 markdown，还是遵循你描述的某个工作流。GitHub、GitLab、本地 markdown，或其他。（它会提出与你的 `git remote` 相匹配的那一个。）
- **分诊标签**——仅当 `triage` 技能已安装时才问，而且只问一句：保留默认标签（`needs-triage`、`needs-info`、`ready-for-agent`、`ready-for-human`、`wontfix`）吗？只有当你的跟踪器已经使用其他名称时才说不，好让 `triage` 贴上真实的标签而不是创建重复的。
- **领域文档**——假定为单上下文（根目录一个 `CONTEXT.md` + `docs/adr/`），这适合几乎每一个仓库；只有当它察觉到 monorepo 的信号时才会提出一张多上下文地图。

输出是 `docs/agents/` 下的一组文件——`issue-tracker.md`、`domain.md`，以及在 `triage` 已安装时的 `triage-labels.md`——外加在仓库已经使用的 `CLAUDE.md` / `AGENTS.md` 之一中一个指向它们的 `## Agent skills` 区块。这些文件就是工具集其余部分赖以立足的共享基底。

## 它生效的标志

- `issue-tracker.md` 和 `domain.md` 落进 `docs/agents/` 下（在 `triage` 已安装时再加 `triage-labels.md`），并且你的 `CLAUDE.md` 或 `AGENTS.md` 中出现一个 `## Agent skills` 小节。
- 它提出的跟踪器与你真实的 `git remote` 相匹配，标签与你仓库中已经存在的字符串相匹配。
- 之后，`triage` 和 `to-tickets` 会用正确的标签在正确的地方行动，而不是发问或猜测。

## 它的位置

`setup-matt-pocock-skills` 是一次**只运行一次的设置**——整套工程技能赖以立足的地基，而不是一个你会重复的步骤。它的邻居是那些读取它所写内容的技能：[triage](https://aihero.dev/skills-triage)，因为它应用这里配置的标签词汇，以及 [to-spec](https://aihero.dev/skills-to-spec) / [to-tickets](https://aihero.dev/skills-to-tickets)，因为它们发布到这里配置的 issue 跟踪器。先运行它；下游的一切都假定它已经运行过。当你不确定该用哪个技能或流程时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你指路。
