# 进行中

Beta 阶段。这些技能是有意公开的——试用它们，并告诉我哪里出了问题。在它们晋级到稳定桶之前，它们被排除在插件和顶层 README 之外，没有文档页，并且可能在没有预警的情况下变更或消失。

插件不会提供这些技能。请直接单独安装：

```bash
npx skills@latest add mattpocock/skills --skill=<name>
```

- **[loop-me](./loop-me/SKILL.md)** — 通过多个会话把自己拷问成可实现的工作流规格，把当前目录当作有状态的工作区。用户调用。
- **[writing-beats](./writing-beats/SKILL.md)** — 以「节拍」之旅的方式塑造一篇文章，采用「选择你自己的冒险」的风格。挑一个起始节拍，只写这个节拍，然后转向下一个，直到文章走向自然的结尾。
- **[writing-fragments](./writing-fragments/SKILL.md)** — 一场拷问式会话，从你身上挖掘出「片段」——异质的写作小金块——并把它们追加到一份单一文档中，作为未来某篇文章的原材料。
- **[writing-shape](./writing-shape/SKILL.md)** — 拿一个装满原材料的 markdown 文件，逐段把它塑造成一篇文章，并在每一步论证格式选择。
- **[claude-handoff](./claude-handoff/SKILL.md)** — 把当前对话移交给一个全新的后台 agent，它会立即接手工作，通过 `claude --bg` 用一份移交摘要作为种子。用户调用。
- **[setup-ts-deep-modules](./setup-ts-deep-modules/SKILL.md)** — 把 dependency-cruiser 接入 TypeScript 仓库，使每个包都成为一个深模块——实现隐藏在子文件夹中，只能通过其入口文件访问，测试也通过这些入口来运行它。用户调用。
