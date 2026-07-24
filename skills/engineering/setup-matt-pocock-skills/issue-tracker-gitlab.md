# Issue tracker: GitLab

本仓库的 issue 和 PRD 以 GitLab issue 的形式存放。所有操作都使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI。

## 约定

- **创建 issue**：`glab issue create --title "..." --description "..."`。多行描述使用 heredoc。传 `--description -` 可打开编辑器。
- **读取 issue**：`glab issue view <number> --comments`。用 `-F json` 获得机器可读的输出。
- **列出 issue**：`glab issue list -F json`，配合适当的 `--label` 过滤。
- **在 issue 上评论**：`glab issue note <number> --message "..."`。GitLab 把评论称为"notes"。
- **添加 / 移除标签**：`glab issue update <number> --label "..."` / `--unlabel "..."`。多个标签可用逗号分隔，或重复该标志。
- **关闭**：`glab issue close <number>`。`glab issue close` 不接受关闭评论，所以先用 `glab issue note <number> --message "..."` 发布说明，然后关闭。
- **合并请求（Merge requests）**：GitLab 把 PR 称为"merge requests"。使用 `glab mr create`、`glab mr view`、`glab mr note` 等——形态与 `gh pr ...` 相同，只是用 `mr` 代替 `pr`，用 `note`/`--message` 代替 `comment`/`--body`。

从 `git remote -v` 推断仓库——在克隆内运行时 `glab` 会自动这么做。

## 把 Merge request 作为分诊入口

**MR 作为请求入口：否。** _（如果本仓库把外部 merge request 当作功能请求，设为 `yes`；`/triage` 会读取这个标志。）_

设为 `yes` 时，MR 会走与 issue 相同的标签和状态，使用 `glab mr` 的等价命令：

- **读取 MR**：`glab mr view <number> --comments`，diff 用 `glab mr diff <number>`。
- **列出待分诊的外部 MR**：`glab mr list -F json`，然后只保留作者不是项目成员/所有者的 MR（贡献者的 MR，而非维护者进行中的工作）。
- **评论 / 标签 / 关闭**：`glab mr note`、`glab mr update --label`/`--unlabel`、`glab mr close`。

与 GitHub 不同，GitLab 对 issue 和 MR 分别编号，所以一旦你知道维护者指的是哪个入口，`#42` 就毫不含糊。

## 当某个技能说"发布到 issue 跟踪器"时

创建一个 GitLab issue。

## 当某个技能说"获取相关工单"时

运行 `glab issue view <number> --comments`。

## 寻路操作

由 `/wayfinder` 使用。**地图**是单个 issue，以**子** issue 作为工单。

- **地图**：单个标注了 `wayfinder:map` 的 issue，承载 Notes / Decisions-so-far / Fog 正文。`glab issue create --label wayfinder:map`。（在拥有原生 epic 的 GitLab 层级上，可以改由一个 epic 承载地图；一个带标签的 issue 到处都能用。）
- **子工单**：一个在其描述顶部带有 `Part of #<map>`、并带标签 `wayfinder:<type>`（`research`/`prototype`/`grilling`/`task`）的 issue。一旦认领，工单就被指派给正在驱动的开发者。
- **阻塞**：GitLab 的**原生阻塞链接**——标准的、UI 可见的表示。用 `/blocked_by #<n>` 快捷操作添加它，以 note 形式发布（`glab issue note <child> --message "/blocked_by #<blocker>"`）。原生阻塞链接是 Premium/Ultimate 功能；在免费层（或不可用的地方）回退到描述顶部的一行 `Blocked by: #<n>, #<n>`。当每个阻塞项都关闭时，工单即解除阻塞。
- **前沿查询**：`glab issue list -F json` 限定到地图的子项，去掉任何有未关闭阻塞项（一条指向未关闭 issue 的原生 `blocked_by` 链接（`glab api projects/:id/issues/:iid/links`），或 `Blocked by` 行中有未关闭 issue）或有指派人的；地图顺序中的第一个胜出。
- **认领**：`glab issue update <n> --assignee @me`——会话的第一次写入。
- **解决**：`glab issue note <n> --message "<answer>"`，然后 `glab issue close <n>`，再把一个上下文指针（gist + 链接）追加到地图的 Decisions-so-far。
