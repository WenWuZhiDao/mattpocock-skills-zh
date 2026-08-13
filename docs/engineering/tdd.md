## 它做什么

`tdd` 以测试优先的方式构建一个功能或修复一个 bug：一个失败的测试，然后刚好够让它通过的代码，然后下一个行为。它携带着让这个循环产出值得保留的测试的那些标准——什么是好测试、测试放在哪里、mock 是用来做什么的、以及那三个悄悄毁掉一个测试套件的反模式。

它不会在一个你还没先同意的接缝处写测试。在任何测试存在之前，它会命名它打算在哪些公共边界上测试，并停下来等你确认，因为测试精力是有限的，而这正是你把它花在关键路径上、而非每一个边界情况上的地方。另一件要知道的事是，`tdd` 是一个**参考**，而非一个驱动者。它持有循环的规则，而由别的东西（你，或 [implement](https://aihero.dev/skills-implement)）来运行应用这些规则的[会话](https://www.aihero.dev/ai-coding-dictionary/session)。

## 何时使用它

输入 `/tdd`，或者当一个任务符合时——以测试优先构建功能或修复 bug，或者当你说"red-green-refactor"时——[agent](https://www.aihero.dev/ai-coding-dictionary/agent) 会自动调用它。

当有一个具体的行为要构建、有一个输入和一个可观察的输出、而你想要能在重构中存活的测试时，使用它。

| 你的处境 | 去哪里 |
| --- | --- |
| 一个有明确输入和输出的行为——业务逻辑、一个请求/响应契约、一次转换、校验 | `tdd` |
| 行为还没有定下来 | [to-spec](https://aihero.dev/skills-to-spec)，它也会在写任何代码之前先商定测试接缝 |
| 问题真正在于接口的形状，而非测试 | [codebase-design](https://aihero.dev/skills-codebase-design) |
| 你有一份[规范](https://www.aihero.dev/ai-coding-dictionary/spec)或若干 [ticket](https://www.aihero.dev/ai-coding-dictionary/ticket)，想让整个构建替你跑完 | [implement](https://aihero.dev/skills-implement)，它按 ticket 驱动 `tdd` |
| 配置、接线、胶水代码、类型注解、直白的 CRUD 委派 | 这里没有一个合适——见下面那个未解决的缺口 |

最后那一行是个真实的漏洞，不是风格偏好。该技能决定接缝*放在哪里*；它里面没有任何东西决定一个改动*是否*值得跑这个循环。在一个没有独立事实来源可供断言的改动上跑它，你会得到一个复述实现的测试——正是该技能自己警告过的那个同义反复反模式，只是从另一个方向抵达的。这是 [issue #746](https://github.com/mattpocock/skills/issues/746)，并且未解决。在它关闭之前，那个判断是你或你的 `CLAUDE.md` 的事。

## 前置条件

需要安装 [codebase-design](https://aihero.dev/skills-codebase-design)。`tdd` 过去携带它自己的深模块和接口设计笔记；在 v1.0 里那些被删除，改用共享技能，而 `tdd` 现在依赖它获取接口设计词汇。其他什么都不需要——该技能是[无状态](https://www.aihero.dev/ai-coding-dictionary/stateless)的，不写自己的任何文件。

## 这个循环，以及它运行所在的接缝

三个词撑起这个技能。

**红-绿。** 写那个失败的测试，然后只写刚好够让它通过的代码。不去预判再下一个测试。没有重构阶段：它在 2026 年 6 月被去掉了，因为 agent 基本上从不执行它，也因为审查和实现作为分开的会话效果更好。重构属于 [code-review](https://aihero.dev/skills-code-review)。

**垂直切片。** 一个接缝、一个测试、一个最小实现，然后重复——第一个循环是一颗**曳光弹**，端到端地证明单条路径。相反的是水平切片：先写所有测试，再写所有代码。批量测试验证的是*想象中的*行为，它们检查事物的形状而非用户所做的事，并且它们在你理解实现之前就把你绑定到一个测试结构上。

**预先商定的接缝。** 接缝是你在其上观察行为、而不伸手到内部去的公共边界。规则是绝对的：不在未确认的接缝上写测试。在完整链条中，接缝更早商定，在 [to-spec](https://aihero.dev/skills-to-spec) 期间——"`/tdd` 被告知只在预先商定的测试接缝上工作，`/code-review` 检查只用了商定过的测试接缝。"单独调用时，`tdd` 直接问你。

它被写来防止的三个反模式：

| 反模式 | 迹象 |
| --- | --- |
| 与实现耦合 | 当你重命名一个内部函数时测试就坏了，尽管行为没变。mock 了内部协作者、断言了调用次数、用数据库查询而非接口来验证。 |
| 同义反复 | 期望值是按代码计算它的方式算出来的，所以测试从构造上就通过。期望值必须来自别处——一个已知正确的字面量、一个已算好的例子、规范。 |
| 水平切片 | 一批测试在任何实现之前就落地了。 |

mock 仅用于系统边界——外部 API、时间、随机性，有时是文件系统或数据库。不用于你自己的模块。

## 常见问题

**它为什么不重构？描述里说的是"red-green-refactor"。**

因为重构步骤被移除了，而描述没有。移除是有意的：agent 基本上从不做它，而且把实现和审查放在分开的会话里效果更好。结果照本宣科还算不算 TDD，不如结果这个循环是否产出更好的代码来得重要。触发短语和正文之间的不匹配被记录为 [issue #589](https://github.com/mattpocock/skills/issues/589)，仍未解决，所以"red-green-refactor"仍作为一个能触发该技能的短语起作用。你得到的是红 → 绿，以及在 [code-review](https://aihero.dev/skills-code-review) 里重构。

**它让我选一个测试接缝，而我完全不知道该选哪个。**

这是该技能被报告最多的摩擦（[issue #607](https://github.com/mattpocock/skills/issues/607)）。提示只按名字列出候选接缝，没有任何关于每一个能捕捉或漏掉什么的信息，所以你是在标签之间做选择。尚无发布的修复。实用的绕行办法是在回答之前向 agent 询问权衡——组件级接缝会漏掉集成接缝能捕捉的什么，以及它慢多少。这也是为什么链条在 `to-spec` 里预先商定接缝，那时你看到的是整个功能而非一个提示。

**它在测试之前就写了实现，尽管技能说先红。**

会发生。有一位用户就此追问[模型](https://www.aihero.dev/ai-coding-dictionary/model)，得到一个异常诚实的回答："我知道技能说'一次一个测试，看它因正确的原因失败'——我读了。我只是默认走了我平常的习惯。"该技能是被写来与此共处的。没有任何指令能让一个 agent 100% 遵守，而把这一点逼得更紧会为很小的收益而限制 agent 的创造力——即使没被严格遵循，这个循环也值得跑，因为结果整体上仍然更好。如果某个切片的严格遵守很要紧，就盯着这次运行，而不是信任技能去强制它。

**它应该先写浏览器测试或端到端测试吗？**

通常不该，而且技能不会阻止它。有一位用户报告 agent 先写了一个 Playwright 测试，然后为一个还不存在的功能烧掉一个长循环反复重跑它，并断定是*测试*坏了。在你的 `CLAUDE.md` 里配置这一点。浏览器测试足够慢，慢到红-绿反馈循环不再划算；在你仓库的 `CLAUDE.md` 里声明它们在行为跑通之后再写。

**`/tdd` 会取代 `/implement`、或课程里的 `/do-work` 吗？**

不会。`/tdd` 记录方法论；`/implement` 是一个非常简单的 工作→反馈→提交 循环，是 `/do-work` 的直接替身。课程里那个单一的 `/do-work` 步骤现在被拆分到 `/implement`、`/tdd` 和 `/code-review` 之间。如果你在问针对一个 ticket 该跑哪个，答案几乎总是 `/implement`。

**深模块和接口设计的指导去哪了？**

在 v1.0 进了 [codebase-design](https://aihero.dev/skills-codebase-design)，被泛化以让几个技能共享一套词汇。`refactoring.md` 同时离开了；重构现在是 [code-review](https://aihero.dev/skills-code-review) 的活，而那个技能携带了 Fowler 坏味道基线。

**它知道我其他的 ticket 吗？**

不知道。针对一个 ticket 运行时，它会乐呵呵地提议属于某个同级 ticket 的工作，因为它看不到 issue 图的其余部分（[issue #129](https://github.com/mattpocock/skills/issues/129)）。Matt 的立场是这不是 `tdd` 的活。把规范和 ticket 一起传进去有帮助；一开始就把 ticket 切成合适大小帮助更大。

## 它生效的标志

- 在任何测试文件存在之前，它停下、命名它打算测试所在的接缝，并等待。
- 出现一个测试，变红，得到刚好够通过的代码，然后才出现下一个测试——不是一批测试后面跟着一批代码。
- 测试名读起来像能力（"用户能用有效的购物车结账"），而非内部实现（"结账调用 paymentService.process"）。
- 断言中的期望值是你能追溯到规范的字面量，而非按代码计算它的方式重新算出来的值。
- 重命名一个内部函数不会弄坏套件里的任何东西。
- mock 只出现在外部边界处——支付 API、时钟——而绝不围绕你自己的模块。

## 它的位置

`tdd` 是主链条构建步骤内部的引擎，而非它自己的一个步骤：

```txt
grill-with-docs → to-spec → to-tickets → implement → code-review
```

[to-spec](https://aihero.dev/skills-to-spec) 预先商定测试接缝，[implement](https://aihero.dev/skills-implement) 按 ticket 驱动 `tdd`，而 [code-review](https://aihero.dev/skills-code-review) 事后检查只用了商定过的接缝——并且拥有 `tdd` 不再做的那份重构。它的另一个邻居是 [codebase-design](https://aihero.dev/skills-codebase-design)，即 `tdd` 所说的接缝和深模块词汇的共享来源。你也可以单独使用它，只要有一个具体行为要构建、且没有完整规范在场。当你不确定哪个技能适合你的处境时，[ask-matt](https://aihero.dev/skills-ask-matt) 为你做路由。
