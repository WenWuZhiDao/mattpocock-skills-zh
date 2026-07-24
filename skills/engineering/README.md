# 工程（Engineering）

我在日常代码工作中使用的技能。

## 用户调用型

只有在你手动输入时才可触达（Claude Code：`disable-model-invocation: true`；Codex：在 `agents/openai.yaml` 中设置 `policy.allow_implicit_invocation: false`）。

- **[ask-matt](./ask-matt/SKILL.md)** — 询问哪个技能或流程适合你当前的处境。它是本仓库中用户手动调用技能的路由器。
- **[grill-with-docs](./grill-with-docs/SKILL.md)** — 一场拷问式会话，同时构建你项目的领域模型，打磨术语，并就地更新 `CONTEXT.md` 和 ADR。
- **[triage](./triage/SKILL.md)** — 让 issue 在一套分诊角色状态机中流转。
- **[improve-codebase-architecture](./improve-codebase-architecture/SKILL.md)** — 扫描代码库寻找可深化的机会，以可视化 HTML 报告呈现，然后针对你选定的那个进行拷问。
- **[setup-matt-pocock-skills](./setup-matt-pocock-skills/SKILL.md)** — 为工程技能配置本仓库（issue 跟踪器、分诊标签、领域文档布局）。每个仓库运行一次。
- **[to-spec](./to-spec/SKILL.md)** — 把当前对话转化为一份规格说明，并发布到 issue 跟踪器。
- **[to-tickets](./to-tickets/SKILL.md)** — 把任何计划、规格说明或对话拆分成一组曳光弹式（tracer-bullet）工单，每张工单声明它的阻塞边——在本地文件中以文字形式，或在真实跟踪器上以原生阻塞链接形式。
- **[implement](./implement/SKILL.md)** — 构建规格说明或一组工单所描述的工作，在事先约定的接缝处驱动 `/tdd`，并在提交前以 `/code-review` 收尾。
- **[wayfinder](./wayfinder/SKILL.md)** — 把一大块工作——超过单个 agent 会话所能容纳的量——规划成 issue 跟踪器上一张共享的决策工单地图，逐个解决，直到通往目的地的道路清晰可见。

## 模型调用型

模型或用户均可触达（触发措辞丰富，以便模型能够主动选用它们）。

- **[prototype](./prototype/SKILL.md)** — 构建一个用完即弃的原型来回答某个设计问题：一个可运行的终端应用来验证状态/逻辑，或者若干可切换的 UI 变体。

- **[diagnosing-bugs](./diagnosing-bugs/SKILL.md)** — 针对疑难 bug 和性能回归的严谨诊断循环：复现 → 最小化 → 假设 → 埋点 → 修复 → 回归测试。
- **[research](./research/SKILL.md)** — 针对高可信度的一手来源调查某个问题，并把发现记录为仓库中一份带引用的 Markdown 文件，以后台 agent 运行。
- **[tdd](./tdd/SKILL.md)** — 以红-绿-重构循环进行测试驱动开发。一次一个垂直切片地构建功能或修复 bug。
- **[domain-modeling](./domain-modeling/SKILL.md)** — 主动构建并打磨项目的领域模型——挑战术语，用场景做压力测试，就地更新 `CONTEXT.md` 和 ADR。
- **[codebase-design](./codebase-design/SKILL.md)** — 用于设计深模块的共享准则与词汇：小接口、干净的接缝、可通过接口进行测试。
- **[code-review](./code-review/SKILL.md)** — 对某个固定基点以来的 diff 进行双轴评审：**标准**（是否遵循仓库的编码规范，以及 Fowler 坏味道基线？）和**规格**（是否忠实实现了源头的 issue/PRD？），以并行子 agent 运行。
- **[resolving-merge-conflicts](./resolving-merge-conflicts/SKILL.md)** — 逐个冲突块地处理正在进行的 git merge 或 rebase 冲突，按追溯到每一方一手来源的意图来解决，然后完成该操作——绝不 `--abort`。
