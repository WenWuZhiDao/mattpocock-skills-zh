# 工程（Engineering）

我在代码工作中每天都会用到的技能。

## 用户调用型

只有在你手动输入时才可触达（Claude Code：`disable-model-invocation: true`；Codex：在 `agents/openai.yaml` 中 `policy.allow_implicit_invocation: false`）。

- **[ask-matt](./ask-matt/SKILL.md)** — 询问哪个技能或流程适合你当前的情况。它是本仓库中用户调用型技能的路由器。
- **[grill-with-docs](./grill-with-docs/SKILL.md)** — 拷问式对话，同时构建项目的领域模型，打磨术语，并就地更新 `CONTEXT.md` 和 ADR。
- **[triage](./triage/SKILL.md)** — 让工单在一套分诊角色的状态机中流转。
- **[improve-codebase-architecture](./improve-codebase-architecture/SKILL.md)** — 扫描代码库寻找深化机会，以可视化 HTML 报告呈现，然后就你挑选的那个进行拷问。
- **[setup-matt-pocock-skills](./setup-matt-pocock-skills/SKILL.md)** — 为这些工程技能配置本仓库（工单跟踪器、分诊标签、领域文档布局）。每个仓库运行一次。
- **[to-spec](./to-spec/SKILL.md)** — 把当前对话转化为一份规格说明，并发布到工单跟踪器。
- **[to-tickets](./to-tickets/SKILL.md)** — 把任意计划、规格或对话拆解成一组曳光弹式工单，每个都声明其阻塞边——在本地文件中是文本，在真实跟踪器上则是原生的阻塞链接。
- **[implement](./implement/SKILL.md)** — 构建规格或工单集所描述的工作，在预先约定的接缝处驱动 `/tdd`，并在提交前以 `/code-review` 收尾。
- **[wayfinder](./wayfinder/SKILL.md)** — 把一大块工作——超出单个 agent 会话所能容纳的量——规划为工单跟踪器上一张由决策工单构成的共享地图，逐个解决，直到通往目的地的路径变得清晰。

## 模型调用型

模型或用户皆可触达（触发措辞丰富，便于模型主动调用）。

- **[prototype](./prototype/SKILL.md)** — 构建一个用完即弃的原型来回答某个设计问题：面向状态/逻辑的单个可分享 HTML 文件，或若干可切换的 UI 变体。

- **[diagnosing-bugs](./diagnosing-bugs/SKILL.md)** — 针对疑难 bug 和性能回归的严谨诊断循环：构建一个能在此 bug 上变红的反馈循环 → 最小化 → 提出假设 → 埋点 → 修复 → 回归测试。
- **[research](./research/SKILL.md)** — 针对高可信度的一手来源调查某个问题，并把发现以带引用的 Markdown 文件形式记录到仓库中，作为后台 agent 运行。
- **[tdd](./tdd/SKILL.md)** — 采用红-绿-重构循环的测试驱动开发。一次一个纵向切片地构建功能或修复 bug。
- **[domain-modeling](./domain-modeling/SKILL.md)** — 主动构建并打磨项目的领域模型——质疑术语、用场景做压力测试、就地更新 `CONTEXT.md` 和 ADR。
- **[codebase-design](./codebase-design/SKILL.md)** — 设计深模块所需的共同准则与词汇：小接口、干净接缝、可通过接口测试。
- **[code-review](./code-review/SKILL.md)** — 对某个固定基点以来的 diff 进行双轴审查：**标准**（是否遵循仓库的编码规范，外加一套 Fowler 坏味道基线？）和 **规格**（是否忠实地实现了源头工单/规格？），作为并行子 agent 运行。
- **[resolving-merge-conflicts](./resolving-merge-conflicts/SKILL.md)** — 逐块处理进行中的 git 合并或变基冲突，依据追溯到各方一手来源的意图来解决，然后完成该操作——绝不 `--abort`。
- **[wizard](./wizard/SKILL.md)** — 生成一个交互式 bash 向导，引导人类完成只有他们才能执行的步骤：配置基础设施、设置凭据或 CI 密钥、操作陌生的第三方仪表盘，或执行一次性迁移或切换。
