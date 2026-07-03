# 仅对硬依赖显式指向 `/setup-matt-pocock-skills`

工程技能依赖于按仓库配置的信息（issue 追踪器、分诊标签词汇、领域文档布局），这些由 `/setup-matt-pocock-skills` 播种。有些技能没有该配置就无法有意义地运作——它们必须发布到特定的 issue 追踪器或应用特定的标签字符串。另一些技能只用它来打磨输出（词汇、ADR 意识），没有它也能优雅降级。

我们把这些技能分成**硬依赖**和**软依赖**：

- **硬依赖**（`to-issues`、`to-prd`、`triage`）—— 包含一条显式的说明：_"…… should have been provided to you — run `/setup-matt-pocock-skills` if not."_ 没有该映射，输出就是错的，而不仅仅是模糊。
- **软依赖**（`diagnose`、`tdd`、`improve-codebase-architecture`）—— 仅以含糊的散文引用"项目的领域术语表"和"你正在触及区域中的 ADR"。若这些文档不存在，技能仍然可用；只是输出没那么锐利。

这一划分让软依赖技能保持 token 轻量，并避免把这条设置指引照搬（cargo-cult）到它并不承重的地方。
