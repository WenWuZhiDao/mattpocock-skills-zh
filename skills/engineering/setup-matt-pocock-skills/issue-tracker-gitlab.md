# Issue tracker：GitLab

本仓库的 issue 和 PRD 以 GitLab issue 的形式存放。所有操作均使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI。

## 约定

- **创建 issue**：`glab issue create --title "..." --description "..."`。多行描述请使用 heredoc。传入 `--description -` 可打开编辑器。
- **读取 issue**：`glab issue view <number> --comments`。用 `-F json` 获取机器可读的输出。
- **列出 issue**：`glab issue list -F json`，并配以适当的 `--label` 过滤。
- **在 issue 上评论**：`glab issue note <number> --message "..."`。GitLab 把评论称为 “notes”。
- **添加 / 移除标签**：`glab issue update <number> --label "..."` / `--unlabel "..."`。多个标签可以用逗号分隔或重复该标志。
- **关闭**：`glab issue close <number>`。`glab issue close` 不接受关闭评论，所以先用 `glab issue note <number> --message "..."` 发表说明，再关闭。
- **Merge requests（合并请求）**：GitLab 把 PR 称为“合并请求”。使用 `glab mr create`、`glab mr view`、`glab mr note` 等 —— 与 `gh pr ...` 形式相同，只是把 `pr` 换成 `mr`，把 `comment`/`--body` 换成 `note`/`--message`。

从 `git remote -v` 推断仓库 —— 在 clone 内部运行时 `glab` 会自动完成。

## 当技能说“发布到问题追踪器”时

创建一个 GitLab issue。

## 当技能说“获取相关 ticket”时

运行 `glab issue view <number> --comments`。
