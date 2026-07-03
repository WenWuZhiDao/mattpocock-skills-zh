Quickstart:

```bash
npx skills add mattpocock/skills --skill=diagnosing-bugs
```

```bash
npx skills update diagnosing-bugs
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/diagnosing-bugs)

## 它做什么

`diagnosing-bugs` 为疑难 bug 和性能回退运行一个严谨的诊断回路——构建一个复现，把它最小化，给假设排序，埋点，然后带着回归测试修复。

在你拥有一个**紧的反馈回路（tight feedback loop）**之前，它拒绝做任何假设——一个可运行的命令，它已经对_这个_ bug 变红。在那个命令存在之前就去读代码构建理论，正是这个技能所防止的失败。没有能变红的回路，就没有诊断。

## 何时使用它

输入 `/diagnosing-bugs`，或者当任务契合时智能体会自动触及它——它在"diagnose" / "debug this"时触发，或当你报告某个东西坏了、抛异常、失败或很慢时。

在那些难缠的问题上触及它：一眼看不出的 bug、间歇性的抖动、在两个已知良好状态之间悄然潜入的回退。若只是想快速做个一次性尝试来检验一个设计问题的合理性，而非追查缺陷，改用 [prototype](https://aihero.dev/skills-prototype)。

## The tight loop is the skill

其余一切——二分、假设检验、埋点——一旦你有了信号就都是机械性的。所以该技能在第一阶段投入不成比例的精力：构造一个通过/失败命令，它驱动实际的 bug 代码路径并断言用户确切的症状，然后**收紧**它，直到它快速、确定、可由智能体运行。一个 30 秒的不稳定回路只比没有强一点点；一个 2 秒的确定性回路则是调试超能力。

它给你一架构建那个回路的梯子——失败的测试、curl 脚本、CLI diff、无头浏览器、重放的 trace、一次性的测试台架、fuzz 回路、`git bisect run`、差分运行——并且，仅作为最后手段，一个人在回路中的 bash 脚本。对于非确定性的 bug，目标不是一个干净的复现，而是一个**更高的复现率**：循环触发器、并行化、施加压力，直到抖动可被调试。

## 它生效的标志

- 它在推理_之前_构建并运行一个复现命令——并粘贴调用方式及其变红的输出。
- 回路断言你实际报告的症状，而不是附近的某个失败。
- 假设以一份排序的、可证伪的列表出现，在测试任何一个之前展示给你。
- 调试埋点被打上标签（`[DEBUG-...]`），并在它宣布完成之前被 grep 清除掉。

## 它的位置

`diagnosing-bugs` 是一个随时可触及的独立技能——某个东西一坏你就切入它，一旦修复及其回归测试到位就切出。当真正的发现是"没有好的接缝把 bug 锁死"——问题出在代码而非 bug 上——时，它的复盘会把工作交接给 [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture)。当你不确定哪个技能契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
