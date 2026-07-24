---
"mattpocock-skills": patch
---

让 `/setup-matt-pocock-skills` 更友好，并让本地 markdown 跟踪器与当前规范对齐。

- **分诊标签**现在只在安装了 `triage` 技能时才会被询问，且改为一个推荐选"是"的单一问题（"保留默认的分诊标签吗？"），而不是一场覆盖式的盘问。当未安装 `triage` 时，这一节——以及 `docs/agents/triage-labels.md`——都会被跳过。
- **把外部 PR 作为一种请求来源**不再是一个 setup 问题。GitHub/GitLab 模板仍带有该开关，默认关闭；用户之后可以在 `docs/agents/issue-tracker.md` 中打开它。
- **领域文档**默认不询问即采用单上下文；只有当仓库显示出 monorepo 迹象时才提供多上下文选项。
- **本地 markdown 工单**现在是每个工单一个文件，位于 `.scratch/<feature>/issues/<NN>-<slug>.md` 下——绝不再是单一的合并文件 `tickets.md`。`/to-tickets` 与本地问题跟踪器模板现在一致，并且规范文件是 `spec.md`（而非 `PRD.md`）以匹配 `/to-spec`。

`setup-matt-pocock-skills` 和 `to-tickets` 的文档页已重新同步。
