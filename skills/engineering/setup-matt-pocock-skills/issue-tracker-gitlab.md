# 工单跟踪器：GitLab

本仓库的工单和规格以 GitLab issue 的形式存在。所有操作都使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI。

## 约定

- **创建一个 issue**：`glab issue create --title "..." --description "..."`。多行描述用 heredoc。传 `--description -` 来打开编辑器。
- **读一个 issue**：`glab issue view <number> --comments`。用 `-F json` 获取机器可读的输出。
- **列出 issue**：`glab issue list -F json`，配合适当的 `--label` 过滤器。
- **对一个 issue 评论**：`glab issue note <number> --message "..."`。GitLab 把评论叫作「note」。
- **应用 / 移除标签**：`glab issue update <number> --label "..."` / `--unlabel "..."`。多个标签可以用逗号分隔，或重复该标志。
- **关闭**：`glab issue close <number>`。`glab issue close` 不接受关闭评论，所以先用 `glab issue note <number> --message "..."` 发出解释，再关闭。
- **合并请求**：GitLab 把 PR 叫作「merge request」。用 `glab mr create`、`glab mr view`、`glab mr note` 等——和 `gh pr ...` 同样的形状，只是把 `pr` 换成 `mr`、把 `comment`/`--body` 换成 `note`/`--message`。

从 `git remote -v` 推断仓库——在一个克隆里运行时 `glab` 会自动这么做。

## 合并请求作为分诊入口

**MR 作为请求入口：否。** _（如果这个仓库把外部 merge request 当作功能请求，就设为 `yes`；`/triage` 读取这个标志。）_

当设为 `yes` 时，MR 走和 issue 一样的标签和状态，使用 `glab mr` 的对应命令：

- **读一个 MR**：`glab mr view <number> --comments`，diff 用 `glab mr diff <number>`。
- **列出待分诊的外部 MR**：`glab mr list -F json`，然后只保留作者不是项目成员/所有者的 MR（一个贡献者的 MR，而不是维护者进行中的工作）。
- **评论 / 打标签 / 关闭**：`glab mr note`、`glab mr update --label`/`--unlabel`、`glab mr close`。

与 GitHub 不同，GitLab 对 issue 和 MR 分别编号，所以一旦你知道维护者指的是哪个入口，`#42` 就是无歧义的。

## 当技能说「发布到工单跟踪器」时

创建一个 GitLab issue。

## 当技能说「获取相关工单」时

运行 `glab issue view <number> --comments`。

## 寻路操作

由 `/wayfinder` 使用。**地图**是一个单一 issue，以**子** issue 作为工单。

- **地图**：一个打了 `wayfinder:map` 标签的单一 issue，持有 Notes / Decisions-so-far / Fog 正文。`glab issue create --label wayfinder:map`。（在带原生 epic 的 GitLab 层级上，可以用一个 epic 来持有地图；一个打了标签的 issue 到处都能用。）
- **子工单**：一个在其描述顶部携带 `Part of #<map>` 并带 `wayfinder:<type>` 标签（`research`/`prototype`/`grilling`/`task`）的 issue。一旦被领取，工单就分配给推进的开发者。
- **阻塞**：GitLab 的**原生阻塞链接**——规范的、UI 可见的表示。用 `/blocked_by #<n>` 快捷动作添加它，作为一条 note 发出（`glab issue note <child> --message "/blocked_by #<blocker>"`）。原生阻塞链接是 Premium/Ultimate 功能；在免费层（或不可用之处）回退到描述顶部的一行 `Blocked by: #<n>, #<n>`。当每个阻塞项都被关闭时，工单即解除阻塞。
- **前沿查询**：`glab issue list -F json` 限定到地图的子工单，丢掉任何有未关闭阻塞项——一条指向未关闭 issue 的原生 `blocked_by` 链接（`glab api projects/:id/issues/:iid/links`），或 `Blocked by` 行里有一个未关闭 issue——或有 assignee 的；地图顺序里排第一的胜出。
- **领取**：`glab issue update <n> --assignee @me`——会话的第一次写入。
- **解决**：`glab issue note <n> --message "<answer>"`，然后 `glab issue close <n>`，然后向地图的 Decisions-so-far 追加一个上下文指针（gist + 链接）。
