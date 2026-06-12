# Issue tracker：本地 Markdown

本仓库的 issue 和 PRD 以 markdown 文件的形式存放在 `.scratch/` 中。

## 约定

- 每个功能一个目录：`.scratch/<feature-slug>/`
- PRD 是 `.scratch/<feature-slug>/PRD.md`
- 实现类 issue 是 `.scratch/<feature-slug>/issues/<NN>-<slug>.md`，从 `01` 开始编号
- 分诊状态记录在每个 issue 文件顶部附近的一行 `Status:` 中（角色字符串见 `triage-labels.md`）
- 评论和对话历史追加到文件底部的 `## Comments` 标题之下

## 当技能说“发布到问题追踪器”时

在 `.scratch/<feature-slug>/` 下创建一个新文件（如有需要则创建该目录）。

## 当技能说“获取相关 ticket”时

读取所引用路径处的文件。用户通常会直接传入路径或 issue 编号。
