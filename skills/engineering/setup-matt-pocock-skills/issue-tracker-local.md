# 工单跟踪器：本地 Markdown

本仓库的工单和规格以 markdown 文件的形式存在于 `.scratch/` 中。

## 约定

- 一个功能一个目录：`.scratch/<feature-slug>/`
- 规格是 `.scratch/<feature-slug>/spec.md`
- 实现工单是每个工单一个文件，位于 `.scratch/<feature-slug>/issues/<NN>-<slug>.md`，从 `01` 开始编号——绝不用一个合并的工单文件
- 分诊状态记录为每个工单文件顶部附近的一行 `Status:`（角色字符串见 `triage-labels.md`）
- 评论和对话历史追加到文件底部的一个 `## Comments` 标题下

## 当技能说「发布到工单跟踪器」时

在 `.scratch/<feature-slug>/` 下创建一个新文件（如需则创建该目录）。

## 当技能说「获取相关工单」时

读取被引用路径处的文件。用户通常会直接传路径或工单编号。

## 寻路操作

由 `/wayfinder` 使用。**地图**是一个文件，每个工单一个**子**文件。

- **地图**：`.scratch/<effort>/map.md`——Notes / Decisions-so-far / Fog 正文。
- **子工单**：`.scratch/<effort>/issues/NN-<slug>.md`，从 `01` 开始编号，正文里是问题。一行 `Type:` 记录工单类型（`research`/`prototype`/`grilling`/`task`）；一行 `Status:` 记录 `claimed`/`resolved`。
- **阻塞**：顶部附近的一行 `Blocked by: NN, NN`。当它列出的每个文件都是 `resolved` 时，工单即解除阻塞。
- **前沿**：扫描 `.scratch/<effort>/issues/` 里未关闭、未阻塞、未领取的文件；编号最小的胜出。
- **领取**：设 `Status: claimed` 并在任何工作之前保存。
- **解决**：把答案追加到一个 `## Answer` 标题下，设 `Status: resolved`，然后向 `map.md` 里地图的 Decisions-so-far 追加一个上下文指针（gist + 链接）。
