# 问题追踪器：本地 Markdown

这个仓库的 issue 和 PRD 以 markdown 文件的形式存放在 `.scratch/` 中。

## 约定

- 每个功能一个目录：`.scratch/<feature-slug>/`
- PRD 是 `.scratch/<feature-slug>/PRD.md`
- 实现 issue 是 `.scratch/<feature-slug>/issues/<NN>-<slug>.md`，从 `01` 开始编号
- 分诊状态记录为每个 issue 文件顶部附近的一行 `Status:`（角色字符串见 `triage-labels.md`）
- 评论和对话历史追加到文件底部、`## Comments` 标题下

## 当某个技能说「发布到问题追踪器」时

在 `.scratch/<feature-slug>/` 下创建一个新文件（如有需要则创建该目录）。

## 当某个技能说「获取相关工单」时

阅读所引用路径处的文件。用户通常会直接传入路径或 issue 编号。

## 寻路（Wayfinding）操作

由 `/wayfinder` 使用。**地图（map）**是一个文件，每个工单对应一个**子（child）**文件。

- **地图**：`.scratch/<effort>/map.md`——Notes / Decisions-so-far / Fog 正文。
- **子工单**：`.scratch/<effort>/issues/NN-<slug>.md`，从 `01` 开始编号，正文中带有问题。一行 `Type:` 记录工单类型（`research`/`prototype`/`grilling`/`task`）；一行 `Status:` 记录 `claimed`/`resolved`。
- **阻塞**：顶部附近一行 `Blocked by: NN, NN`。当一个工单所列的每个文件都为 `resolved` 时，它就解除阻塞。
- **前沿（Frontier）**：扫描 `.scratch/<effort>/issues/`，找出开放、未阻塞且未认领的文件；按编号排在最前的胜出。
- **认领（Claim）**：在任何工作之前设 `Status: claimed` 并保存。
- **解决（Resolve）**：把答案追加到 `## Answer` 标题下，设 `Status: resolved`，然后把一个上下文指针（gist + 链接）追加到 `map.md` 里地图的 Decisions-so-far。
