技能（skills）按照 `skills/` 目录下的分组文件夹进行组织：

- `engineering/` — 日常代码工作
- `productivity/` — 日常非代码的工作流工具
- `misc/` — 保留但很少使用
- `personal/` — 与我自己的环境绑定，不对外推广
- `in-progress/` — 尚未准备好发布的草稿
- `deprecated/` — 不再使用

`engineering/`、`productivity/` 或 `misc/` 中的每个技能都必须在顶层 `README.md` 中有引用，并在 `.claude-plugin/plugin.json` 中有对应条目。`personal/`、`in-progress/` 和 `deprecated/` 中的技能不得出现在这两处。

顶层 `README.md` 中的每个技能条目都必须将技能名称链接到其 `SKILL.md`。

每个分组文件夹都有一个 `README.md`，列出该分组中的每个技能并附带一行描述，技能名称链接到其 `SKILL.md`。
