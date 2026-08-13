# 生产力（Productivity）

通用工作流工具，不针对代码。

## 用户调用型

仅在你输入它们时可触达（Claude Code：`disable-model-invocation: true`；Codex：在 `agents/openai.yaml` 中 `policy.allow_implicit_invocation: false`）。

- **[grill-me](./grill-me/SKILL.md)** —— 就一个计划或设计接受不留情面的访谈，直到决策树的每一条分支都被解决。
- **[handoff](./handoff/SKILL.md)** —— 把当前对话压缩成一份交接文档，好让另一个智能体接续工作。
- **[teach](./teach/SKILL.md)** —— 跨越多个会话教用户一项新技能或概念，把当前目录用作一个有状态的教学工作区。
- **[to-questionnaire](./to-questionnaire/SKILL.md)** —— 把一个你无法独自回答的决定，变成一份给那个唯一能回答的人的 Markdown 问卷——异步填写，或在一次会议上一起完成。
- **[wait-what](./wait-what/SKILL.md)** —— 在一条消息没能领会的那一刻触发它。智能体会补上你缺失的上下文重新表述它，用平实的英语，并使用你 `CONTEXT.md` 里的词汇。

## 模型调用型

模型或用户均可触达（丰富的触发措辞，好让模型能伸手取用它们）。

- **[grilling](./grilling/SKILL.md)** —— 就一个计划、决定或想法不留情面地访谈用户，直到决策树的每一条分支都被解决。
- **[writing-for-agents](./writing-for-agents/SKILL.md)** —— 为智能体撰写文档：技能、AGENTS.md/CLAUDE.md，以及任何智能体通过指针取用的文档。
