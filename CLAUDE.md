技能被组织到 `skills/` 下的 bucket 文件夹中：

- `engineering/` —— 日常代码工作
- `productivity/` —— 日常非代码工作流工具
- `misc/` —— 保留但很少使用，不做推广
- `personal/` —— 与我自己的配置绑定，不做推广
- `in-progress/` —— 尚未准备好发布的草稿
- `deprecated/` —— 不再使用

`engineering/` 或 `productivity/`（即**推广（promoted）**的 bucket）中的每个技能都必须在顶层 `README.md` 中有引用，并在 `.claude-plugin/plugin.json` 中有条目。`misc/`、`personal/`、`in-progress/` 和 `deprecated/` 中的技能不得出现在其中任何一处。

顶层 `README.md` 中的每个技能条目都必须把技能名称链接到它的 `SKILL.md`。

每个 bucket 文件夹都有一个 `README.md`，用一行描述列出该 bucket 中的每个技能，并把技能名称链接到它的 `SKILL.md`。推广 bucket 的 `README.md` 以及顶层 `README.md` 会把条目分组为**用户调用（User-invoked）**和**模型调用（Model-invoked）**；非推广 bucket 的 `README.md`（`misc/`、`personal/`）使用扁平列表。

`engineering/` 和 `productivity/` 中的技能还在 `docs/<bucket>/<skill-name>.md` 有一个面向人的文档页面（文档树镜像 `skills/` 下的这两个 bucket 文件夹）。无论属于哪个 bucket，发布的 URL 都是 `https://aihero.dev/skills-<skill-name>`——文档路径只是仓库组织方式。当你在 `engineering/` 或 `productivity/` 中添加、重命名或改动某个技能的行为时，请遵循 [.agents/writing-docs.md](./.agents/writing-docs.md) 创建或重新同步它的文档页面。非推广 bucket（`misc/`、`personal/`、`in-progress/`、`deprecated/`）中的技能**不**设文档页面。

每个 `SKILL.md` 要么是用户调用的（`disable-model-invocation: true`，只有人能触及），要么是模型调用的（模型或用户均可触及）。参见 [.agents/invocation.md](./.agents/invocation.md)。

[`ask-matt`](./skills/engineering/ask-matt/SKILL.md) 是把每个用户可触及技能及其相互关系映射起来的路由器。触发文档页面重新同步的同一规则也适用于它：每当你添加、重命名、移除或改动某个用户可触及技能如何融入这些流程时，重新阅读 `ask-matt` 的 `SKILL.md` 并更新它，使这张图保持准确——一个它从未提及的新技能，或者一个它仍在路由但已过时的技能，就是一个说谎的路由器。

要（重新）把每个技能链接进本地 harness 的技能目录（`~/.claude/skills`、`~/.agents/skills`），运行 `scripts/link-skills.sh`。每个条目都是指向本仓库的符号链接，因此 `git pull` 就能让已安装的技能保持最新；在添加、移除或重命名技能后重新运行该脚本。
