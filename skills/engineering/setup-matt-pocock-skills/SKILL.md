---
name: setup-matt-pocock-skills
description: 为工程技能配置本仓库——设置它的 issue 跟踪器、分诊标签词汇和领域文档布局。在首次使用其他工程技能之前运行一次。
disable-model-invocation: true
---

# Setup Matt Pocock's Skills

搭建工程技能所假定的每仓库配置：

- **Issue 跟踪器**——issue 存放在哪里（默认 GitHub；本地 markdown 也开箱支持）
- **分诊标签**——用于五个标准分诊角色的字符串
- **领域文档**——`CONTEXT.md` 和 ADR 存放在哪里，以及阅读它们的消费者规则

这是一个提示驱动的技能，而不是一个确定性脚本。探索、呈现你发现的东西、与用户确认，然后写入。

## 流程

### 1. 探索

查看当前仓库以了解它的起始状态。有什么就读什么；不要臆断：

- `git remote -v` 和 `.git/config`——这是 GitHub 仓库吗？是哪一个？
- 仓库根目录的 `AGENTS.md` 和 `CLAUDE.md`——两者中是否有存在的？其中是否已有 `## Agent skills` 小节？
- 仓库根目录的 `CONTEXT.md` 和 `CONTEXT-MAP.md`
- `docs/adr/` 以及任何 `src/*/docs/adr/` 目录
- `docs/agents/`——这个技能之前的输出是否已经存在？
- `.scratch/`——本地 markdown issue 跟踪器约定已在使用的迹象
- `triage` 技能安装了吗？（本技能旁边有一个 `triage` 技能文件夹，或你的可用技能中有 `triage`。）这决定了 B 部分是否会运行。
- 单体仓库信号——一个 `pnpm-workspace.yaml`、`package.json` 中的 `workspaces` 字段，或一个填充了内容、拥有自己 `src/` 的 `packages/*`。只有在真正庞大的多包仓库中才存在；它们的缺失意味着单上下文，几乎每个仓库都是如此。

### 2. 呈现发现并询问

概述有什么、缺什么。然后按顺序处理各部分——一个部分、一个答案，再下一个。

每个部分以推荐答案开头，好让用户一个词就能接受。只有当选择确实会分叉时才给一行说明；当探索已经把它敲定时（`triage` 未安装时的 B 部分、没有单体仓库时的 C 部分）就整个跳过该部分。

**A 部分——Issue 跟踪器。**

> 说明：所谓"issue 跟踪器"就是本仓库的 issue 存放之处。`to-tickets`、`triage`、`to-spec`、`qa` 等技能会从中读取、向其写入——它们需要知道是该调用 `gh issue create`、在 `.scratch/` 下写一个 markdown 文件，还是遵循你描述的其他工作流。选择你实际为本仓库跟踪工作的地方。

默认姿态：这些技能是为 GitHub 设计的。如果某个 `git remote` 指向 GitHub，就提议它。如果某个 `git remote` 指向 GitLab（`gitlab.com` 或自托管主机），就提议 GitLab。否则（或者如果用户偏好如此），提供：

- **GitHub**——issue 存放在仓库的 GitHub Issues 中（使用 `gh` CLI）
- **GitLab**——issue 存放在仓库的 GitLab Issues 中（使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI）
- **本地 markdown**——issue 以本仓库中 `.scratch/<feature>/` 下的文件形式存放（适合单人项目或没有远端的仓库）
- **其他**（Jira、Linear 等）——请用户用一段话描述工作流；技能会把它记录为自由格式的散文

把选择记录在 `docs/agents/issue-tracker.md` 中。GitHub 和 GitLab 模板都带有一个"PR 作为请求入口"的标志，默认**关闭**——保持关闭、不要提起它；想把外部 PR 纳入分诊队列的用户可以稍后在文件里翻转这个标志。

**B 部分——分诊标签词汇。** 如果 `triage` 技能未安装（探索已告诉你），就整个跳过这部分——未安装的技能不需要标签。

如果它已安装，就恰好问一个问题：

> 你想保留默认的分诊标签吗？（推荐：**是**）

默认值是五个标准角色，每个标签字符串等于它的名字：`needs-triage`、`needs-info`、`ready-for-agent`、`ready-for-human`、`wontfix`。选**是**时，按原样写入。只有当用户说否时——通常是因为他们的跟踪器已经用了别的名字（例如用 `bug:triage` 表示 `needs-triage`）——才收集覆盖项，让 `triage` 应用既有标签而不是创建重复的。

**C 部分——领域文档。** 默认为**单上下文**——仓库根目录一个 `CONTEXT.md` + `docs/adr/`。这适合几乎每个仓库；不用问就写入。

只有当探索发现了单体仓库信号时，才提供**多上下文**——一个根 `CONTEXT-MAP.md` 指向各上下文的 `CONTEXT.md` 文件。然后确认他们想要哪种布局。

### 3. 确认并编辑

给用户展示以下草稿：

- 要加进 `CLAUDE.md` / `AGENTS.md` 中被编辑的那个的 `## Agent skills` 块（选择规则见第 4 步）
- `docs/agents/issue-tracker.md`、`docs/agents/domain.md` 和 `docs/agents/triage-labels.md` 的内容（最后一个仅在 `triage` 已安装时）

在写入之前让他们编辑。

### 4. 写入

**选择要编辑的文件：**

- 如果 `CLAUDE.md` 存在，编辑它。
- 否则如果 `AGENTS.md` 存在，编辑它。
- 如果两者都不存在，问用户创建哪一个——不要替他们选。

当 `CLAUDE.md` 已存在时绝不创建 `AGENTS.md`（反之亦然）——始终编辑已经在那里的那个。

如果所选文件中已存在 `## Agent skills` 块，就就地更新它的内容，而不是追加一个重复的。不要覆盖用户对周围各小节的编辑。

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

只有当 `triage` 已安装且 B 部分运行过时，才包含 `### Triage labels` 子块并写 `docs/agents/triage-labels.md`。当它没有时，两者都省略。

然后以本技能文件夹中的种子模板为起点写入各文档文件：

- [issue-tracker-github.md](./issue-tracker-github.md)——GitHub issue 跟踪器
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md)——GitLab issue 跟踪器
- [issue-tracker-local.md](./issue-tracker-local.md)——本地 markdown issue 跟踪器
- [triage-labels.md](./triage-labels.md)——标签映射（仅当 `triage` 已安装）
- [domain.md](./domain.md)——领域文档消费者规则 + 布局

对于"其他"issue 跟踪器，用用户的描述从头写 `docs/agents/issue-tracker.md`。

### 5. 完成

告诉用户设置已完成，以及现在哪些工程技能会从这些文件读取。提一句他们以后可以直接编辑 `docs/agents/*.md`——只有当他们想切换 issue 跟踪器或从头重新开始时，才需要重新运行这个技能。
