---
name: setup-matt-pocock-skills
description: 为这些工程技能配置本仓库——设置它的工单跟踪器、分诊标签词汇和领域文档布局。在首次使用其他工程技能之前运行一次。
disable-model-invocation: true
---

# 设置 Matt Pocock 的技能

搭建这些工程技能所假定的每仓库配置：

- **工单跟踪器** — 工单存在哪里（默认 GitHub；本地 markdown 也开箱即用）
- **分诊标签** — 用于五个规范分诊角色的字符串
- **领域文档** — `CONTEXT.md` 和 ADR 存在哪里，以及读取它们的消费者规则

这是一个由提示词驱动的技能，不是一个确定性脚本。探索、呈现你的发现、与用户确认，然后写入。

## 流程

### 1. 探索

看一眼当前仓库，理解它的起始状态。读任何已经存在的东西；不要假设：

- `git remote -v` 和 `.git/config` — 这是一个 GitHub 仓库吗？哪一个？
- 仓库根目录的 `AGENTS.md` 和 `CLAUDE.md` — 有任何一个存在吗？其中是否已经有一个 `## Agent skills` 段落？
- 仓库根目录的 `CONTEXT.md` 和 `CONTEXT-MAP.md`
- `docs/adr/` 和任何 `src/*/docs/adr/` 目录
- `docs/agents/` — 这个技能之前的输出是否已经存在？
- `.scratch/` — 一个本地 markdown 工单跟踪器约定已经在用的迹象
- `triage` 技能安装了吗？（这个技能旁边有一个 `triage` 技能文件夹，或者你可用的技能里有 `triage`。）这决定了 B 节到底要不要跑。
- 单体仓库（monorepo）信号——一个 `pnpm-workspace.yaml`、`package.json` 里的 `workspaces` 字段，或者一个填充了内容、带自己 `src/` 的 `packages/*`。只在一个真正庞大的多包仓库里才出现；它们的缺席意味着单上下文，几乎每个仓库都是如此。

### 2. 呈现发现并询问

概述什么在场、什么缺失。然后按顺序拿下各节——一节，一个答案，然后下一节。

每节先给出推荐答案，好让用户一个词就能接受它。只在选择确实产生分支时给一行说明；当探索已经定夺时整节跳过（`triage` 未安装时跳过 B 节，没有单体仓库时跳过 C 节）。

**A 节 — 工单跟踪器。**

> 说明：「工单跟踪器」是这个仓库的工单存在哪里。像 `to-tickets`、`triage` 和 `to-spec` 这样的技能从中读取、向其写入——它们需要知道该调用 `gh issue create`、写一个 `.scratch/` 下的 markdown 文件，还是遵循你描述的某个其他工作流。选你为这个仓库实际跟踪工作的那个地方。

默认姿态：这些技能是为 GitHub 设计的。如果一个 `git remote` 指向 GitHub，就提议它。如果一个 `git remote` 指向 GitLab（`gitlab.com` 或自托管的主机），就提议 GitLab。否则（或者如果用户更愿意），提供：

- **GitHub** — 工单存在仓库的 GitHub Issues 里（用 `gh` CLI）
- **GitLab** — 工单存在仓库的 GitLab Issues 里（用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI）
- **本地 markdown** — 工单作为文件存在本仓库的 `.scratch/<feature>/` 下（适合个人项目或没有远端的仓库）
- **其他**（Jira、Linear 等）— 请用户用一段话描述该工作流；技能会把它记录成自由格式的散文

把选择记录在 `docs/agents/issue-tracker.md` 里。GitHub 和 GitLab 模板携带一个「PR 作为请求入口」标志，默认**关**——保持它关闭且不要提起它；想把外部 PR 纳入分诊队列的用户以后可以在文件里翻开这个标志。

**B 节 — 分诊标签词汇。** 如果 `triage` 技能没安装（探索已经告诉你了），就整节跳过——一个没安装的技能不需要标签。

如果它确实安装了，就只问一个问题：

> 你想保留默认的分诊标签吗？（推荐：**是**）

默认值是五个规范角色，每个标签字符串都等于它的名字：`needs-triage`、`needs-info`、`ready-for-agent`、`ready-for-human`、`wontfix`。在**是**的情况下，原样写入它们。只有当用户说不时——通常是因为他们的跟踪器已经用了其他名字（例如用 `bug:triage` 代表 `needs-triage`）——才收集这些覆盖项，好让 `triage` 应用已有的标签而不是创建重复的。

**C 节 — 领域文档。** 默认走**单上下文**——仓库根目录一个 `CONTEXT.md` + `docs/adr/`。这适合几乎每个仓库；不问就写。

只在探索发现了单体仓库信号时，才提供**多上下文**——一个根目录的 `CONTEXT-MAP.md` 指向各上下文的 `CONTEXT.md` 文件。然后确认他们想要哪种布局。

### 3. 确认并编辑

给用户展示以下内容的草稿：

- 要加进 `CLAUDE.md` / `AGENTS.md` 中被编辑的那个文件里的 `## Agent skills` 块（选择规则见第 4 步）
- `docs/agents/issue-tracker.md`、`docs/agents/domain.md` 和 `docs/agents/triage-labels.md` 的内容（最后一个仅在 `triage` 安装时）

在写入之前让他们编辑。

### 4. 写入

**挑选要编辑的文件：**

- 如果 `CLAUDE.md` 存在，编辑它。
- 否则如果 `AGENTS.md` 存在，编辑它。
- 如果两者都不存在，问用户要创建哪一个——别替他们挑。

当 `CLAUDE.md` 已经存在时绝不创建 `AGENTS.md`（反之亦然）——始终编辑那个已经在的。

如果所选文件里已经存在一个 `## Agent skills` 块，就就地更新它的内容，而不是追加一个重复的。不要覆盖用户对周围各节的编辑。

这个块：

```markdown
## Agent skills

### Issue tracker

[one-line summary of where issues are tracked]. See `docs/agents/issue-tracker.md`.

### Triage labels

[one-line summary of the label vocabulary]. See `docs/agents/triage-labels.md`.

### Domain docs

[one-line summary of layout — "single-context" or "multi-context"]. See `docs/agents/domain.md`.
```

仅当 `triage` 安装且 B 节跑过时，才包含 `### Triage labels` 子块并写 `docs/agents/triage-labels.md`。当它没跑时，两者都省略。

然后以这个技能文件夹里的种子模板为起点写这些文档文件：

- [issue-tracker-github.md](./issue-tracker-github.md) — GitHub 工单跟踪器
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md) — GitLab 工单跟踪器
- [issue-tracker-local.md](./issue-tracker-local.md) — 本地 markdown 工单跟踪器
- [triage-labels.md](./triage-labels.md) — 标签映射（仅当 `triage` 安装时）
- [domain.md](./domain.md) — 领域文档消费者规则 + 布局

对于「其他」工单跟踪器，用用户的描述从头写 `docs/agents/issue-tracker.md`。

### 5. 完成

告诉用户设置已完成，以及现在哪些工程技能会从这些文件读取。提一句他们以后可以直接编辑 `docs/agents/*.md`——只有当他们想切换工单跟踪器或从头重来时，才需要重新运行这个技能。
