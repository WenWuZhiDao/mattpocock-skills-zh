# Issue tracker: Local Markdown

本仓库的 issue 和规格说明（你可能把规格说明称为 PRD）以 `.scratch/` 中的 markdown 文件形式存放。

## 约定

- 每个功能一个目录：`.scratch/<feature-slug>/`
- 规格说明是 `.scratch/<feature-slug>/spec.md`
- 实现 issue 为每张工单一个文件，位于 `.scratch/<feature-slug>/issues/<NN>-<slug>.md`，从 `01` 开始编号——绝不是单个合并的工单文件
- 分诊状态记录为每个 issue 文件顶部附近的一行 `Status:`（角色字符串见 `triage-labels.md`）
- 评论和对话历史追加到文件底部的 `## Comments` 标题之下

## 当某个技能说"发布到 issue 跟踪器"时

在 `.scratch/<feature-slug>/` 下创建一个新文件（如有需要则创建该目录）。

## 当某个技能说"获取相关工单"时

读取所引用路径处的文件。用户通常会直接传路径或 issue 编号。

## 寻路操作

由 `/wayfinder` 使用。**地图**是一个文件，每张工单一个**子**文件。

- **地图**：`.scratch/<effort>/map.md`——Notes / Decisions-so-far / Fog 正文。
- **子工单**：`.scratch/<effort>/issues/NN-<slug>.md`，从 `01` 开始编号，问题在正文里。一行 `Type:` 记录工单类型（`research`/`prototype`/`grilling`/`task`）；一行 `Status:` 记录 `claimed`/`resolved`。
- **阻塞**：顶部附近的一行 `Blocked by: NN, NN`。当它所列的每个文件都是 `resolved` 时，工单即解除阻塞。
- **前沿**：扫描 `.scratch/<effort>/issues/` 寻找未关闭、未阻塞且未认领的文件；编号最靠前的胜出。
- **认领**：在任何工作之前设置 `Status: claimed` 并保存。
- **解决**：把答案追加到 `## Answer` 标题之下，设置 `Status: resolved`，然后把一个上下文指针（gist + 链接）追加到 `map.md` 中地图的 Decisions-so-far。
