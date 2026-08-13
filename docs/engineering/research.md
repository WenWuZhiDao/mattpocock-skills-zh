## 它做什么

`research` 通过阅读拥有答案的源头来回答一个问题，然后在仓库中留下一份带引用的 Markdown 文件。它只依据 **[一手来源](https://www.aihero.dev/ai-coding-dictionary/primary-source)** 工作——官方文档、源代码、规范、第一方 API——并把每一条论断都追溯回拥有它的来源，因此当 API 自己的文档可获取时，它不会转述某篇博客对该 API 的说法。

它不会在对话中回答你。产出是一个文件，写在仓库已经用来存放此类笔记的位置，每条论断都带一个链接。这正是重点所在：一份你可以据以反应、交给另一个 agent、或者随手丢弃的文档，而不是一个在[会话](https://www.aihero.dev/ai-coding-dictionary/session)结束时就消失的答案。

## 何时使用它

输入 `/research`，或者当一个任务演变为阅读跑腿活时，[agent](https://www.aihero.dev/ai-coding-dictionary/agent) 会自动调用它。

当下一步是从工作目录之外*查明某件事*时使用它——某个第三方 API 如何表现、某份规范究竟怎么说、某个版本论断是否成立——而你又不想为了阅读而卡住自己的主线程。你需要什么决定了该用哪个技能：

| 你需要什么 | 使用 |
| --- | --- |
| 一个决策正在等待的外部事实 | `research` |
| 一个*和你一起*、通过访谈做出的决策 | [grilling](https://aihero.dev/skills-grilling) |
| 一个写进 `CONTEXT.md` 和 ADR 的持久架构决策 | [grill-with-docs](https://aihero.dev/skills-grill-with-docs) |
| 查明某种方案在你的代码库中是否行得通 | [prototype](https://aihero.dev/skills-prototype) |
| 一个大到无法在单个会话中容纳的计划 | [wayfinder](https://aihero.dev/skills-wayfinder) |

`research` 和 `grill-with-docs` 之间的界线在于**产出物的保质期**。研究产生的是短命资产——比如截至本周这个库的认证机制做了什么。ADR 记录的是你会保留的决策。如果你产出的是一个决策而非一个事实，那你是在 [grilling](https://www.aihero.dev/ai-coding-dictionary/grilling)，而不是在做研究。

## 委派跑腿活

其决定性的动作是阅读作为一个**后台 agent** 运行。你继续工作；它跑开去，把每条论断追溯到其一手来源，写一个 Markdown 文件，然后回报。研究是你委派出去的跑腿活，而不是你外包出去的思考——你得到一份可以据以拷问、规划或设计的文档，而拍板的仍然是你。

这种委派是没有防护的，后台 agent 还能再生出一个自己的后台 agent。这是该技能记录得最清楚的粗糙之处。

文件落在哪里由仓库决定，而非由技能决定：它遵循笔记已有的任何惯例，如果没有惯例，它会挑一个合理的位置并告诉你在哪。每次运行写一个文件。

## 常见问题

**它生出了第二个研究 agent——这是应该发生的吗？**

不是。这是一个未修复的 bug，[issue #530](https://github.com/mattpocock/skills/issues/530)。该技能告诉它的调用者去起一个后台 agent，但没有限制 agent 类型，于是它生出的 agent 是一个 `general-purpose` agent，持有 `Agent` 工具和同样的指令——并再次触发它们。有一位报告者测得单个研究任务在三次重叠运行中花费了约 45 万 [token](https://www.aihero.dev/ai-coding-dictionary/token)，其中那个重复的运行在半小时后才结束，完全在视野之外。它在 Claude Code 之外也能复现；同样的嵌套在使用 GPT-5.6-sol 的 Codex 中也得到确认。尚无发布的修复。有用户在自己安装的副本里打了补丁，加了一行告诉一个已经是[子 agent](https://www.aihero.dev/ai-coding-dictionary/subagent) 的 agent 自己去做这活，这有帮助但只是指令层面的，不是结构层面的。调用后留意你的后台任务列表，并停掉那个重复的。

反面的失败也存在：如果你自己的全局指令禁止一个 agent 再次委派工作，那么后台 agent 会礼貌地拒绝这个任务，而该技能就悄悄地什么都没做。

**文件应该放在哪里——我该不该提交它？**

该技能把文件放在仓库已经用来存放笔记的位置，除此之外没有意见。社区的意见相当一致：ADR 保留，研究文件不保留。这个观点最尖锐的版本，来自 Discord 上一个正好讨论这个问题的帖子："ADR 要，其他一切在做完后归档或删除。否则它会变成工作的杂物，如果你已经偏离了规范/研究，还会污染未来对仓库的阅读。"一个研究文件记录的是写它那天为真的东西，所以一个过时的研究文件比没有更糟。总的来看，这些产物并不真正属于 git，也没有一个规范的归宿——人们改用 Obsidian、一个单独的知识仓库、或者 issue 跟踪器。

**什么算是"高可信"的一手来源，谁来决定？**

[模型](https://www.aihero.dev/ai-coding-dictionary/model)决定。该技能命名了哪些*种类*的来源合格——官方文档、源代码、规范、第一方 API——但没有白名单、没有域名门禁、也没有校验环节。这是该技能最初被提出时最响亮的反对意见，而且从未被公开回答过："五个指向垃圾的研究子 agent 只是让你更快得到五个自信的错误答案。你要怎么把关什么算高可信来源？"你实际拥有的缓解手段是每条论断上的引用。跟进其中两三条。如果它们落在的是对那东西的总结而非那东西本身，那么这次运行在它唯一的任务上就失败了。

**后来的会话会复用早先运行找到的东西吗？**

不会。没有任何东西会自动加载过去的研究文件；它只是一个躺在仓库里的文档，直到一个人或一个技能指向它。这在设计之初就被提出为最强的质疑——"价值在于这份 markdown 成为 agent 日后重读的[上下文](https://www.aihero.dev/ai-coding-dictionary/context)，而不是抓取本身。一个写完即死的文件只是花哨的搜索"——而发布的技能并没有解决它。实践中，这个文件靠被有意地喂给下一步来体现价值：把它附到一份规范上、把它引用进一场拷问会话、让一个 [ticket](https://www.aihero.dev/ai-coding-dictionary/ticket) 指向它。

**为什么不直接让 agent 去读文档就行了？**

你可以，而一个字面就这么说的两行提示，正是这个技能所取代的做法。相对于提示，该技能买来两样东西：它在后台运行，因此你的会话保持[上下文](https://www.aihero.dev/ai-coding-dictionary/context)干净；而且一手来源约束和带引用的文件产出每次都以同样的方式出来，而不是随你当时怎么措辞而变。相对于[框架](https://www.aihero.dev/ai-coding-dictionary/harness)自带的深度研究模式，差别在于产物和来源纪律，而非搜索本身。如果一个两行提示就能在小问题上给你所需，那就用两行提示。

**它什么时候停止阅读？**

该技能里没有停止标准，这表现为两个看似相反实则同一缺口的抱怨：走得太深的 agent，和广泛覆盖了一个话题却漏掉那个真正要紧的具体细节的 agent。一位从业者这样说："深度研究技能有时候有点太深了。而且让 agent 去研究通常会导致漏掉关键细节。"划定范围是你的事。一个狭窄、可回答的问题——一个 API、一个行为、一个版本论断——回来的效果远比"研究 X"要好。

**`/wayfinder` 创建了研究 ticket——那些要我自己去解决吗？**

不用，它现在替你触发它们了。在 v1.1 之后尚未发布的改动里，一场绘图会话会为每个研究 ticket 生出一个 `/research` 子 agent 并并行消化它们，把发现捕获在一个用完即弃的 `research/<name>` 分支上，并从 ticket 带一个[上下文指针](https://www.aihero.dev/ai-coding-dictionary/context-pointer)。研究 ticket 是 wayfinder "每会话一个 ticket"规则的唯一例外，因为它们是 [AFK](https://www.aihero.dev/ai-coding-dictionary/afk) 的——没有什么在等你。这些分支有两个已知的坑：子 agent 曾被观察到从一个本不该合并的分支开了一个 draft PR（[issue #576](https://github.com/mattpocock/skills/issues/576)），以及日后删除该分支会破坏 ticket 持有的上下文指针。

## 它生效的标志

- 你自己的会话在继续。如果你坐着看它读，那么委派就没有发生。
- 恰好出现一个新的后台任务。第二个名字几乎相同的是嵌套 bug。
- 出现一个新的 Markdown 文件，在仓库已经用于笔记的文件夹里，并且 agent 告诉你路径。
- 它里面每条论断都带一个链接，随机跟进两条会落到一份官方文档、一份规范、或者实际的源文件上——而不是落到某人对它的复述上。
- 你能仅凭这个文件就做出你原本卡住的那个决策，无需自己回去看那些来源。

## 它的位置

一个随时可用的独立技能，它给思考类技能供料，而不是坐在构建链条上。它的文件是拿去*进入*流程的东西：当事实已经摆在桌面上时，[grilling](https://aihero.dev/skills-grilling) 和 [grill-with-docs](https://aihero.dev/skills-grill-with-docs) 能问出更锋利的问题，而 [to-spec](https://aihero.dev/skills-to-spec) 能据以综合。[wayfinder](https://aihero.dev/skills-wayfinder) 是唯一直接调用它的技能，用一个 `/research` 子 agent 解决它地图上的每个研究 ticket。整张地图见 [ask-matt](https://aihero.dev/skills-ask-matt)。
