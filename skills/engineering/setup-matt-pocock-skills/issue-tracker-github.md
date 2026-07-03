# 问题追踪器：GitHub

这个仓库的 issue 和 PRD 以 GitHub issue 的形式存放。所有操作都使用 `gh` CLI。

## 约定

- **创建 issue**：`gh issue create --title "..." --body "..."`。多行正文使用 heredoc。
- **阅读 issue**：`gh issue view <number> --comments`，用 `jq` 过滤评论，同时也拉取标签。
- **列出 issue**：`gh issue list --state open --json number,title,body,labels,comments --jq '[.[] | {number, title, body, labels: [.labels[].name], comments: [.comments[].body]}]'`，配合适当的 `--label` 和 `--state` 过滤。
- **对 issue 评论**：`gh issue comment <number> --body "..."`
- **打上 / 移除标签**：`gh issue edit <number> --add-label "..."` / `--remove-label "..."`
- **关闭**：`gh issue close <number> --comment "..."`

从 `git remote -v` 推断仓库——`gh` 在克隆内部运行时会自动这样做。

## 把 pull request 作为分诊入口

**PR 作为请求入口：否。** _（如果这个仓库把外部 PR 当作功能请求，就设为 `yes`；`/triage` 会读取这个标志。）_

当设为 `yes` 时，PR 会经过与 issue 相同的标签和状态，使用 `gh pr` 的对应命令：

- **阅读 PR**：`gh pr view <number> --comments`，以及用 `gh pr diff <number>` 看 diff。
- **列出待分诊的外部 PR**：`gh pr list --state open --json number,title,body,labels,author,authorAssociation,comments`，然后只保留 `authorAssociation` 为 `CONTRIBUTOR`、`FIRST_TIME_CONTRIBUTOR` 或 `NONE` 的（去掉 `OWNER`/`MEMBER`/`COLLABORATOR`）。
- **评论 / 打标签 / 关闭**：`gh pr comment`、`gh pr edit --add-label`/`--remove-label`、`gh pr close`。

GitHub 在 issue 和 PR 之间共享一个编号空间，所以一个光秃秃的 `#42` 可能是其中任一个——用 `gh pr view 42` 解析，并回退到 `gh issue view 42`。

## 当某个技能说「发布到问题追踪器」时

创建一个 GitHub issue。

## 当某个技能说「获取相关工单」时

运行 `gh issue view <number> --comments`。

## 寻路（Wayfinding）操作

由 `/wayfinder` 使用。**地图（map）**是一个单独的 issue，以**子（child）** issue 作为工单。

- **地图**：一个标注了 `wayfinder:map` 的单独 issue，承载 Notes / Decisions-so-far / Fog 正文。`gh issue create --label wayfinder:map`。
- **子工单**：一个作为 GitHub 子 issue 链接到地图的 issue（在 sub-issues 端点上用 `gh api`）。在未启用子 issue 的地方，把子项加进地图正文里的任务列表，并在子项正文顶部放上 `Part of #<map>`。标签：`wayfinder:<type>`（`research`/`prototype`/`grilling`/`task`），一旦被认领再加上 `wayfinder:claimed`。
- **阻塞**：在可用之处用原生 issue 关系；否则在子项正文顶部放一行 `Blocked by: #<n>, #<n>`。当一个工单所列的每个 issue 都已关闭时，它就解除阻塞。
- **前沿查询（Frontier query）**：列出地图的开放子项（`gh issue list --state open`，范围限定到地图的子 issue / 任务列表），去掉任何带开放 `Blocked by` issue 或 `wayfinder:claimed` 标签的；按地图顺序排在最前的胜出。
- **认领（Claim）**：`gh issue edit <n> --add-label wayfinder:claimed`——会话的第一次写入。
- **解决（Resolve）**：`gh issue comment <n> --body "<answer>"`，然后 `gh issue close <n>`，然后把一个上下文指针（gist + 链接）追加到地图的 Decisions-so-far。
