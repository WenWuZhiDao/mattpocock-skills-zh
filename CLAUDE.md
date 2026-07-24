技能被组织到 `skills/` 下的分桶文件夹中：

- `engineering/`——日常代码工作
- `productivity/`——日常非代码工作流工具
- `misc/`——保留但很少使用，不推广
- `personal/`——绑定我自己的设置，不推广
- `in-progress/`——尚未准备好发布的草稿
- `deprecated/`——不再使用

`engineering/` 或 `productivity/`（**已推广**的桶）中的每个技能，都必须在顶层 `README.md` 中有一处引用，并在 `.claude-plugin/plugin.json` 的 `skills` 数组中有一个条目（Claude Code 插件恰好发布这套已推广的技能）。`misc/`、`personal/`、`in-progress/` 和 `deprecated/` 中的技能不得出现在两者中的任何一个里。

本仓库同时也是它自己的单插件 Claude Code 市场：`.claude-plugin/marketplace.json` 列出唯一的 `mattpocock-skills` 插件。升级发布版本时，要让 `.claude-plugin/plugin.json` 的 `version` 与 `package.json` 的保持同步——Claude 用插件的 `version` 来决定何时让已安装用户看到更新。改动任一清单后运行 `claude plugin validate . --strict`。为什么有 Claude 插件却（暂时）没有 Codex 插件，其原因见 [.agents/adr/0002-ship-as-a-claude-code-plugin.md](./.agents/adr/0002-ship-as-a-claude-code-plugin.md)。

顶层 `README.md` 中的每个技能条目都必须把技能名链接到它的 `SKILL.md`。

每个分桶文件夹都有一个 `README.md`，列出该桶中的每个技能并附一行描述，技能名链接到它的 `SKILL.md`。已推广桶的 `README.md` 和顶层 `README.md` 把条目分组为**用户调用型**和**模型调用型**；未推广桶的 `README.md`（`misc/`、`personal/`）使用扁平列表。

`engineering/` 和 `productivity/` 中的技能还有一个面向人的文档页，位于 `docs/<bucket>/<skill-name>.md`（文档树镜像了 `skills/` 下的这两个分桶文件夹）。发布的 URL 无论属于哪个桶都是 `https://aihero.dev/skills-<skill-name>`——文档路径纯粹是仓库组织方式。当你在 `engineering/` 或 `productivity/` 中添加、重命名或改变一个技能的行为时，按照 [.agents/writing-docs.md](./.agents/writing-docs.md) 创建或重新同步它的文档页。未推广桶（`misc/`、`personal/`、`in-progress/`、`deprecated/`）中的技能**不获得**文档页。

每个 `SKILL.md` 要么是用户调用型（`disable-model-invocation: true` 加上 `agents/openai.yaml` 中的 `policy.allow_implicit_invocation: false`，只能由人触达），要么是模型调用型（模型或用户均可触达）。见 [.agents/invocation.md](./.agents/invocation.md)。

[`ask-matt`](./skills/engineering/ask-matt/SKILL.md) 是那个路由器，它映射每一个用户可触达的技能以及它们之间的关系。与重新同步文档页相同的触发条件在此同样适用：每当你添加、重命名、移除，或改变一个用户可触达技能如何契合各流程时，重新阅读 `ask-matt` 的 `SKILL.md` 并更新它，让这张地图保持准确——一个它从未提及的新技能，或一个它仍在路由的陈旧技能，都是一个会说谎的路由器。

要把每个技能（重新）链接进本地框架的技能目录（`~/.claude/skills`、`~/.agents/skills`），运行 `scripts/link-skills.sh`。每个条目都是指向本仓库的符号链接，因此一次 `git pull` 就能让已安装的技能保持最新；在添加、移除或重命名技能后重新运行该脚本。
