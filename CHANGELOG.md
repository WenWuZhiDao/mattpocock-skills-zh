# mattpocock-skills

## 1.2.3

### Patch Changes

- [#779](https://github.com/mattpocock/skills/pull/779) [`efce423`](https://github.com/mattpocock/skills/commit/efce423018fc6468a3239621f1c1bcaacc723801) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 让 `diagnosing-bugs` 对机密信息做脱敏处理。

  - 在 `SKILL.md` 中新增一个 **Redact（脱敏）** 小节。该技能会让代理展示命令、输出和捕获的产物；这一节把脱敏作为每一项的第一步——写成 `<REDACTED>`、针对环境变量构建循环以便凭据始终留在环境中、并且只引用捕获产物中承载信号的那几行。
  - 阶段 1 的完成判据原本写的是"粘贴调用及其输出"。现在改为要求以脱敏形式展示，并且阶段 1 会向用户索取一份**脱敏后**的捕获产物。
  - 在 `scripts/hitl-loop.template.sh` 中注明 `capture` 会把它的值回显到终端，因此它用于记录观测结果，而登录之类的操作仍保持为 `step`。

- [#781](https://github.com/mattpocock/skills/pull/781) [`14bfbbd`](https://github.com/mattpocock/skills/commit/14bfbbd8654a8d2910299e1a004c19c1979687d8) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 从 `code-review`、`codebase-design` 和 `improve-codebase-architecture` 的子代理派发说明中去掉 Claude Code 特有的工具名和代理类型名，使该步骤在 Codex 及其他运行环境上都可照做。

- [#783](https://github.com/mattpocock/skills/pull/783) [`c0fd1e9`](https://github.com/mattpocock/skills/commit/c0fd1e973e040347d424e09934099f1bd6c2dee0) 感谢 [@mattpocock](https://github.com/mattpocock)！—— wizard：移除时间估算。模板去掉了 `TOTAL_MINUTES` 和剩余时间显示，`stage` 只接受一个名称，进度以阶段数来计。

## 1.2.2

### Patch Changes

- [#766](https://github.com/mattpocock/skills/pull/766) [`4aaccb5`](https://github.com/mattpocock/skills/commit/4aaccb58d40559d7e3c59a029b2290ae5ba538de) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 让 `writing-for-agents` 在 Codex 中重新可被模型调用。

  - 从 `agents/openai.yaml` 中去掉 `policy.allow_implicit_invocation: false`。Codex 曾把该技能从模型可见的技能列表中过滤掉，导致它的描述无法触发它——只有显式提及 `$writing-for-agents` 才管用。
  - 更新过时的 `interface.display_name` 和 `interface.short_description`，它们此前仍写着旧的 `writing-great-skills` 技能名。
  - 在 `README.md` 和 `skills/productivity/README.md` 中把该技能从**用户调用型**列表移到**模型调用型**列表。

## 1.2.0

### Minor Changes

- [#551](https://github.com/mattpocock/skills/pull/551) [`697d4ce`](https://github.com/mattpocock/skills/commit/697d4ce9742da558fd1ba6697c8e9775e2e302dd) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 在每个技能的 Claude Code frontmatter 旁边加入 Codex 元数据，使这套技能在两种运行环境中都能工作，而无需生成副本。

  - 在每个 `SKILL.md` 旁边加入一个带 Codex UI 元数据（`interface.display_name`、`interface.short_description`）的 `agents/openai.yaml`。
  - 给每个用户调用型技能标注 `policy.allow_implicit_invocation: false`——它是 `disable-model-invocation: true` 在 Codex 中的对应物，使 Codex 将其排除在隐式调用之外，而显式的 `$skill` 调用仍然有效。
  - 在 `.agents/invocation.md`、`CLAUDE.md` 以及各推广桶的 README 中记录这套双运行环境的调用模型。
  - 加入 `AGENTS.md` 作为指向 `CLAUDE.md` 的符号链接，使 Codex 读取同一份仓库说明。

- [#593](https://github.com/mattpocock/skills/pull/593) [`0f2bdbd`](https://github.com/mattpocock/skills/commit/0f2bdbdb06220d2df3718b8f0483157c6c8a8600) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 让 **`to-questionnaire`** 从 `in-progress/` 毕业进入 **Productivity** 桶，从而随插件发布。它把一个你无法独自回答的决策，变成一份 Markdown 问卷，交给那个唯一能回答的人——异步填写，或在会议上一起完成。

  它的决定性动作在于：它拷问的是**投递**，而非主题本身：一次普通的拷问会盘问主题，而这恰恰是你在这里无法回答的，因此这场访谈只问问卷要发给谁、你需要拿回什么，然后把每个问题都对准这两者之间的缺口。

  现已接入为一个推广技能——插件条目、顶层与 Productivity README 的**用户调用型**分组、`docs/productivity/to-questionnaire.md` 的文档页，以及 `ask-matt` 中一条独立路由，将它定位为 `/grill-me` 的反面（挖掘别人，而非你自己）。

- [#680](https://github.com/mattpocock/skills/pull/680) [`b3376f8`](https://github.com/mattpocock/skills/commit/b3376f8d39848dd08572ec2667da4739a67c8c04) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 让 **`wizard`** 从 `in-progress/` 毕业进入 **Engineering** 桶，从而随插件发布——并把它改为模型调用型。它会生成一个交互式 bash 脚本，引导人类走完一套手动流程——第三方设置、一次性迁移、A→B 状态迁移——打开每个 URL、说明点哪里、捕获各项值，并把它们写入 `.env` 文件和 GitHub Actions secrets。

  令人愉悦的 UX 已由随附的 `template.sh` 预先解决（带剩余时间的进度、确认关卡、跨平台打开 URL（含 WSL）、隐藏式机密录入、幂等的 `.env` upsert、`gh secret`/`gh variable` 写入并带优雅降级、收尾的跳过摘要）。`STAGES` 标记以上的一切都是一个永不手改的固定库——技能的职责仅是界定流程范围并撰写它的各个**阶段（stages）**。

  归入 Engineering 而非 Productivity：它读取 `.env*`、`docker-compose*`、框架配置以及 `.github/workflows/` 中每一处 `secrets.*`/`vars.*` 引用来界定自身范围，写入 CI secrets，并用 `bash -n` 和 `shellcheck` 校验其输出。

  因为它是模型调用型的，代理一旦遇到只有人类才能执行的步骤，就能主动伸手去用它，而不是把一串编号说明丢进对话里、指望你照做。输入 `/wizard` 的效果与以往完全一致——模型调用只会*增添*代理的触达能力。它的描述被写成决定它何时触发的指针：它产出什么、四个触发分支（配置基础设施、设置凭据或 CI secrets、走一个陌生的第三方仪表盘、一次性迁移或切换），以及一个显式的非触发条件——不要为代理自己能执行的步骤调用它。代理能做的事就该让代理做；wizard 是为那些你不会交给代理的点击、审批和仪表盘往返而设的。在写下任何一行之前对阶段列表的确认，如今在代理于构建途中触发它时，同时充当提案。

  现已接入为一个推广技能——插件条目、顶层与 Engineering README 的**模型调用型**分组、`docs/engineering/wizard.md` 的文档页，以及 `ask-matt` 中一条针对"只有人类能做的步骤"的独立路由。模型调用还让它避开了 [#693](https://github.com/mattpocock/skills/issues/693) 的影响——后者会在 Claude 的桌面端和网页端把用户调用型技能从列表中剔除。

- [#763](https://github.com/mattpocock/skills/pull/763) [`77d207e`](https://github.com/mattpocock/skills/commit/77d207ef03219cc603e2832e1159cbdd1c91818e) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 围绕两个理念重塑 **`prototype`** 技能：演示是**一个可分享的单一 HTML 文件**，而原型是**一手来源**。

  逻辑分支现在产出一个自包含的文件（纯 HTML/CSS/JS，无需构建、无需服务器），而不是一个终端应用——非开发者可以双击打开，并用他们自己的领域语言来驱动它：一个带标签的状态面板、始终可用的自由操作按钮，以及一组分标签页的**引导式演练**，每个演练是一个场景，下方列出要按的有序按钮。那个可移植的纯逻辑模块仍会被提升进真实代码；HTML 外壳才是一次性的部分。

  一次性不再意味着删除。原型在回答完它的问题后，不是被移除，而是作为可运行的证据被捕获在一个一次性分支（`prototype/<name>`）上、脱离 main，并在实现 issue 上留下一个指向它的上下文指针——这样 main 分支只保留经过验证的决策，而探索过程仍可被找到。答案（结论 + 问题）仍会持久地捕获在 issue/ADR/commit 中。

- [#536](https://github.com/mattpocock/skills/pull/536) [`42a5b70`](https://github.com/mattpocock/skills/commit/42a5b70fcacc7baff1977b13f3919fb2f63af14e) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 将这套技能集作为一个原生 **Claude Code 插件**发布，列入 Claude Code 的官方市场。你现在可以把这套推广技能作为一个受管理的只读捆绑包来订阅，而不必复制可编辑的文件：

  ```bash
  claude plugins install mattpocock-skills
  ```

  或者，在会话内部：

  ```
  /plugin install mattpocock-skills
  ```

  无需先添加市场——官方市场默认已配置好。

  `.claude-plugin/plugin.json` 承载完整的插件元数据（版本、描述、作者、许可证、关键词）以及推广技能的明确清单。`skills.sh` 仍是通用安装器（也是当下 Codex 及其他运行环境的路径）；原生 Codex 插件被推迟——原因见 `.agents/adr/0002-ship-as-a-claude-code-plugin.md`。

- [#751](https://github.com/mattpocock/skills/pull/751) [`355fa74`](https://github.com/mattpocock/skills/commit/355fa7420b418af838998f7ec4365ceda1c8dfcc) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 加入 **`wait-what`**——针对模型啰嗦的一词纠偏。在某条消息没能让你听懂的那一刻输入它，代理就会重新表述：一点点背景、ASD-STE100 简化技术英语，以及来自你 `CONTEXT.md` 的通用语言。用户调用型，只有三行长。

  机制就是它的名字。追求简洁的技能往往因膨胀而失败——一个 400 行的技能仍会让模型啰嗦——所以这一个只是一个精准的引导词，别无他物。描述*输出*的名字（`/tldr`、`/no-fluff`）会让模型删词、把你带得更偏；而命名*听者*的状态，则同时索要两半：更少的词**以及**你此前缺失的背景。它还复用了你全局 `CLAUDE.md` 里已有的引导词，因此该技能、`CLAUDE.md` 和每一份 `CONTEXT.md` 都伸手去用同一批词。

  它修复一条消息；它并不能预防下一条。治疗术语泛滥的良方，是用 `/grill-with-docs` 预先构建的一门共享语言；而这一个是你在还没有这门语言时伸手去用的东西。

- [#763](https://github.com/mattpocock/skills/pull/763) [`77d207e`](https://github.com/mattpocock/skills/commit/77d207ef03219cc603e2832e1159cbdd1c91818e) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 把 `/wayfinder` 的单元命名为**决策工单（decision ticket）**，并用子代理把研究工单一一攻克。

  人们总把 wayfinder 的工单读成一个普通的*实现*工单——一块要执行的构建切片——而 wayfinder 把它们当作**决策工单**：其解决方案是一个决策的问题。技能描述及其开篇之句现在引入了这个术语（并说明是什么使它成为决策工单），`ask-matt` / 工程 README 的简介和文档页与之匹配——而"工单"在术语确立之后仍是日常用词。`CONTEXT.md` 把**决策工单**记录为一个领域术语，因此"避免：工单"的指引不再与 wayfinder 对该词的刻意使用相矛盾。

  研究工单不再被搁置以等待另行启动的会话。研究仍是一种真实的工单类型——它是一个下游决策所依赖的真正的共享阻塞，而这种依赖正是前沿的阻塞边所要呈现的。改变的是它的解决方式：因为研究是 AFK 的，绘制地图时不会停下来读它。创建工单之后，绘制会话会为每个研究工单触发一个 `/research` 子代理来并行攻克，把发现捕获在一个一次性的 `research/<name>` 分支上并留下一个上下文指针。研究工单是*一次会话一张工单*的唯一例外。

- [#763](https://github.com/mattpocock/skills/pull/763) [`77d207e`](https://github.com/mattpocock/skills/commit/77d207ef03219cc603e2832e1159cbdd1c91818e) 感谢 [@mattpocock](https://github.com/mattpocock)！—— **破坏性变更：** 把 **`writing-great-skills`** 重命名为 **`writing-for-agents`**、重构它，并加入一个新的引导词。

  这份参考如今覆盖任何被代理消费的文档——技能、`AGENTS.md` / `CLAUDE.md`、通过指针触达的文档——而不只是技能。`GLOSSARY.md` 被并入 `SKILL.md`（每个术语只有一处权威论述；`_Avoid_` 同义词列表和独立的 Predictability 定义已去除）；仅与技能有关的机制（frontmatter、模型调用型 vs 用户调用型、路由器技能、拆分的调用切分）被披露到一个新的 `SKILL-MECHANICS.md`。该技能现在是**模型调用型**：它会在创建或编辑技能，或修改 `AGENTS.md`/`CLAUDE.md` 时触发。`ask-matt` 的指针已更新。请以新名称重新安装；旧名称已不存在（无别名）。

  裁剪那一节新增了 **cache（缓存）**。单一事实来源如今延伸到文档之外、进入环境——`package.json` 脚本、配置文件、目录布局、`--help` 输出本身就是权威的，因此一个复述它们的文档，只是对某次查询的一份缓存，只有在那次查询代价高昂时才配得上它的加载。正面的目标是：缓存那些代理无法通过查看而找到的东西（未成文的约定、某个选择背后的原因、任何配置都不会坦白的坑），而把一个文件、一条命令就能查到的东西留给环境，那里它们不会过期。

- [#533](https://github.com/mattpocock/skills/pull/533) [`45afd80`](https://github.com/mattpocock/skills/commit/45afd8074a8b7de5fe073845d080fa9dd6c429fa) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 给 **`improve-codebase-architecture`** 技能的 Explore 步骤加上一个 YAGNI 范围过滤器。它不再均匀地扫描整个仓库，而是把范围收敛到变更实际落地之处：如果你指明了一个方向，它就采纳；否则它会读取最近约 20 条提交信息，把探索偏向那些正在活跃开发的路径。在无人触碰的代码里的深化机会，是一个你永远兑现不了的重构——杠杆只在你持续编辑之处才会带来回报——因此报告不再去整理仓库里那些休眠的角落。

### Patch Changes

- [#763](https://github.com/mattpocock/skills/pull/763) [`77d207e`](https://github.com/mattpocock/skills/commit/77d207ef03219cc603e2832e1159cbdd1c91818e) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 打磨 `/ask-matt`——路由器现在覆盖了阶段边界、两个 wayfinder 错误，以及两个它从未提及的技能。

  **阶段边界。** 一个**阶段（phase）**是会话内部的一块工作——拷问、实现、QA——而两个阶段之间的边界，正是你决定如何处置已构建起的上下文之处。原先两点式的 `Crossing sessions` 小节被替换为一棵决策树，按顺序承载全部五个选项（**继续**、`/clear`、`/handoff`、**子代理**、`/compact`），其推理披露在一个新的 `PHASE-BOUNDARIES.md` 中。随之而来三个修正：

  - **`/handoff` 被过度推销了。** 它此前读起来像上下文窗口之间的通用桥梁。它其实很窄：只有当某样东西必须*迁移*时你才需要它——一个新的运行环境、一个新目录、一位同事，或一个在阶段途中分叉出去的旁支任务。它买到的是可移植性。
  - **`/compact` 是默认项，而非首选。** 它位于树的底部，排在上方那四个更便宜或更精确的问题之后。从它开始，会产出一个对摘要所压平的一切都自信却错误的会话。
  - **有两个分支此前完全缺失。** **继续**是首先要排除的那一个——它是唯一能让对话保持为一手来源、而非其摘要的动作——而**子代理**处理任何范围收得足够紧、能 AFK 运行的事情。

  上下文卫生的应急出口现在说的是 `/compact` 而非 `/handoff`（同一运行环境、同一目录、处于边界——handoff 条款不适用），且 smart zone 数字从约 120k 更新为约 150k tokens。

  **Wayfinder 路由。** 人们在这个最重、最耗认知的流程上最常犯的两个错误：

  - **过度伸手去用它。** 它比单次拷问更慢、更密，因此被标记为最重的流程，只保留给那个真正无法塞进一次会话的想法——一个范围界定良好的功能应归于 `/grill-with-docs`，而非这里。
  - **在交接处迷失了路。** 当地图清晰时，wayfinder 交接，而不构建：在 `/to-spec` 处并入主流程（它把地图中相互链接的决策收拢成一份可构建的计划），而不是把地图直接绕进 `/implement`。直奔 `/implement` 只适用于那些结果证明确实很小的工作。

  **缺失的路由。** `/grilling` 和 `/resolving-merge-conflicts` 此前完全不在路由器中，现已加入；而 `grill-me` 与 `grill-with-docs` 依据你是否处于一个工作目录中来区分。

- [#502](https://github.com/mattpocock/skills/pull/502) [`44eed54`](https://github.com/mattpocock/skills/commit/44eed545186ffd0263e8004867750b80cfddd215) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 让 `/setup-matt-pocock-skills` 更友好，并让本地 Markdown 跟踪器与当前规范对齐。

  - **分诊标签**现在只有在 `triage` 技能已安装时才会被询问，且以单个推荐为"是"的问题呈现（"保留默认的分诊标签吗？"），而不是一场覆盖式盘问。当 `triage` 未安装时，这一节——以及 `docs/agents/triage-labels.md`——都会被跳过。
  - **把外部 PR 作为一个请求来源**不再是一个设置问题。GitHub/GitLab 模板仍带着这个开关，默认关闭；用户之后可以在 `docs/agents/issue-tracker.md` 中翻开它。
  - **领域文档**默认为单上下文（single-context），不再询问；只有当仓库显示出 monorepo 信号时才会提供多上下文选项。
  - **本地 Markdown 工单**现在是一个工单一个文件，位于 `.scratch/<feature>/issues/<NN>-<slug>.md`——绝不再是单一合并的 `tickets.md`。`/to-tickets` 和本地 issue-tracker 模板现已一致，且规范文件是 `spec.md`（不是 `PRD.md`），以匹配 `/to-spec`。

  `setup-matt-pocock-skills` 和 `to-tickets` 的文档页已重新同步。

- [#532](https://github.com/mattpocock/skills/pull/532) [`170ad48`](https://github.com/mattpocock/skills/commit/170ad48655825783d0193e850e31a9aac957bb95) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 为通用用途重新措辞 **`grilling`**。它的描述和正文不再把访谈限定于一个软件计划："this plan" → "this"、"enact the plan" → "act on it"、"exploring the codebase" → "exploring the environment"。技术本身未变；它现在读起来像是对任何计划、决策或想法的压力测试。

- [#593](https://github.com/mattpocock/skills/pull/593) [`a4b2009`](https://github.com/mattpocock/skills/commit/a4b2009a1a3ac9575506c10b4c84f08f9bba7a38) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 把 **`grilling`** 从"一次一个问题"改造为"一轮接一轮"。它现在会绘制决策树，并在单独一轮编号问题中问出整个**前沿（frontier）**——每一个其前提都已敲定的问题——然后根据用户的回答重新计算前沿，再问下一轮。同样的 13 个问题在约 3 轮内落地，而非 13 轮。环境能回答的事实会被派发给后台子代理，因此研究绝不阻塞当前轮次：只有位于某个正在进行的探索下游的问题才会等待它。当前沿为空时，会话结束。

  一轮中的每个问题都以一个固定的形状发出——`❓ **Q1** - **<title>**`，然后是正文（散文或多项选择），再然后是自成一行的 `➡️` 推荐。一轮读起来像一个可扫视的编号列表，每条推荐都在视觉上与问题分开，因此你可以按编号作答，而不必把问题引述回来。

  `grill-me`、`grill-with-docs` 和 `triage` 同样以一次一轮的方式运行前沿——`triage` 的拷问步骤和 `grilling` 的 Codex `short_description` 现在也这么说，而不再描述旧的节奏。一次一个问题的退出选项（你全局 `CLAUDE.md` 中的一行）保持不变。

- [#752](https://github.com/mattpocock/skills/pull/752) [`c66bdee`](https://github.com/mattpocock/skills/commit/c66bdeeee002d81e3f8b21403c07f9a0d7bea6da) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 从仓库中移除六个技能。它们没有一个在 Claude Code 插件里，但六个都能通过 [skills.sh](https://skills.sh/mattpocock/skills) 安装——后者会提供仓库里的每一个技能——因此这就是它们从那份列表中离开的方式，以及每一个去了哪里。

  四个退役的技能，各自都已被一个把活干得更好的技能吸收：

  - **`ubiquitous-language`** → **`/domain-modeling`**，它构建并维护整个领域模型，而不是从一次对话里倾倒出一份术语表。
  - **`design-an-interface`** → **`/codebase-design`**。没有任何损失："设计两次（design it twice）"技术——并行子代理生成截然不同的设计，源自 Ousterhout——作为 `DESIGN-IT-TWICE.md` 随该技能一同发布。
  - **`qa`** → **`/triage`** 和 **`/to-tickets`**。
  - **`request-refactor-plan`** → **`/to-spec`** 和 **`/improve-codebase-architecture`**。

  还有两个从来只属于我的——绑定我自己的机器，从未打算给别人用。`personal/` 桶随它们一起消失：

  - **`edit-article`**
  - **`obsidian-vault`**，它硬编码了一条指向我自己 Obsidian 知识库的路径。

  `skills/deprecated/` 仍作为一个桶保留，现在为空。`skills/in-progress/` 未变，现在被如实描述：一个有意公开、可通过 skills.sh 一次安装一个技能的测试版通道。

- [#734](https://github.com/mattpocock/skills/pull/734) [`a2f9333`](https://github.com/mattpocock/skills/commit/a2f9333669ff53db762c87ecda5a15442060a3be) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 完成 `to-prd` → `to-spec` 的重命名："spec" 现在是已发布文本中唯一的用词。

  - **`to-spec`** 不再以"你可能把这份文档称作 PRD"开篇——该括注已从技能及其文档页中去掉。本地 Markdown 跟踪器模板也去掉了同样的措辞回避。
  - **`code-review`** 谈的是源起的 issue/spec 而非 issue/PRD，这体现在它的 frontmatter 描述、它的两轴摘要，以及 spec 来源的搜索顺序中。两个 README 都已重新同步。
  - **GitHub 和 GitLab 跟踪器模板**现在说"本仓库的 Issue 和 spec 以 GitHub/GitLab issue 的形式存在"——它们此前在本地模板更新时仍停留在"PRDs"上，导致这个过时用词传播进了每一个被写入的仓库。
  - **`docs/engineering/research.md`** 曾指向 `https://aihero.dev/skills-to-prd`，一个针对被重命名技能的失效 slug；现在它像其他十九个文档页那样链接 `to-spec`。

  CHANGELOG 和现有的 changeset 在记录这次重命名本身时仍会提到 PRD，这是正确的。

## 1.1.0

### Minor Changes

- [#406](https://github.com/mattpocock/skills/pull/406) [`930a450`](https://github.com/mattpocock/skills/commit/930a450089f77a49af09001d955db8452a4b867d) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 让 **`ask-matt`** 路由器跟上完整的技能集。它现在映射了之前缺失的五个技能：**`tdd`**（作为 `implement` 驱动的红-绿引擎织入主流程）、**`diagnosing-bugs`**（一个新的"有东西坏了"的入口——此前没有 bug 的路由）、**`domain-modeling`** 和 **`codebase-design`**（一个新的"底层的词汇"章节），以及 **`grilling`**（共享的访谈原语）。`prototype` 被充实为一个独立技能，描述也从"用户调用型技能"拓宽为"这些技能"。`CLAUDE.md` 中加入了一条维护规则，让未来任何技能的添加／重命名／移除或流程变更都触发一次 `ask-matt` 复查，与既有的文档页重新同步规则并列。

- [#464](https://github.com/mattpocock/skills/pull/464) [`639df6e`](https://github.com/mattpocock/skills/commit/639df6e7386dfddc739b2aecdeff37a876f2483b) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 推广并加固 **`code-review`**。进行中的 **`review`** 技能被重命名为 **`code-review`**，并从 `in-progress/` 移入 `engineering/`：它现在随插件发布，被列入顶层与 Engineering README（模型调用型），并在 `docs/engineering/code-review.md` 有一个文档页。`/implement` 技能和文档都指向 `/code-review`。

  它还在其 Standards 轴上获得了一个常开的 **Fowler 坏味道基线**——一份精选的约 12 个高信号的"代码中的坏味道"（神秘命名、重复代码、依恋情结、数据泥团、基本类型偏执、重复的 switch、霰弹式修改、发散式变化、夸夸其谈通用性、过长的消息链、中间人、被拒绝的遗赠），内联进 `SKILL.md` 作为一个固定基线，与仓库所记录的任何内容并存，而不是一个新的第三轴。两条约束性规则保证它的安全：仓库中记录的标准优先于基线，且每个坏味道都作为一个判断性意见来报告，而绝不是一个硬性违规。

- [#464](https://github.com/mattpocock/skills/pull/464) [`639df6e`](https://github.com/mattpocock/skills/commit/639df6e7386dfddc739b2aecdeff37a876f2483b) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 在两条战线上打磨 **`grilling`**。

  **一道确认关卡。** 代理在你确认已达成共识之前不会执行计划——把该技能既有的"共识"完成判据变成一道显式的停止关卡。`description` 还招募了预训练中的 **`grill`** 引导词（"Grill the user relentlessly"）来强化调用，且文档页已重新同步。

  **事实 vs 决策。** Grilling 现在把*事实*（去查——探索代码库）与*决策*（把每一个交给人类并等待其回答）分开。旧的一刀切说法——"如果一个问题能通过探索代码库来回答，那就去探索代码库"——是为直接面对真人的情形写的，但一旦另一个技能在"解决工单"的框架内运行 grilling，它就读起来像是也可以自主回答*决策*的许可。把两者分开，能防止一个 grilling 代理抢跑、去回答它自己的问题。

- [#463](https://github.com/mattpocock/skills/pull/463) [`af6d692`](https://github.com/mattpocock/skills/commit/af6d6922c3e2b5288eef155346cbe319e4ed3bd0) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 给 **`writing-great-skills`** 加入两个相邻的 Steering（引导）失败模式，二者都关乎你以为"无关紧要"的语言仍在引导代理。**Negation（否定）**——那头*大象*——是以禁止来引导：说出*不要*做什么，会把被禁止的行为拖进上下文、使它*更*容易被想到，而非更不容易（*别想那头大象*），因此解药是提示**正面**的做法。**Negative Space（负空间）**——那处虚空——是对"你所省略之物"所做的引导视而不见：一个技能拒绝作出的每个决定，都被委派给了代理的先验，而非留作中性，因此解药是为一份草稿的沉默之处而读它，并刻意地决定每一处省略（要么填上，要么把它作为一个真正的**分支**留作开放）。作为两个条目而非一个保留——它们带着不同的诊断和不同的解药——各自是一个完整的 `GLOSSARY.md` 条目外加一个 `SKILL.md` 失败模式要点，与其他每个失败模式的承载方式一致。

- [`850873c`](https://github.com/mattpocock/skills/commit/850873cd73d5f81826ebf512ad35d2b1e113001f) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 让 **`prototype`** 技能变为模型调用型，使代理能自主伸手去用它（其他技能也能）。它的描述围绕引导词 _prototype_ 重写——回答一个设计问题的一次性代码——每个分支配一个触发（状态/逻辑的合理性检查，或 UI 探索）。

- [#409](https://github.com/mattpocock/skills/pull/409) [`0d74d01`](https://github.com/mattpocock/skills/commit/0d74d01cbc64ca27778a49b38599f70c534e76a0) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 加入 **`research`** 技能——一个小巧的、模型调用型技能，它会启动一个**后台代理**，针对**一手来源**（官方文档、源代码、规范、第一方 API）调查一个问题，然后在仓库存放此类笔记的任何位置留下一个带引用的 Markdown 文件。它是可委派的阅读跑腿活：你在它阅读时继续工作，然后拿回一份可供拷问、规划或设计的文档。列入顶层与 Engineering README（模型调用型），加入 `.claude-plugin/plugin.json`，在 `docs/engineering/research.md` 有一个文档页，并在 `ask-matt` 中作为独立路由接入。

- [#469](https://github.com/mattpocock/skills/pull/469) [`a0329ba`](https://github.com/mattpocock/skills/commit/a0329ba95751f58566ed7ab484475917a68f1629) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 把 **`to-issues`** 技能拆分为一个精简的 **Process** 和一个 **Reference** 小节，并教会它处理一次**宽重构（wide refactor）**——一个单一的机械性变更（比如重命名一个列），其**波及范围（blast radius）**扇形铺开至整个代码库，一次性打断成千上万个调用点，以至于没有任何垂直切片能绿灯落地。起草步骤现在指向两个同处一地的参考块：用于普通曳光弹的**垂直切片规则（Vertical slice rules）**，以及**宽重构（Wide refactors）**——它以**扩张–收缩（expand–contract）**来切分变更（在旧形式旁扩张出新形式、以波及范围大小分批迁移调用点、再收缩掉旧形式），使 CI 一批接一批地保持绿灯——或者，当做不到时，只在最后一个"集成并验证"的 issue 处保持绿灯。issue 正文模板也移入了 Reference。

- [#464](https://github.com/mattpocock/skills/pull/464) [`386d4ff`](https://github.com/mattpocock/skills/commit/386d4ff719a7c420ad1454232d0436b01f1b8c17) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 统一规划类技能。**`to-prd` 被重命名为 `to-spec`**——"spec" 现在是唯一贯穿始终的用词（为了可发现性，它仍以"你可能把这份文档称作 PRD"开篇）。**`to-plan` 和 `to-issues` 被合并为一个 `to-tickets` 技能，`to-issues` 被删除。**

  `to-tickets` 把一个计划、规范或对话拆解成一组**工单（tickets）**——曳光弹式的垂直切片，每个都声明它的**阻塞边（blocking edges）**。那单一产物依据 `/setup-matt-pocock-skills` 所配置的跟踪器读作两种：一个**本地文件**（`tickets.md`）把这些边写成文本，你自上而下手工推进；一个**真实跟踪器**把它们写成原生的阻塞链接，因此任何阻塞项都已完成的工单都在前沿上，多个代理可以同时运行。这些边无论如何都存在于工单里——媒介只决定是否有东西对它们并行地采取行动。

  发布时优先使用跟踪器的**原生子 issue** 来表达父 → 切片，以及在跟踪器支持处用**原生阻塞边**表达 `Blocked by`，把 `## Parent` / `## Blocked by` 正文小节保留为兜底。"What to build"模板指向 `/prototype` 的代码所在之处，而不是从中内联一段片段。

  `ask-matt` 的主流程现在路由为 `idea → /to-spec → /to-tickets → /implement`，并且在 `docs/engineering/to-spec.md` 和 `docs/engineering/to-tickets.md` 有面向人的文档页。

- [#464](https://github.com/mattpocock/skills/pull/464) [`0557d57`](https://github.com/mattpocock/skills/commit/0557d57579d9b3d39839fdaf8d4a6542b17539ce) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 在文档中把 wayfinder 定位为一个**情境性的入口坡道**，而非新的主入口流程——以拷问为主导的 _idea → ship_ 链条仍是正门（把 wayfinder 加冕为默认主干是一个 v2 规模的举措，而非 1.1）。**`ask-matt`** 路由器现在点出 wayfinder 的具体触发——一个绿地项目或一次庞大的功能构建，大到一次会话装不下——而两个拷问正门（**`grill-me`**、**`grill-with-docs`**）为那些大到一次会话无法持有的工作*向上*指引至 wayfinder，因此这个入口坡道从读者真正开始的地方就可被发现。

- [#464](https://github.com/mattpocock/skills/pull/464) [`639df6e`](https://github.com/mattpocock/skills/commit/639df6e7386dfddc739b2aecdeff37a876f2483b) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 让 **`wayfinder`** 毕业并重新定位——这个用于规划一大块工作（超过一次代理会话所能持有的量）的技能。它从 `in-progress/` 移入 `engineering/`（插件条目、顶层与 Engineering README 的**用户调用型**分组、`docs/engineering/wayfinder.md` 的文档页，以及 `ask-matt` 中的一条路由），作为一个成熟技能落地。让它走到这一步的重命名与重新定位：

  - **`decision-mapping` 被重命名为 `wayfinder`**，以 `/wayfinder` 调用。"决策地图（Decision map）"既术语化又不准确——实际上只有一种工单类型才是决策。这次重新定位改为在一个雾蒙蒙的问题中绘制一条路线，给出一个连贯的引导词框架——**战争迷雾（fog of war）**、**前沿（frontier）**、**地图（the map）**——而不是在其上叠加一个生造的术语。
  - **以 destination（目的地）作为引导词。** Wayfinding 寻的是通往一个目的地的*路*；它不会冲上去构建它。命名目的地是绘制地图的第一个动作——它固定范围并塑造每一张工单——因此地图每个会话都会获得一个供其定向的 `## Destination` 字段，且分诊会在任何工单存在之前先把它钉住。
  - **规划，而非执行。** 地图产出**决策，而非交付物**；当在有人构建这件事之前已无任何可决之事时，它就完成了。一项工作可以在它的 Notes 中覆盖这一点。
  - **地图是索引，而非仓库。** 一个决策只存在于恰好一个地方——它的工单——因此地图只作要点概述并链接，绝不复述；把雾毕业成一张工单会清除已毕业的那块，使任何东西都不会滞留在两个地方。
  - **默认协作。** 地图从一个本地 Markdown 文件移到仓库的 issue 跟踪器上：一个单一的 `wayfinder:map` issue，其工单是它的子 issue——一个团队可以关注的共享 URL。会话以低分辨率加载地图，并按需放大到各工单。Wayfinder 在一个指针（`docs/agents/issue-tracker.md`）背后保持与跟踪器无关（GitHub、GitLab、本地 Markdown），而 `setup-matt-pocock-skills` 会播下"Wayfinding operations"小节。
  - **通过指派而非标签来认领。** 一个会话通过把一张工单指派给驱动它的开发者来认领它——受指派者*就是*认领——从而把标签词汇释放为仅 `wayfinder:<type>`。
  - **原生阻塞。** 阻塞优先使用跟踪器的原生依赖关系，它在跟踪器自己的 UI 中把前沿以可视方式呈现，因此人类无需打开地图就能看到哪些是可取的。GitHub 和 GitLab 模板给出了原生做法，并带一个正文约定的兜底。
  - **雾 vs 超范围，拆分。** 两个朴素命名的地图小节——`## Not yet specified`（随前沿推进而毕业的范围内之雾）和 `## Out of scope`（被判定超出目的地之外的工作，关闭，永不毕业）——使超出目的地的工作不再读作可取的前沿。
  - **第四种 `task` 工单类型。** 用于阻塞一个决策的字面手动工作（开通访问权限、迁移数据、注册一个服务）——那个*做*而非*决策*的唯一类型，凭借解除对一个决策的阻塞而赢得它的位置。
  - **HITL / AFK 工单分类。** 每种工单类型要么是 **HITL**（human in the loop，人在环中——拷问、原型），要么是 **AFK**（代理独自——研究；task 两者皆可）。一张 HITL 工单只有通过实时交换才能解决，因此"等待人类"从标签中自然得出——一个回答自己问题的 grilling 代理，按定义就已经破坏了 HITL。（这修复了学生们报告的 `/wayfinder` 在拷问*它自己*而非人类的问题。）
  - **无雾早退恢复。** 如果开篇的广度优先拷问未浮现出任何雾，那么这趟旅程小到一次会话即可——于是它停下并询问你希望如何继续，而不是构建一张没人需要的地图。

### Patch Changes

- [#464](https://github.com/mattpocock/skills/pull/464) [`639df6e`](https://github.com/mattpocock/skills/commit/639df6e7386dfddc739b2aecdeff37a876f2483b) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 把 **`tdd`** 重塑为一个仅供参考（reference-only）的技能，并补上一个缺失的反模式。

  **仅供参考。** 红 → 绿 → 重构循环被模型已持有的引导词锚定，因此那份逐步的 Workflow 大多只是在复述这个循环。去掉了 Workflow 和每循环清单；把它们唯一持久的想法——垂直切片／曳光弹——折进了 Anti-patterns 小节和一个简短的"循环规则"列表。引入 **seam（接缝）**作为"测试放在哪里"的引导词：只在预先商定的接缝处测试，在写任何测试之前与用户确认。还去掉了重构阶段——TDD 现在是红 → 绿；重构归于评审阶段，因此重构规则和 `refactoring.md` 被移出（它的归宿是 `code-review`）。

  **同义反复的测试。** 加入了同义反复测试（tautological-test）反模式：一个其断言按照代码计算它的方式重新计算的测试，会因构造而通过、给出零信心——不同于已经覆盖的实现耦合反模式。作为对等物加在相同的位置：一条 Philosophy 原则（期望值必须来自一个独立的事实来源）、一道清单关卡，以及 `tests.md` 中一对 BAD/GOOD 示例。

- [`e00eadb`](https://github.com/mattpocock/skills/commit/e00eadb4bb32c3d5a631ead1a5ed5d6a7c5f74e2) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 扩展 **`triage`** 技能以分诊外部 pull request，把一个 PR 视作一个附带代码的 issue，让它走过同样的角色和状态机。PR 与 issue 并排内联流动（由一个每仓库的设置开关控制），发现步骤只浮现外部 PR，仅限 bug 的"复现"步骤被泛化为单个"验证声明"步骤，且一个冗余检查会把已实现的请求解决为 `wontfix`，而不污染超范围的知识库。`setup-matt-pocock-skills` 为 GitHub/GitLab 获得了"把 PR 作为一个请求来源"的开关。

- [#472](https://github.com/mattpocock/skills/pull/472) [`d869d45`](https://github.com/mattpocock/skills/commit/d869d45afc32beab1c2d1350f8de5e81589512cd) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 修复 **`wayfinder`** 硬编码 issue-tracker 文档路径的问题，它破坏了这套技能其余部分所依赖的间接寻址。

  `to-issues`、`to-prd` 和 `triage` 从不指定路径——它们通过 `setup-matt-pocock-skills` 写入 `CLAUDE.md` / `AGENTS.md` 的 `### Issue tracker` 块来解析跟踪器，该块指向跟踪器文档所在的任何位置。而 wayfinder 却钉死了字面的 `docs/agents/issue-tracker.md`，因此在一个把其代理文档放在别处的仓库里，它会悄悄回退到本地 Markdown 跟踪器——哪怕其 `CLAUDE.md` 明确声明了 GitHub issue。它现在通过同一个指针来解析该文档，并按名称读取其"Wayfinding operations"小节，使间接寻址在整套技能中保持一致。

## 1.0.1

### Patch Changes

- [`d20ee26`](https://github.com/mattpocock/skills/commit/d20ee2684e2a9442698ac3c1e0f2c5b68c4cf296) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 让 **`teach`** 技能以复用为先。课程现在从 `./assets/` 中可复用的**组件**构建——样式表、测验小部件、模拟器、图示助手。复用是默认项：代理在撰写一节课之前先读 `./assets/`，从已有的东西构建，并把任何新的、可复用的东西提取成一个组件，而不是把它内联进去。

## 1.0.0

### Major Changes

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 加入 **`ask-matt`** 技能——一个用户调用型的路由器，为你所处的情境指向正确的技能或流程。

  **破坏性变更：** `ask-matt` 在本仓库其他用户调用型技能之上进行路由，因此它期望它们已被安装。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 加入共享的设计技能，并把现有技能重新接到它们之上。

  - 新的 **`codebase-design`** 技能——深模块词汇（module、interface、depth、seam、adapter）以及把大量行为置于一个小接口之后的原则。此前存在于 `improve-codebase-architecture/LANGUAGE.md` 的那门语言现在住在这里，并被泛化以便跨技能复用。
  - 新的 **`domain-modeling`** 技能——主动构建并磨砺一个项目的领域模型，针对术语表对各术语做压力测试，并保持 `CONTEXT.md` 和各 ADR 处于最新。
  - `improve-codebase-architecture` 现在从 `/codebase-design` 汲取其架构词汇，从 `/domain-modeling` 汲取其领域模型。
  - `tdd` 现在依靠 `/codebase-design` 提供接口设计指导——其内联的 `deep-modules.md` / `interface-design.md` 笔记已被移除，转而采用这个共享技能。
  - `grill-with-docs` 现在通过 `/domain-modeling` 内联地构建领域模型。

  **破坏性变更：** 这些技能现在依赖新的 `codebase-design` / `domain-modeling` 技能，因此你也必须安装它们。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 移除 **`caveman`** 和 **`zoom-out`** 技能。

  - `caveman` 是我正在测试的另一个技能的副本，从未打算公开。
  - `zoom-out` 在实践中未被使用，因此已从仓库中移除。

  **破坏性变更：** 两个技能都已被移除。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 把 **`diagnose`** 技能重命名为 **`diagnosing-bugs`**。

  **破坏性变更：** 以 `/diagnosing-bugs` 调用它——旧的 `/diagnose` 名称已不存在。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 用 **`writing-great-skills`** 替换 **`write-a-skill`**。

  - 移除了 `write-a-skill`。
  - 加入了 `writing-great-skills`（外加它的 `GLOSSARY.md`）——一份把技能写好、编辑好的参考：让一个技能可预测的词汇和原则，把 no-op 追猎到句子级别。
  - 把 `grilling` 暴露为一个模型调用型技能——`grill-me` 和 `grill-with-docs` 背后那个可复用的访谈循环。

  **破坏性变更：** `write-a-skill` 已被移除；改用 `writing-great-skills`。

### Minor Changes

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 加入 **`resolving-merge-conflicts`** 技能——一个用于解决进行中的 git merge 或 rebase 冲突的循环。独立，不依赖其他技能。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 把技能分类法从 **Commands / Skills** 在整个文档中重命名为 **User-invoked / Model-invoked（用户调用型 / 模型调用型）**，并加入 `docs/invocation.md` 来定义这一区分：用户调用型技能只有在你输入时才可触达、其存在是为了编排；模型调用型技能在任务合适时也能被自动触达。一个用户调用型技能可以调用模型调用型技能，但绝不能调用另一个用户调用型技能。

### Patch Changes

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) 感谢 [@mattpocock](https://github.com/mattpocock)！—— 收紧 **`review`** 技能：快速失败的 ref 检查、单一来源的规则，以及 no-op 裁剪。
