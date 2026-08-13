## 它做什么

`setup-matt-pocock-skills` 回答关于一个仓库的三个问题——issue 存放在哪里、triage 标签叫什么名字、以及领域文档放在哪里——并把答案记录为 `docs/agents/` 下的 markdown 文件。

这些文件是仓库之间唯一变化的东西。技能本身在哪里都一样；它们在运行时读取 `docs/agents/issue-tracker.md` 并照它说的做。这就是为什么这套技能不绑定 GitHub，也是为什么没有任何技能文件需要编辑才能指向别处。用"把这些技能连到一个自定义 issue 跟踪器"来调用它，对任何你能以编程方式连接的东西都有效，而且技能零改动。

它是一个由提示驱动的技能，而非一个确定性脚本。它读取你的 `git remote`、你现有的 `CLAUDE.md`、你现有的 `CONTEXT.md`，提出它的发现，并在写任何东西之前等你确认。

## 何时使用它

你通过输入 `/setup-matt-pocock-skills` 来调用它——[agent](https://www.aihero.dev/ai-coding-dictionary/agent) 不会自己去调用它。它被有意标记为不可调用，因此没有其他技能能替你触发它。

每个仓库用一次，在首次使用任何其他工程技能之前。如果 [triage](https://aihero.dev/skills-triage)、[to-spec](https://aihero.dev/skills-to-spec)、[to-tickets](https://aihero.dev/skills-to-tickets) 或 [wayfinder](https://aihero.dev/skills-wayfinder) 开始猜你的 issue 该去哪、或者贴上你的跟踪器没有的标签，那说明它们还没在这里被设置过。一个项目已经进行到一半的仓库是运行它的好地方；该技能会读取已有的东西，先前的工作不会白费。

## 前置条件

它写入你运行它的那个仓库：

| 它写入 | 位置 |
| --- | --- |
| `issue-tracker.md` | `docs/agents/` |
| `domain.md` | `docs/agents/` |
| `triage-labels.md` | `docs/agents/`，仅当安装了 `triage` 技能时 |
| 一个 `## Agent skills` 区块 | `CLAUDE.md` / `AGENTS.md` 中已存在的那一个 |

所有这些都是已提交的 markdown。没有用户级或全局模式：配置存在于仓库中，因此每个仓库都得到它自己的一份副本。

## 三个决策

它以推荐答案领起每个小节，并跳过已经在探索中定下的部分。大多数运行都是两次确认就搞定。

| 决策 | 它提议什么 | 它实际何时会问 |
| --- | --- | --- |
| **Issue 跟踪器** | 与你的 `git remote` 相符的那个 | 总是问——这是唯一真正的选择 |
| **Triage 标签** | 保留五个规范名（`needs-triage`、`needs-info`、`ready-for-agent`、`ready-for-human`、`wontfix`） | 仅当安装了 `triage` 技能时 |
| **领域文档** | 单上下文：根目录一个 `CONTEXT.md` 加 `docs/adr/` | 仅当它察觉到 monorepo 信号时，届时它会提议一个多上下文的 `CONTEXT-MAP.md` |

跟踪器选项：

| 选项 | issue 存放在哪里 | 需要 |
| --- | --- | --- |
| **GitHub** | 该仓库的 GitHub Issues | `gh` CLI |
| **GitLab** | 该仓库的 GitLab Issues | `glab` CLI |
| **本地 markdown** | 本仓库内 `.scratch/<feature>/` 下的文件 | 什么都不需要——完全无需远程 |
| **其他** | 你说在哪就在哪 | 你写一段话描述工作流 |

前三个作为模板随技能发布，开箱即用。本地 markdown 是一等选项，不是后备：一个没有远程的单人项目得到完整支持。有一条告诫值得重申：如果你在用 GitHub，就别用本地 markdown。它们是替代方案，不是层叠。

"其他"也不是个占位桩。它正是 Jira、Linear、Azure DevOps 和 Beads 全都能用的原因：你描述工作流，技能把你的散文记录进 `docs/agents/issue-tracker.md`，下游技能遵循这段散文。社区已经这么做过——一个基于 [MCP](https://www.aihero.dev/ai-coding-dictionary/mcp) 的 Jira 变体、一个形似 `gh` 的 Gitea CLI、一个手工搭的本地仪表盘。

## 常见问题

**我必须用 GitHub 吗？**

不必。GitHub、GitLab 和 `.scratch/` 下的本地 markdown 都作为现成模板发布，其他任何东西都能通过"其他"路径工作。这是记录中被问得最多的问题，大致就是这些说法：*"死锁到 github 了"*、*"能用 GitLab / Jira 吗"*、*"Azure DevOps 呢"*。每次的答案都是：跟踪器是一个设置答案，而非一个技能属性。

**更新技能之后我需要重新运行它吗？**

在 v1.1 之后被直接问到时，Matt 说需要。技能自己的结束语更温和——它告诉你只有在切换跟踪器或重新来过时才需要重新运行。两种说法都站得住脚，而这个落差的原因是真实的：种子模板在版本之间会变，所以由较旧版本写下的 `docs/agents/issue-tracker.md` 可能会对如今读它的技能而言变得过时。如果某个下游技能开始做文档描述得不一样的事，重新运行就是那个便宜的修复。

**它写到了 `CLAUDE.md`，但我用的是 Codex。**

已知的缺口，仍未解决。文件选择规则是"`CLAUDE.md` 存在就编辑它，否则编辑 `AGENTS.md`"——它检查哪个文件存在，而不是哪个[框架](https://www.aihero.dev/ai-coding-dictionary/harness)在运行。一个残留着 Claude Code 遗留 `CLAUDE.md` 的仓库，会把它的 `## Agent skills` 区块放到 Codex 从不读的地方。有两个绕行办法在流传：手动把区块挪到 `AGENTS.md`，或者让 `AGENTS.md` 保持规范地位、把 `CLAUDE.md` 做成一行指向它的指针。如果两个文件都不存在，该技能会问你创建哪个而不是替你挑，这让期望它直接决定的人感到困惑。

**它没有创建我的 triage 标签。**

它不创建。`docs/agents/triage-labels.md` 是一个*映射*——它告诉 `/triage` 你的跟踪器里哪些字符串对应那五个规范角色。它不运行 `gh label create`。在一个全新的 GitHub 仓库里，那些标签确实还不存在，而这已经被作为 bug 报告不止一次了。有两个后续要点：

- 如果你的跟踪器已经在用那些规范名，映射就是一张恒等表，没什么要配置的。这是预期中的常见情况，不是一个缺失的步骤。
- [wayfinder](https://aihero.dev/skills-wayfinder) 的 `wayfinder:map` 和 `wayfinder:<type>` 标签也不在这里创建，而 `gh issue create --label <missing>` 会直接失败而不是创建标签。在 GitHub 仓库上首次运行 wayfinder 之前，手动创建它们。

**我能在这里配置其他技能的行为吗——[grilling](https://www.aihero.dev/ai-coding-dictionary/grilling) 的节奏、问题格式、语气？**

不能。它配置三样东西：跟踪器、标签、文档布局。有人直接请求把它做成每用户偏好的归宿，而一贯的答案是技能保持有主见：*"配置即死亡。"* 偏好属于你的 `CLAUDE.md`，作为纯指令写在那里，每个技能本来就会读它。

**我能把配置放在 `~/.claude` 里而不是提交到每个仓库吗？**

今天不行。有一个正是关于此的公开请求，来自一个在很多仓库间运行这些技能的人，而不存在用户级模式。每个仓库都带着它自己的 `docs/agents/`。

**有一个用来设置其他技能的技能，这难道不奇怪吗？**

一个由来已久的抱怨说奇怪，是这么说的：*"有一个技能去设置另一个技能，这让我觉得不对劲——那意味着 LLM 在配置它自己的技能。"* 这个取舍是真实且被承认的：设置步骤的替代方案，是把跟踪器指令复制进每一个触及 issue 的技能。产出是可检视、可编辑的 markdown，这就是缓解手段——你能读它写的每个文件并手动修改，而日常的微调正是那样，而不是又跑一次。

## 它生效的标志

- `docs/agents/issue-tracker.md` 和 `docs/agents/domain.md` 存在，如果安装了 `triage` 则还有 `triage-labels.md`。
- 在你的框架实际读取的那个指令文件里出现一个 `## Agent skills` 小节，带一行摘要指向那些文件中的每一个。
- 它提议的跟踪器与你真正使用的远程相符，且标签字符串与你跟踪器里真正存在的标签相符。
- 之后，`/to-tickets` 无需问你 issue 在哪就能发布，而 `/triage` 会应用标签而不是凭空造标签。
- 技能文件本身什么都没变。如果设置编辑了某个 `SKILL.md`，那说明出了岔子。

## 它的位置

`setup-matt-pocock-skills` 是工程流程的**一次性设置**，是其他一切所假定的前置条件，而不是链条里的一步。它的邻居是它的读者：[triage](https://aihero.dev/skills-triage)，应用这里写下的标签词汇；[to-spec](https://aihero.dev/skills-to-spec) 和 [to-tickets](https://aihero.dev/skills-to-tickets)，发布进这里命名的跟踪器；以及 [wayfinder](https://aihero.dev/skills-wayfinder)，读取同一个跟踪器文件的"Wayfinding operations"小节来得知地图和子 [ticket](https://www.aihero.dev/ai-coding-dictionary/ticket) 是怎么存储的。它记录的领域文档布局，正是 [domain-modeling](https://aihero.dev/skills-domain-modeling) 稍后填充的那个——它惰性地创建 `CONTEXT.md` 和 ADR，在一个术语或决策真正得到解决时才创建，所以设置之后一个空仓库是预期状态。至于下一步该用哪个技能，[ask-matt](https://aihero.dev/skills-ask-matt) 为整套做路由。
