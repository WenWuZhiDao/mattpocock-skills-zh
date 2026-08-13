# Matt Pocock 技能集

一组由 Claude Code 加载的智能体技能（斜杠命令与行为）。技能按桶组织，并由 `/setup-matt-pocock-skills` 生成的每仓库配置来消费。

## 语言

**问题追踪器（Issue tracker）**：
托管某个仓库问题的工具 —— GitHub Issues、Linear、本地 `.scratch/` markdown 约定，或类似方案。像 `to-tickets`、`to-spec` 和 `triage` 这样的技能会读取并写入它。
_避免使用_：backlog manager、backlog backend、issue host

**问题（Issue）**：
**问题追踪器**内部的一个受追踪的工作单元 —— 由 `to-tickets` 产出的一个 bug、任务、规格（spec）或切片（slice）。
_避免使用_：ticket（仅在引用那些将其称为 ticket 的外部系统时使用，或用于**决策票（Decision ticket）** —— 见下文）

**决策票（Decision ticket）**：
一个 `wayfinder` 单元 —— `wayfinder:map` 的一个子**问题**，持有一个*问题（question）*，其解答是一项决策，而非要执行的一段构建切片。**决策（decision）**这一限定词正是使它区别于实现票的关键；`wayfinder` 引入该术语，随后使用 "ticket"。

**分诊角色（Triage role）**：
分诊期间应用于某个**问题**的规范状态机标签（例如 `needs-triage`、`ready-for-afk`）。每个角色通过 `docs/agents/triage-labels.md` 映射到**问题追踪器**中一个真实的标签字符串。

## 关系

- 一个**问题追踪器**持有多个**问题**
- 一个**问题**在某一时刻携带一个**分诊角色**
- 一个**决策票**是一个**问题**（`wayfinder:map` 的一个子项）

## 已标记的歧义

- "backlog" 此前被同时用来指代托管问题的*工具*以及其内部的*工作主体* —— 已解决：工具是**问题追踪器**；"backlog" 不再作为领域术语使用。
- "backlog backend" / "backlog manager" —— 已解决：并入**问题追踪器**。
