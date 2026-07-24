# 生产力（Productivity）

通用的工作流工具，与代码无关。

## 用户调用型

只有你输入它们时才可达（Claude Code：`disable-model-invocation: true`；Codex：`agents/openai.yaml` 中的 `policy.allow_implicit_invocation: false`）。

- **[grill-me](./grill-me/SKILL.md)** — 就一个计划或设计接受不留情面的访谈，直到决策树的每个分支都被解决。
- **[handoff](./handoff/SKILL.md)** — 把当前对话压缩成一份交接文档，让另一个 agent 能接着做下去。
- **[teach](./teach/SKILL.md)** — 通过多次会话向用户传授一项新技能或新概念，以当前目录作为有状态的教学工作区。
- **[writing-great-skills](./writing-great-skills/SKILL.md)** — 关于如何写好、改好技能的参考：那些让技能变得可预测的词汇与原则。

## 模型调用型

模型或用户皆可达（丰富的触发措辞，好让模型能够触及它们）。

- **[grilling](./grilling/SKILL.md)** — 就一个计划、决策或想法不留情面地拷问用户，直到决策树的每个分支都被解决。
