# Matt Pocock 技能

一套由 Claude Code 加载的代理技能（斜杠命令与行为）。技能被组织到各个桶中，并由 `/setup-matt-pocock-skills` 生成的按仓库配置来消费。

## 语言

**问题跟踪器（Issue tracker）**：
托管一个仓库问题的工具——GitHub Issues、Linear、本地 `.scratch/` markdown 约定，或类似的东西。像 `to-tickets`、`to-spec`、`triage` 和 `qa` 这样的技能从中读取并向其写入。
_避免_：backlog manager、backlog backend、issue host

**问题（Issue）**：
一个**问题跟踪器**内部的单个被跟踪工作单元——一个 bug、任务、规范，或由 `to-tickets` 产出的切片。
_避免_：ticket（仅在引用把它们称作 ticket 的外部系统时，或指**决策工单（Decision ticket）**时使用——见下文）

**决策工单（Decision ticket）**：
一个 `wayfinder` 单元——一个 `wayfinder:map` 的子**问题（Issue）**，持有一个*问题*，其解答是一个决策，而非一个待执行的构建切片。**决策**这个限定词正是让它区别于实现工单的关键；`wayfinder` 先引入该术语，随后就使用"工单（ticket）"。

**分诊角色（Triage role）**：
在分诊期间应用到某个**问题（Issue）**上的一个规范状态机标签（例如 `needs-triage`、`ready-for-afk`）。每个角色通过 `docs/agents/triage-labels.md` 映射到**问题跟踪器**中的一个真实标签字符串。

## 关系

- 一个**问题跟踪器**持有许多**问题**
- 一个**问题**在同一时间携带一个**分诊角色**
- 一个**决策工单**是一个**问题**（一个 `wayfinder:map` 的子项）

## 已标记的歧义

- "backlog" 之前被同时用来指*托管问题的工具*和其中的*工作主体*——已解决：工具是**问题跟踪器**；"backlog" 不再用作领域术语。
- "backlog backend"／"backlog manager"——已解决：合并进**问题跟踪器**。
