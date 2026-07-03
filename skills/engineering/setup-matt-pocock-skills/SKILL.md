---
name: setup-matt-pocock-skills
description: 为工程类技能配置本仓库——设置其问题追踪器、分诊标签词汇表和领域文档布局。在首次使用其他工程类技能之前运行一次。
disable-model-invocation: true
---

# 设置 Matt Pocock 的技能

搭建工程技能所假定的每仓库配置：

- **问题追踪器**——issue（问题）存放在哪里（默认 GitHub；本地 markdown 也开箱即用）
- **分诊标签**——用于五个规范分诊角色的字符串
- **领域文档**——`CONTEXT.md` 和 ADR 存放在哪里，以及阅读它们的消费者规则

这是一个由提示驱动的技能，而不是一个确定性脚本。探索、呈现你的发现、与用户确认，然后再写入。

## 流程

### 1. 探索

查看当前仓库以了解它的起始状态。有什么就读什么；不要臆断：

- `git remote -v` 和 `.git/config`——这是一个 GitHub 仓库吗？是哪一个？
- 仓库根目录的 `AGENTS.md` 和 `CLAUDE.md`——两者中是否有任一存在？其中是否已经有一个 `## Agent skills` 区块？
- 仓库根目录的 `CONTEXT.md` 和 `CONTEXT-MAP.md`
- `docs/adr/` 以及任何 `src/*/docs/adr/` 目录
- `docs/agents/`——这个技能之前的输出是否已经存在？
- `.scratch/`——表明本地 markdown 问题追踪约定已在使用的迹象

### 2. 呈现发现并询问

概括存在什么、缺少什么。然后**一次一个**地带用户走过这三个决策——呈现一个小节，得到用户的答复，再进入下一个。不要一次性把三个都倒出来。

假设用户不知道这些术语是什么意思。每个小节都以一段简短的说明开头（它是什么、为什么这些技能需要它、如果他们选得不同会有什么变化）。然后展示选项和默认值。

**小节 A — 问题追踪器。**

> 说明：「问题追踪器」是这个仓库的 issue（问题）存放之处。像 `to-issues`、`triage`、`to-prd` 和 `qa` 这样的技能会从中读取、向其写入——它们需要知道是要调用 `gh issue create`、在 `.scratch/` 下写一个 markdown 文件，还是遵循你所描述的其他工作流。选你实际用来追踪这个仓库工作的地方。

默认姿态：这些技能是为 GitHub 设计的。如果某个 `git remote` 指向 GitHub，就提议它。如果某个 `git remote` 指向 GitLab（`gitlab.com` 或自托管的主机），就提议 GitLab。否则（或者如果用户偏好），提供：

- **GitHub**——issue 存放在仓库的 GitHub Issues 中（使用 `gh` CLI）
- **GitLab**——issue 存放在仓库的 GitLab Issues 中（使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI）
- **本地 markdown**——issue 作为文件存放在这个仓库的 `.scratch/<feature>/` 下（适合单人项目或没有远程的仓库）
- **其他**（Jira、Linear 等）——请用户用一段话描述工作流；技能会把它记录为自由格式的散文

如果——且仅当——用户选了 **GitHub** 或 **GitLab**，追问一个问题：

> 说明：开源仓库常常以 pull request 的形式收到功能请求，而不只是 issue——一个 PR 就是一个附带了代码的 issue。如果你打开这个开关，`/triage` 会把_外部_ PR 拉进同一个队列，并让它们经过与 issue 相同的标签和状态（协作者进行中的 PR 会被放过不管）。如果 PR 对你而言不是一个请求入口，就把它关着。

- **PR 作为请求入口**——是 / 否（默认：否）。把答案记录在 `docs/agents/issue-tracker.md` 中。对于本地 markdown 和其他追踪器，跳过这个问题——它们没有 PR。

**小节 B — 分诊标签词汇。**

