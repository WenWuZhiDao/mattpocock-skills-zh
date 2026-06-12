# Matt Pocock Skills

一组由 Claude Code 加载的 agent 技能（斜杠命令和行为）。技能按分组组织，并由 `/setup-matt-pocock-skills` 生成的按仓库配置所使用。

## 语言

**Issue tracker（问题追踪器）**：
托管仓库 issue 的工具 —— GitHub Issues、Linear、本地 `.scratch/` markdown 约定或类似工具。诸如 `to-issues`、`to-prd`、`triage` 和 `qa` 等技能会从中读取并写入。
_避免使用_：backlog manager、backlog backend、issue host

**Issue（问题）**：
**Issue tracker** 中的单个被追踪的工作单元 —— 一个 bug、任务、PRD，或由 `to-issues` 产出的切片。
_避免使用_：ticket（仅在引用将其称为 ticket 的外部系统时使用）

**Triage role（分诊角色）**：
分诊过程中应用于 **Issue** 的规范化状态机标签（例如 `needs-triage`、`ready-for-afk`）。每个角色通过 `docs/agents/triage-labels.md` 映射到 **Issue tracker** 中真实的标签字符串。

## 关系

- 一个 **Issue tracker** 持有多个 **Issue**
- 一个 **Issue** 同一时间携带一个 **Triage role**

## 已标记的歧义

- "backlog" 此前同时用于表示托管 issue 的*工具*以及其中的*工作主体* —— 已解决：工具是 **Issue tracker**；"backlog" 不再用作领域术语。
- "backlog backend" / "backlog manager" —— 已解决：合并为 **Issue tracker**。
