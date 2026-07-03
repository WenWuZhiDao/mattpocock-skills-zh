# 问题追踪器：GitLab

这个仓库的 issue 和 PRD 以 GitLab issue 的形式存放。所有操作都使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI。

## 约定

- **创建 issue**：`glab issue create --title "..." --description "..."`。多行描述使用 heredoc。传入 `--description -` 可打开编辑器。
- **阅读 issue**：`glab issue view <number> --comments`。使用 `-F json` 获取机器可读输出。
- **列出 issue**：`glab issue list -F json`，配合适当的 `--label` 过滤。
- **对 issue 评论**：`glab issue note <number> --message "..."`。GitLab 把评论称为「note」。
- **打上 / 移除标签**：`glab issue update <number> --label "..."` / `--unlabel "..."`。多个标签可以用逗号分隔，或重复该标志。
- **关闭**：`glab issue close <number>`。`glab issue close` 不接受关闭评论，所以先用 `glab issue note <number> --message "..."` 发布解释，然后再关闭。
- **合并请求（Merge requests）**：GitLab 把 PR 称为「merge request」。使用 `glab mr create`、`glab mr view`、`glab mr note` 等——形态与 `gh pr ...` 相同，只是用 `mr` 代替 `pr`、用 `note`/`--message` 代替 `comment`/`--body`。

从 `git remote -v` 推断仓库——`glab` 在克隆内部运行时会自动这样做。

## 把合并请求作为分诊入口

**MR 作为请求入口：否。** _（如果这个仓库把外部合并请求当作功能请求，就设为 `yes`；`/triage` 会读取这个标志。）_

当设为 `yes` 时，MR 会经过与 issue 相同的标签和状态，使用 `glab mr` 的对应命令：

- **阅读 MR**：`glab mr view <number> --comments`，以及用 `glab mr diff <number>` 看 diff。
- **列出待分诊的外部 MR**：`glab mr list -F json`，然后只保留作者不是项目成员/所有者的 MR（贡献者的 MR，而非维护者进行中的工作）。
- **评论 / 打标签 / 关闭**：`glab mr note`、`glab mr update --label`/`--unlabel`、`glab mr close`。

与 GitHub 不同，GitLab 对 issue 和 MR 分别编号，所以一旦你知道维护者指的是哪个入口，`#42` 就是无歧义的。

## 当某个技能说「发布到问题追踪器」时

创建一个 GitLab issue。

## 当某个技能说「获取相关工单」时

运行 `glab issue view <number> --comments`。

## 寻路（Wayfinding）操作

由 `/wayfinder` 使用。**地图（map）**是一个单独的 issue，以**子（child）** issue 作为工单。

- **地图**：一个标注了 `wayfinder:map` 的单独 issue，承载 Notes / Decisions-so-far / Fog 正文。`glab issue create --label wayfinder:map`。（在具备原生 epic 的 GitLab 套餐上，可以改用一个 epic 来承载地图；一个带标签的 issue 到处都行得通。）
- **子工单**：一个在其描述顶部带有 `Part of #<map>`、并带标签 `wayfinder:<type>`（`research`/`prototype`/`grilling`/`task`）的 issue，一旦被认领再加上 `wayfinder:claimed`。
- **阻塞**：GitLab 原生的 `/blocked_by #<n>` 快捷动作（或作为回退，在描述里写一行 `Blocked by: #<n>, #<n>`）。当一个工单所列的每个 issue 都已关闭时，它就解除阻塞。
- **前沿查询（Frontier query）**：`glab issue list -F json`，范围限定到地图的子项，去掉任何带开放阻塞项或 `wayfinder:claimed` 标签的；按地图顺序排在最前的胜出。
- **认领（Claim）**：`glab issue update <n> --label wayfinder:claimed`——会话的第一次写入。
- **解决（Resolve）**：`glab issue note <n> --message "<answer>"`，然后 `glab issue close <n>`，然后把一个上下文指针（gist + 链接）追加到地图的 Decisions-so-far。
