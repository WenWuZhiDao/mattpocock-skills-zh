技能按桶（bucket）文件夹组织，位于 `skills/` 之下：

- `engineering/` —— 日常代码工作
- `productivity/` —— 日常非代码工作流工具
- `misc/` —— 保留但很少使用，不作推广
- `in-progress/` —— 测试版：有意公开，欢迎反馈，尚未随插件发布
- `deprecated/` —— 不再使用

`engineering/` 或 `productivity/`（即**推广**桶）中的每个技能都必须在顶层 `README.md` 中有引用，并在 `.claude-plugin/plugin.json` 的 `skills` 数组中有一条对应条目（Claude Code 插件恰好发布这套推广技能集）。`misc/`、`in-progress/` 和 `deprecated/` 中的技能不得出现在两者中的任何一处。

安装命令逐字复制自 [.agents/install-block.md](./.agents/install-block.md)。`.claude-plugin/marketplace.json` 使本仓库成为其自身的单插件市场 —— 这是安装说明块所解释的一种兜底方案，而非文档中记录的主推路径。改动任一清单文件后，运行 `claude plugin validate . --strict`。为何做成 Claude 插件而（暂）未做 Codex 插件，见 [.agents/adr/0002-ship-as-a-claude-code-plugin.md](./.agents/adr/0002-ship-as-a-claude-code-plugin.md)。

顶层 `README.md` 中每条技能条目都必须将技能名链接到其 `SKILL.md`。

每个桶文件夹都有一个 `README.md`，列出该桶中的每个技能及一行描述，并将技能名链接到其 `SKILL.md`。推广桶的 `README.md` 以及顶层 `README.md` 会将条目分组为**用户调用型**与**模型调用型**；非推广桶的 `README.md`（`misc/`、`in-progress/`）则使用扁平列表。

`engineering/` 和 `productivity/` 中的技能还在 `docs/<bucket>/<skill-name>.md` 处有一个面向人类的文档页（该文档树在 `skills/` 之下镜像这两个桶文件夹）。无论属于哪个桶，其发布 URL 均为 `https://aihero.dev/skills-<skill-name>` —— 文档路径仅用于仓库组织。当你在 `engineering/` 或 `productivity/` 中新增、重命名或改变某个技能的行为时，请按照 [.agents/writing-docs.md](./.agents/writing-docs.md) 创建或重新同步其文档页。一个完成的页面包含四个部分 —— **它做什么**、**何时使用它**、**常见问题**、**它生效的标志** —— `writing-docs.md` 中提供了模板、章节顺序，以及到哪里去搜寻这些问题。非推广桶（`misc/`、`in-progress/`、`deprecated/`）中的技能**不**设文档页。

每个 `SKILL.md` 要么是用户调用型（在 `agents/openai.yaml` 中设置 `disable-model-invocation: true` 加上 `policy.allow_implicit_invocation: false`，仅人类可触达），要么是模型调用型（模型或用户均可触达）。参见 [.agents/invocation.md](./.agents/invocation.md)。

[`ask-matt`](./skills/engineering/ask-matt/SKILL.md) 是路由器，映射了每个用户可触达的技能以及它们之间的关系。适用于重新同步文档页的那条触发规则同样适用于它：每当你新增、重命名、移除某个用户可触达技能，或改变它在各流程中的定位时，重新阅读 `ask-matt` 的 `SKILL.md` 并更新它，使这张地图保持准确 —— 一个它从未提及的新技能，或一个它仍在路由的过时技能，都是一个会说谎的路由器。

要（重新）将每个技能链接进本地运行环境的技能目录（`~/.claude/skills`、`~/.agents/skills`），运行 `scripts/link-skills.sh`。每一条都是指向本仓库的符号链接，因此 `git pull` 会保持已安装技能为最新；新增、移除或重命名技能后请重新运行该脚本。
