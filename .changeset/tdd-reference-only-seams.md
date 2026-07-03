---
"mattpocock-skills": patch
---

把 `tdd` 技能重塑为仅参考（reference-only）。红 → 绿 → 重构回路由模型已经掌握的领头词锚定，因此逐步的 Workflow 大多只是在重述回路并重复水平切片这一反模式。删除了 Workflow 和每轮循环的清单；把它们唯一持久的理念——垂直切片 / 曳光弹——折入 Anti-patterns 小节和一份简短的 Rules-of-the-loop 列表。引入 **seam（接缝）**作为测试所在位置的领头词，把旧 Philosophy 中的"public interfaces"散文以及 Planning 中"confirm interface / behaviors"的握手合并为一条规则：只在事先商定的接缝处测试，且在写任何测试之前与用户确认。

同时删除了重构阶段——TDD 现在是红 → 绿，而非红 → 绿 → 重构。重构属于审查阶段，而非实现回路，因此重构规则和 `refactoring.md` 被移除（它的归属是 `review` 技能）。
