# 工程

我日常代码工作中使用的技能。

## User-invoked

只有在你手动输入时才可触达（`disable-model-invocation: true`）。

- **[ask-matt](./ask-matt/SKILL.md)** — 询问哪个技能或流程适合你的情况。它是本仓库中 user-invoked 技能的路由器。
- **[grill-with-docs](./grill-with-docs/SKILL.md)** — 拷问式会话，同时构建你项目的领域模型，打磨术语，并就地更新 `CONTEXT.md` 和 ADR。
- **[triage](./triage/SKILL.md)** — 让 issue（问题）在分诊角色的状态机中流转。
- **[improve-codebase-architecture](./improve-codebase-architecture/SKILL.md)** — 扫描代码库以寻找深化机会，将其呈现为可视化的 HTML 报告，然后对你选中的那个进行拷问。
- **[setup-matt-pocock-skills](./setup-matt-pocock-skills/SKILL.md)** — 为工程技能配置本仓库（问题追踪器、分诊标签、领域文档布局）。每个仓库运行一次。
- **[to-issues](./to-issues/SKILL.md)** — 使用垂直切片，将任何计划、规格或 PRD 拆分为可独立领取的 issue。
- **[to-prd](./to-prd/SKILL.md)** — 把当前对话变成一份 PRD，并发布到问题追踪器。

## Model-invoked

模型或用户均可触达（丰富的触发措辞，以便模型能够调用它们）。

- **[prototype](./prototype/SKILL.md)** — 构建一个用后即弃的原型来回答某个设计问题：一个用于状态/逻辑的可运行终端应用，或几个可切换的 UI 变体。

- **[diagnosing-bugs](./diagnosing-bugs/SKILL.md)** — 针对疑难 bug 和性能回归的严谨诊断回路：复现 → 最小化 → 提出假设 → 插桩 → 修复 → 回归测试。
- **[tdd](./tdd/SKILL.md)** — 采用红-绿-重构回路的测试驱动开发。一次一个垂直切片地构建功能或修复 bug。
- **[domain-modeling](./domain-modeling/SKILL.md)** — 主动构建并打磨项目的领域模型——挑战术语、用场景做压力测试、就地更新 `CONTEXT.md` 和 ADR。
- **[codebase-design](./codebase-design/SKILL.md)** — 用于设计深模块的共享准则与词汇：小接口、干净的接缝、可通过接口测试。
- **[code-review](./code-review/SKILL.md)** — 对某个固定点以来的 diff 进行双轴审查：**Standards**（是否遵循仓库的编码规范，外加 Fowler 坏味道基线？）和 **Spec**（是否忠实实现了源起的 issue/PRD？），以并行子智能体运行。
