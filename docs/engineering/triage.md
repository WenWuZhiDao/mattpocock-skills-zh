## 它做什么

`triage` 处理你项目跟踪器上的 issue，把每一个推过一个由**triage 角色**——一个类别角色和一个状态角色——构成的小型状态机，最后留下的要么是一份 agent 就绪的简报、一个给报告者的具体问题、要么是一个记录了原因的已关闭 issue。

它只针对**不是你创建的** issue。原始 bug 报告、进来的功能请求、一个不请自来的外部 pull request——从外部落进跟踪器的工作，以报告者留下的任何形状。[to-tickets](https://aihero.dev/skills-to-tickets) 产出的 [ticket](https://www.aihero.dev/ai-coding-dictionary/ticket) 从构造上就已经 agent 就绪，对它们跑 `triage` 往好里说也是白费工。规则很直白：`/triage` 只针对进来的 issue，不针对你自己创建的 issue。

第二件把它与手动打标签区分开的事：它推荐并等待。它带着推理告诉你它的类别和状态判断，加上它在代码库里发现的东西，在你指示之前不应用任何东西。

## 何时使用它

你通过输入 `/triage`、然后用自然语言描述你想要什么来调用它——[agent](https://www.aihero.dev/ai-coding-dictionary/agent) 不会自己去调用它。"给我看任何需要我关注的东西"、"我们来看 #42"、"把 #42 移到 ready-for-agent"。

| 你有什么 | 去哪里 |
| --- | --- |
| 一个满是别人原始报告的跟踪器 | `/triage` |
| 你自己一个粗糙的想法，什么都没写下 | [grill-with-docs](https://aihero.dev/skills-grill-with-docs) |
| 一场敲定的对话，要变成一份[规范](https://www.aihero.dev/ai-coding-dictionary/spec) | [to-spec](https://aihero.dev/skills-to-spec) |
| 一份规范，要拆成 agent 就绪的 ticket | [to-tickets](https://aihero.dev/skills-to-tickets) |
| 一个已确认的 bug，需要一个根因、而非一个标签 | [diagnosing-bugs](https://aihero.dev/skills-diagnosing-bugs) |

## 前置条件

`triage` 读写你的 issue 跟踪器，所以 [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) 必须先配置好那个跟踪器及其标签词汇。下面的角色名是**规范的**；你跟踪器里的标签字符串可能不同，而那个映射是设置提供的。如果你的跟踪器已经完全使用规范名，那就没什么要映射、也没什么要设置的。

跟踪器配置也决定外部 pull request 是否算作一个请求面，以及谁算外部。那个标志默认关闭，不再是一个设置问题——如果你想让 PR 进入范围，在 `docs/agents/issue-tracker.md` 里翻转它。

## 状态机

每个被 triage 的条目最终恰好带一个类别角色和一个状态角色。两个类别：`bug`（某个东西坏了）和 `enhancement`（新功能或改进）。五个状态：

| 状态 | 意思 |
| --- | --- |
| `needs-triage` | 你需要评估它。一个未打标签的 issue 通常首先落到的地方。 |
| `needs-info` | 等待报告者。当他们回复时返回 `needs-triage`。 |
| `ready-for-agent` | 完全指定，附带一份 agent 简报。一个 [AFK](https://www.aihero.dev/ai-coding-dictionary/afk) agent 可以接手它。 |
| `ready-for-human` | 同一份简报，加上为什么这个不能委派——判断、外部访问、手动测试。 |
| `wontfix` | 已关闭，记录了原因。 |

这就是全部词汇，而"恰好一个状态角色"这个不变量是保持查询简单的原因。它也是这个[技能](https://www.aihero.dev/ai-coding-dictionary/skill)被请求最多的领域：用户请求过第六个状态，用于已指定但被另一个 issue 阻塞的工作、用于门控在未来触发上的 `deferred` 工作、以及一个终态 `implemented`。这些都没有发布。见下面的问题。

`wontfix` 分成三路，而这个区别很重要，因为其中只有一路会写入知识库：

| 你为什么关闭它 | 会发生什么 |
| --- | --- |
| 已经实现 | 一条指向它已经存在于何处的评论。不往 `.out-of-scope/` 写任何东西——它是一个已构建的功能，不是一个被拒绝的，把它归档在那里会污染去重检查。 |
| 被拒绝的 bug | 礼貌的解释，然后关闭。 |
| 被拒绝的 enhancement | `.out-of-scope/` 里的一个文件，从关闭评论链接过去，然后关闭。 |

`.out-of-scope/` 是每个被拒绝的**概念**一个 markdown 文件，而非每个 issue 一个，写成一份简短的设计文档而非一行数据库记录：什么被拒绝了、为什么、以及每一个请求过它的 issue。`triage` 在评估任何东西之前读取整个目录，并按概念而非关键词匹配——"夜间主题"匹配 `dark-mode.md`。当它命中一个匹配时，它浮现出那个旧决策并问你是否仍然那么想，而不是从头重新辩论这个请求。

## 先验证再简报

在任何 [grilling](https://www.aihero.dev/ai-coding-dictionary/grilling) 之前，`triage` 检查那个声明是否真的成立。对一个 bug，它从报告者的步骤复现它。对一个 PR，它检出分支并运行相关测试。然后它报告三件事中哪一件发生了：已确认，带代码路径；未能复现；或者细节不足以尝试，而后者本身就是最强的 `needs-info` 信号。

它在同一遍里对代码库再跑两个检查——**冗余**（这个是否已经实现，按领域概念而非按报告者的措辞搜索？）和**先前拒绝**（`.out-of-scope/` 是否已经说了不？）。两个都很廉价，两个命中时都产出一个 `wontfix`。

所有这些的存在都是为了让一个产物变好：**agent 简报**，即一个 issue 移到 `ready-for-agent` 时张贴的结构化评论。一旦张贴，简报就是契约，而原始报告只是上下文。简报被写成**持久的**而非精确的，因为一个 issue 可能在 `ready-for-agent` 里坐上好几周，而代码在它下面移动。所以它们命名类型、签名和行为契约，绝不命名文件路径或行号。一次已确认的复现造就一份远比猜测更强的简报。

## 一个 PR 是一个附带了代码的 issue

在跟踪器把外部 pull request 当作一个请求面的地方，它们跑过同一个状态机——同样的类别、同样的状态、同样的转换。状态只是对照 diff 来读：`ready-for-agent` 意思是附了一份简报、一个 agent 应该对代码采取下一步，`ready-for-human` 意思是它已就绪、可由一个人合并。一份 PR 上的简报描述的是对现有 diff 还剩什么要做，而不是如何从零构建那个东西。

发现只浮现*外部* PR，因为一个协作者进行中的分支不是 triage 工作。那个过滤器只用于发现——显式命名一个 PR，无论谁写的它都会被 triage。有一个粗糙之处：GitHub 模板的外部 PR 列举命令向 `gh pr list` 请求一个 `gh` 并不暴露的 `authorAssociation` 字段，所以那条命令按写法直接失败（[#468](https://github.com/mattpocock/skills/issues/468)）。

## 常见问题

**我跑了 `/to-spec` 和 `/to-tickets`，现在那些 ticket 未经 triage 坐在那里。我要对它们跑 `/triage` 吗？**
不要。它们已经 agent 就绪了——`to-tickets` 在发布时就应用 `ready-for-agent` 标签，正是为了让一个 AFK 运行器无需再过一遍就接手它们。碰上这个的那位用户跑了规范流程，看到输出上是 `needs-triage`，发现他的 AFK 运行器忽略了一切。`triage` 是从外部到来的工作的入口匝道；规范流程是你发起的工作的车道。它们在 `ready-for-agent` 汇合，而非更早。

**既然现在有了 `to-spec` → `to-tickets` → `implement` 流程，`triage` 还相关吗？**
只有当你有入站工作时才相关。`triage` 早于那条主干，做的是一件不同的活：它是别人提交的报告的车道。如果你跟踪器里的一切都出自你自己的规划，你会很少打开它。如果你维护任何公开的东西、或者你的团队向你提交 bug，它就是前门。主要用途是接收外部贡献者 issue 的开源仓库。

**agent 试图应用 `ready-for-agent`，而 `gh` 说这个标签不存在。**
已知的未解决 bug（[#616](https://github.com/mattpocock/skills/issues/616)）。`setup-matt-pocock-skills` 把标签词汇写进 `docs/agents/triage-labels.md`，但不在你的跟踪器里创建标签。自己用 `gh label create` 或跟踪器的 UI 创建那五个状态标签和两个类别标签，一次，它就不再报错。issue 里链接了一个社区修复分支，尚未被合并。

**五个状态不够——blocked、deferred、或 implemented 怎么办？**
这是这个技能被提交最多的缺口，有三种形状。一个已完全指定但在等另一个 issue 关闭的 issue（[#139](https://github.com/mattpocock/skills/issues/139)）——报告者的抱怨是 `ready-for-agent` 在那里"技术上为真"但有误导性，所以一个 agent 接手了却撞上一堵墙。触发门控的、意图中但尚不可行动的未来工作（[#297](https://github.com/mattpocock/skills/issues/297)）。以及一个"已实现、等待验证"的终态，没有它，一个 AFK 运行器可能重新排入已完成的 ticket。Matt 已经同意 blocked 的情况是真实的，但对名字未定（`blocked` 对 `paused`）。这些都没有发布。人们用的绕行办法是在类别旁边加一个仓库本地的额外标签，这以技能不知道它为代价，让规范的状态槽被某个诚实的东西占着。一个社区衍生走得更远，加了 `needs-slicing`、`tracking` 和工作量标签——那管用，但那是他们的，不是技能的。

**这和 `/diagnosing-bugs` 有什么不同？**
这里的验证步骤是有意浅的——足以回答"这是真的吗，它大致住在哪里"，而不是找一个根因。当一个 bug 在几分钟内无法从报告者的步骤复现时，诚实的做法是 `needs-info`，或者如果你想现在就追它，用 [diagnosing-bugs](https://aihero.dev/skills-diagnosing-bugs)。目前两个技能的文本都没提到对方；一位用户发现了那个接缝，而它仍未解决。

**我能让它对着我整个 backlog 跑起来吗？**
你可以要求，但留意它读什么。"给我看需要关注的东西"这一遍是一个廉价的列举，意在用于*选择*——你挑一个，然后它才对你挑的那个收集完整[上下文](https://www.aihero.dev/ai-coding-dictionary/context)。一次跑二十个 issue，一个 agent 会悄悄退回把那个廉价列举当作它的证据基础，而那返回的是 issue 正文却不含评论。一位用户碰上的正是这个：三个 issue 已经带着一条说"已修复，建议关闭"的评论，而三个都反而得到了全新的 agent 简报。如果你想要一次批量过一遍，就明确说必须逐个 issue 读评论。

**它能和 Linear、或者除 GitHub Issues 之外的任何东西一起工作吗？**
能——跟踪器是配置，而非一个硬编码的假设，人们对着 Linear（通过 `linear` CLI）、GitLab、和 `.scratch/` 下的纯 markdown 文件跑它。一个常见的分工是 Linear 用于 issue 和规划、GitHub 用于代码和 PR：说"issue tracker"的技能映射到 Linear，说"PR"的技能映射到 GitHub。在本地 markdown 跟踪器上有一个未解决的模板 bug，生成的文件可能把验收标准带两次，一次在顶层、一次在 agent 简报内部（[#200](https://github.com/mattpocock/skills/issues/200)）。

## 它生效的标志

- 它触及的每个条目最终都恰好带一个类别角色和一个状态角色——从不为零，从不有两个冲突的状态。
- 它给你一个带推理的推荐并停下，而不是重新打标签然后继续。
- 在任何东西到达 `ready-for-agent` 之前，bug 被复现了、或者 PR 被检出并跑了。
- 它写的简报命名类型和行为，不含文件路径也不含行号。
- 一个六个月前被拒绝的请求回来了，它就此说明并引用旧的原因，而不是重新 triage 它。
- 它张贴的每条评论都以 `> *This was generated by AI during triage.*` 开头。

## 它的位置

`triage` 是一个**入口匝道**，而非主链条里的一步。主流程从你有过的一个想法跑起——grill、spec、tickets、implement、review——而 `triage` 是替之而来的工作的并行车道。它在同一个地方汇入：一个被打上 `ready-for-agent` 标签、上面带一份简报的 issue，[implement](https://aihero.dev/skills-implement) 就像接手一个来自 [to-tickets](https://aihero.dev/skills-to-tickets) 的 ticket 一样接手它。当一个请求在能被简报之前需要打磨时，`triage` 把 [grilling](https://aihero.dev/skills-grilling) 和 [domain-modeling](https://aihero.dev/skills-domain-modeling) 一起跑，一次一轮问题，让决策在做出时落进 `CONTEXT.md` 和 ADR。当你不确定自己在哪条车道时，[ask-matt](https://aihero.dev/skills-ask-matt) 为你做路由。
