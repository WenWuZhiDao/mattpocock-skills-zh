---
name: setup-matt-pocock-skills
description: 在 AGENTS.md/CLAUDE.md 中设置 `## Agent skills` 区块，并建立 `docs/agents/`，让工程类技能了解本仓库的 issue 跟踪器（GitHub 或本地 markdown）、分诊标签词汇表和领域文档布局。在首次使用 `to-issues`、`to-prd`、`triage`、`diagnose`、`tdd`、`improve-codebase-architecture` 或 `zoom-out` 之前运行——或当这些技能似乎缺少关于 issue 跟踪器、分诊标签或领域文档的上下文时运行。
disable-model-invocation: true
---

# 配置 Matt Pocock 的技能

为工程类技能搭建所需的每仓库配置脚手架：

- **Issue tracker（问题追踪器）** — issue 存放的位置（默认 GitHub；开箱即用也支持本地 markdown）
- **Triage labels（分诊标签）** — 用于五个标准分诊角色的字符串
- **Domain docs（领域文档）** — `CONTEXT.md` 和 ADR 的存放位置，以及读取它们的消费规则

这是一个由 prompt 驱动的技能，而不是确定性脚本。先探查、再呈现你的发现、与用户确认，然后再写入。

## 流程

### 1. 探查

查看当前仓库以了解它的初始状态。读取已存在的内容；不要臆测：

- `git remote -v` 和 `.git/config` — 这是 GitHub 仓库吗？是哪一个？
- 仓库根目录下的 `AGENTS.md` 和 `CLAUDE.md` — 是否存在？其中是否已经有 `## Agent skills` 区块？
- 仓库根目录下的 `CONTEXT.md` 和 `CONTEXT-MAP.md`
- `docs/adr/` 以及任何 `src/*/docs/adr/` 目录
- `docs/agents/` — 本技能之前的输出是否已经存在？
- `.scratch/` — 表明已经在使用本地 markdown 的问题追踪约定

### 2. 呈现发现并提问

总结哪些存在、哪些缺失。然后**逐项**引导用户做出三项决策 —— 展示一个小节、获取用户的回答，再进入下一项。不要一次性把三项全部抛出。

假定用户并不知道这些术语的含义。每个小节都以简短的说明开头（它是什么、为什么这些技能需要它、如果选择不同会有什么变化）。然后给出选项和默认值。

**小节 A — Issue tracker（问题追踪器）。**

> 说明：“问题追踪器”是本仓库 issue 的存放位置。像 `to-issues`、`triage`、`to-prd` 和 `qa` 这样的技能会从中读取并写入 —— 它们需要知道是该调用 `gh issue create`、在 `.scratch/` 下写一个 markdown 文件，还是遵循你描述的其他工作流。选择你实际用来追踪这个仓库工作的地方。

默认姿态：这些技能是为 GitHub 设计的。如果某个 `git remote` 指向 GitHub，就推荐它。如果某个 `git remote` 指向 GitLab（`gitlab.com` 或自托管主机），就推荐 GitLab。否则（或用户更倾向）提供：

- **GitHub** — issue 存放在仓库的 GitHub Issues 中（使用 `gh` CLI）
- **GitLab** — issue 存放在仓库的 GitLab Issues 中（使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI）
- **Local markdown（本地 markdown）** — issue 以文件形式存放在本仓库的 `.scratch/<feature>/` 下（适合个人项目或没有远端的仓库）
- **Other（其他）**（Jira、Linear 等）— 让用户用一段话描述工作流；技能会将其作为自由格式的散文记录下来

**小节 B — Triage 标签词汇表。**

> 说明：当 `triage` 技能处理一个新进来的 issue 时，它会让该 issue 走过一个状态机 —— 需要评估、等待报告者、可由 AFK agent 接手、可由人类接手，或不予修复。为此，它需要应用与你*实际配置过*的字符串相匹配的标签（或你的问题追踪器中的等价物）。如果你的仓库已经使用了不同的标签名（例如用 `bug:triage` 而不是 `needs-triage`），就在这里映射它们，让技能应用正确的标签，而不是创建重复项。

五个标准角色：

- `needs-triage` — 维护者需要评估
- `needs-info` — 等待报告者
- `ready-for-agent` — 已完整定义、可 AFK 接手（agent 可以在无需人类背景的情况下接手）
- `ready-for-human` — 需要人类实现
- `wontfix` — 不会处理

默认值：每个角色的字符串等于其名称。询问用户是否想覆盖任何一项。如果他们的问题追踪器还没有现成标签，使用默认值即可。

**小节 C — Domain docs（领域文档）。**

> 说明：某些技能（`improve-codebase-architecture`、`diagnose`、`tdd`）会读取 `CONTEXT.md` 文件来学习项目的领域语言，并读取 `docs/adr/` 了解过去的架构决策。它们需要知道仓库是只有一个全局上下文还是有多个（例如一个 monorepo，前端/后端分属不同上下文），这样才能去正确的位置查找。

确认布局：

- **Single-context（单上下文）** — 仓库根目录下一个 `CONTEXT.md` + `docs/adr/`。大多数仓库属于这种。
- **Multi-context（多上下文）** — 根目录下一个 `CONTEXT-MAP.md`，指向各上下文的 `CONTEXT.md` 文件（通常是 monorepo）。

### 3. 确认并编辑

向用户展示以下内容的草稿：

- 要添加到 `CLAUDE.md` / `AGENTS.md`（具体编辑哪一个见第 4 步的选择规则）中的 `## Agent skills` 区块
- `docs/agents/issue-tracker.md`、`docs/agents/triage-labels.md`、`docs/agents/domain.md` 的内容

在写入之前让他们先编辑。

### 4. 写入

**选择要编辑的文件：**

- 如果 `CLAUDE.md` 存在，编辑它。
- 否则如果 `AGENTS.md` 存在，编辑它。
- 如果两者都不存在，询问用户要创建哪一个 —— 不要替他们决定。

当 `CLAUDE.md` 已存在时，绝不要创建 `AGENTS.md`（反之亦然）—— 始终编辑那个已经存在的文件。

如果所选文件中已经存在 `## Agent skills` 区块，就就地更新其内容，而不是追加一个重复项。不要覆盖用户对周围小节的编辑。

该区块：

```markdown
## Agent skills

### Issue tracker

[一行概括 issue 在哪里追踪]。见 `docs/agents/issue-tracker.md`。

### Triage labels

[一行概括标签词汇表]。见 `docs/agents/triage-labels.md`。

### Domain docs

[一行概括布局 —— “single-context” 或 “multi-context”]。见 `docs/agents/domain.md`。
```

然后以本技能文件夹中的种子模板为起点，写出这三个文档文件：

- [issue-tracker-github.md](./issue-tracker-github.md) — GitHub 问题追踪器
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md) — GitLab 问题追踪器
- [issue-tracker-local.md](./issue-tracker-local.md) — 本地 markdown 问题追踪器
- [triage-labels.md](./triage-labels.md) — 标签映射
- [domain.md](./domain.md) — 领域文档消费规则 + 布局

对于“其他”问题追踪器，根据用户的描述从零编写 `docs/agents/issue-tracker.md`。

### 5. 完成

告知用户配置已完成，以及现在哪些工程类技能会从这些文件中读取。提醒他们以后可以直接编辑 `docs/agents/*.md` —— 只有当他们想切换问题追踪器或从零重新开始时，才需要重新运行本技能。
