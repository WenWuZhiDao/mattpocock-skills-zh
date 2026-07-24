# 以原生 Claude Code 插件形式发布这套技能；暂缓原生 Codex 插件

这些技能一直可以通过 [skills.sh](https://skills.sh/mattpocock/skills)（`npx skills add mattpocock/skills`）安装，它会把可编辑的技能文件复制到用户项目中，覆盖 Claude Code、Codex 以及其他符合 Agent-Skills 标准的框架。一个反复出现的诉求是**即插即用**的分发方式：把这套技能作为一个只读、始终保持最新的捆绑包来订阅，而不是拥有一个自己维护的分叉。这正是原生插件系统所提供的。

我们发布了一个原生 **Claude Code 插件**，同时**暂缓**原生 **Codex 插件**。这一取舍是由两个生态各自的插件清单如何选择技能、以及本仓库的分桶布局共同决定的。

## 约束：分桶技能 vs. 单路径选择

技能存放在 `skills/` 下的分桶文件夹中——`engineering/` 和 `productivity/` 是**已推广**（会发布）的；`misc/`、`personal/`、`in-progress/` 和 `deprecated/` 则**不是**。插件必须只暴露已推广的那部分，而这部分横跨其中两个分桶文件夹。

- **Claude Code**——`.claude-plugin/plugin.json` 接受 `skills` 作为一个**由显式技能目录路径组成的数组**。我们把已推广的技能逐个列出，毫不含糊地排除其余一切，并添加 `.claude-plugin/marketplace.json`，让本仓库成为它自己的单插件市场。已端到端验证：`claude plugin validate . --strict` 通过，`marketplace add` → `install` 能解析出所有已推广的技能。

- **Codex**——`.codex-plugin/plugin.json` 只接受 `skills` 作为**单个路径字符串**（数组会被拒绝，报 `missing or invalid plugin.json`），Codex 会在该路径下递归发现 `SKILL.md` 文件。没有办法从一个路径同时命名两个分桶文件夹，或者只挑选一个子集。我们测试并否决了两条变通路线：
  - 指向 `./skills/` 会连带发布 `deprecated/`、`in-progress/`、`personal/` 和 `misc/`——这些是我们刻意不推广的退役、草稿和个人技能。
  - 用一个由指向各分桶的**符号链接**组成的精选扁平目录，在安装时无法保留：Codex 会把插件目录树复制进它的缓存并**丢弃符号链接**，于是这些技能安装后是空的。

要给 Codex 提供一个仅含已推广技能的单一路径，唯一稳健的做法是：(a) **重构**，让 `skills/` 只包含已推广的技能（把未推广的分桶移出去——这会波及 `CLAUDE.md`、`scripts/link-skills.sh`、各分桶 README，以及依赖 `in-progress/` 和 `personal/` 的本地开发工作流，影响面很大），或者 (b) **提交已推广技能的重复副本**到一个扁平目录（既是同步负担，又制造了第二个事实来源）。两者都是结构性决策，不该被打包进"发布 Claude 插件"这件事里。这很可能就是之前没有发布插件的、被淡忘了的原始原因：清单格式无法干净地表达一个分桶仓库的精选子集。

## 决策

- **现在**发布 **Claude Code 插件**（`.claude-plugin/plugin.json` + `.claude-plugin/marketplace.json`），精选到已推广的那部分，作为 v1.2 的重点交付物。
- 保留 **skills.sh** 作为通用安装器——它如今已经服务于 Codex 及其他框架，因此没有哪个 Codex 用户会缺少安装途径。
- **暂缓**原生 Codex 插件，直到我们在"把 `skills/` 重构为仅含已推广技能" vs. "提交一份生成的扁平副本"之间做出取舍。等到 Codex 要么支持 `skills` 数组／包含列表，要么在安装时保留符号链接时，再重新审视。

## 由此确立的不变量

- 每个已推广技能在 `.claude-plugin/plugin.json` 的 `skills` 数组中都有一个条目（这原本已是一条 `CLAUDE.md` 规则；现在它同时把关插件的内容）。
- `.claude-plugin/plugin.json` 的 `version` 跟随 `package.json` 的版本——发布时两者一起升级。Claude 用插件的 `version` 来决定何时让已安装用户看到更新。
