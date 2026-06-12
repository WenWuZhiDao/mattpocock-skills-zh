# Issue tracker：GitHub

本仓库的 issue 和 PRD 以 GitHub issue 的形式存放。所有操作均使用 `gh` CLI。

## 约定

- **创建 issue**：`gh issue create --title "..." --body "..."`。多行正文请使用 heredoc。
- **读取 issue**：`gh issue view <number> --comments`，用 `jq` 过滤评论，同时获取标签。
- **列出 issue**：`gh issue list --state open --json number,title,body,labels,comments --jq '[.[] | {number, title, body, labels: [.labels[].name], comments: [.comments[].body]}]'`，并配以适当的 `--label` 和 `--state` 过滤。
- **在 issue 上评论**：`gh issue comment <number> --body "..."`
- **添加 / 移除标签**：`gh issue edit <number> --add-label "..."` / `--remove-label "..."`
- **关闭**：`gh issue close <number> --comment "..."`

从 `git remote -v` 推断仓库 —— 在 clone 内部运行时 `gh` 会自动完成。

## 当技能说“发布到问题追踪器”时

创建一个 GitHub issue。

## 当技能说“获取相关 ticket”时

运行 `gh issue view <number> --comments`。