> 说明：当 `triage` 技能处理一个进来的 issue 时，它会让 issue 经过一个状态机——需要评估、等待报告者、准备好让一个 AFK 智能体接手、准备好让人类接手，或不予修复。要做到这一点，它需要打上（或在你的问题追踪器里的等价物）与你_实际配置过_的字符串相匹配的标签。如果你的仓库已经用了不同的标签名（例如 `bug:triage` 而非 `needs-triage`），就在这里把它们映射过来，好让技能打上正确的标签，而不是创建重复的。

五个规范角色：

- `needs-triage`——维护者需要评估
- `needs-info`——等待报告者
- `ready-for-agent`——已完全说明清楚、AFK 就绪（智能体无需人类上下文即可接手）
- `ready-for-human`——需要人类来实现
- `wontfix`——不会被处理

默认：每个角色的字符串等于它的名字。问用户是否想覆盖其中任何一个。如果他们的问题追踪器没有已有的标签，用默认值就行。

**小节 C — 领域文档。**

> 说明：有些技能（`improve-codebase-architecture`、`diagnosing-bugs`、`tdd`）会读取一个 `CONTEXT.md` 文件来学习项目的领域语言，并读取 `docs/adr/` 了解过去的架构决策。它们需要知道这个仓库是一个全局上下文还是多个（例如一个前后端上下文分离的 monorepo），以便去正确的地方查找。

确认布局：

- **单上下文**——仓库根目录一个 `CONTEXT.md` + `docs/adr/`。大多数仓库属于这种。
- **多上下文**——根目录一个 `CONTEXT-MAP.md`，指向各上下文各自的 `CONTEXT.md` 文件（通常是 monorepo）。

### 3. 确认并编辑

给用户展示以下内容的草稿：

- 要添加到 `CLAUDE.md` / `AGENTS.md` 中被编辑的那一个的 `## Agent skills` 区块（选择规则见步骤 4）
- `docs/agents/issue-tracker.md`、`docs/agents/triage-labels.md`、`docs/agents/domain.md` 的内容

在写入之前让他们编辑。

### 4. 写入

**挑选要编辑的文件：**

- 如果 `CLAUDE.md` 存在，就编辑它。
- 否则如果 `AGENTS.md` 存在，就编辑它。
- 如果两者都不存在，就问用户要创建哪一个——不要替他们做决定。

当 `CLAUDE.md` 已经存在时（或反之），绝不创建 `AGENTS.md`——始终编辑那个已经在那里的。

如果被选中的文件中已经存在一个 `## Agent skills` 区块，就就地更新它的内容，而不是追加一个重复的。不要覆盖用户对周围各小节的编辑。

该区块：

```markdown
## Agent skills

### Issue tracker

[one-line summary of where issues are tracked, plus whether external PRs are a triage surface]. See `docs/agents/issue-tracker.md`.

### Triage labels

[one-line summary of the label vocabulary]. See `docs/agents/triage-labels.md`.

### Domain docs

[one-line summary of layout — "single-context" or "multi-context"]. See `docs/agents/domain.md`.
```

然后用这个技能文件夹里的种子模板作为起点，写下这三个文档文件：

- [issue-tracker-github.md](./issue-tracker-github.md)——GitHub 问题追踪器
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md)——GitLab 问题追踪器
- [issue-tracker-local.md](./issue-tracker-local.md)——本地 markdown 问题追踪器
- [triage-labels.md](./triage-labels.md)——标签映射
- [domain.md](./domain.md)——领域文档消费者规则 + 布局

对于「其他」问题追踪器，根据用户的描述从零写出 `docs/agents/issue-tracker.md`。

### 5. 完成

告诉用户设置已完成，以及现在有哪些工程技能会从这些文件读取。提一句他们以后可以直接编辑 `docs/agents/*.md`——只有当他们想切换问题追踪器或从零重来时，才需要重新运行这个技能。
