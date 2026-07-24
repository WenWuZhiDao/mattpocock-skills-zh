# Issue tracker: GitHub

本仓库的 issue 和 PRD 以 GitHub issue 的形式存放。所有操作都使用 `gh` CLI。

## 约定

- **创建 issue**：`gh issue create --title "..." --body "..."`。多行正文使用 heredoc。
- **读取 issue**：`gh issue view <number> --comments`，用 `jq` 过滤评论，同时获取标签。
- **列出 issue**：`gh issue list --state open --json number,title,body,labels,comments --jq '[.[] | {number, title, body, labels: [.labels[].name], comments: [.comments[].body]}]'`，配合适当的 `--label` 和 `--state` 过滤。
- **在 issue 上评论**：`gh issue comment <number> --body "..."`
- **添加 / 移除标签**：`gh issue edit <number> --add-label "..."` / `--remove-label "..."`
- **关闭**：`gh issue close <number> --comment "..."`

从 `git remote -v` 推断仓库——在克隆内运行时 `gh` 会自动这么做。

## 把 Pull request 作为分诊入口

**PR 作为请求入口：否。** _（如果本仓库把外部 PR 当作功能请求，设为 `yes`；`/triage` 会读取这个标志。）_

设为 `yes` 时，PR 会走与 issue 相同的标签和状态，使用 `gh pr` 的等价命令：

- **读取 PR**：`gh pr view <number> --comments`，diff 用 `gh pr diff <number>`。
- **列出待分诊的外部 PR**：`gh pr list --state open --json number,title,body,labels,author,authorAssociation,comments`，然后只保留 `authorAssociation` 为 `CONTRIBUTOR`、`FIRST_TIME_CONTRIBUTOR` 或 `NONE` 的（去掉 `OWNER`/`MEMBER`/`COLLABORATOR`）。
- **评论 / 标签 / 关闭**：`gh pr comment`、`gh pr edit --add-label`/`--remove-label`、`gh pr close`。

GitHub 在 issue 和 PR 之间共享同一个编号空间，所以一个裸的 `#42` 可能是二者之一——用 `gh pr view 42` 解析，回退到 `gh issue view 42`。

## 当某个技能说"发布到 issue 跟踪器"时

创建一个 GitHub issue。

## 当某个技能说"获取相关工单"时

运行 `gh issue view <number> --comments`。

## 寻路操作

由 `/wayfinder` 使用。**地图**是单个 issue，以**子** issue 作为工单。

- **地图**：单个标注了 `wayfinder:map` 的 issue，承载 Notes / Decisions-so-far / Fog 正文。`gh issue create --label wayfinder:map`。
- **子工单**：作为 GitHub 子 issue 链接到地图的一个 issue（在 sub-issues 端点上用 `gh api`）。在未启用子 issue 的地方，把子项加进地图正文里的任务列表，并在子项正文顶部放 `Part of #<map>`。标签：`wayfinder:<type>`（`research`/`prototype`/`grilling`/`task`）。一旦认领，工单就被指派给正在驱动的开发者。
- **阻塞**：GitHub 的**原生 issue 依赖**——标准的、UI 可见的表示。用 `gh api --method POST repos/<owner>/<repo>/issues/<child>/dependencies/blocked_by -F issue_id=<blocker-db-id>` 添加一条边，其中 `<blocker-db-id>` 是阻塞项的数字**数据库 id**（`gh api repos/<owner>/<repo>/issues/<n> --jq .id`，*不是* `#number` 或 `node_id`）。GitHub 报告 `issue_dependencies_summary.blocked_by`（仅未关闭的阻塞项——实时的闸门）。在依赖不可用的地方，回退到子项正文顶部的一行 `Blocked by: #<n>, #<n>`。当每个阻塞项都关闭时，工单即解除阻塞。
- **前沿查询**：列出地图的未关闭子项（`gh issue list --state open`，限定到地图的子 issue / 任务列表），去掉任何有未关闭阻塞项（`issue_dependencies_summary.blocked_by > 0`，或 `Blocked by` 行中有未关闭 issue）或有指派人的；地图顺序中的第一个胜出。
- **认领**：`gh issue edit <n> --add-assignee @me`——会话的第一次写入。
- **解决**：`gh issue comment <n> --body "<answer>"`，然后 `gh issue close <n>`，再把一个上下文指针（gist + 链接）追加到地图的 Decisions-so-far。
