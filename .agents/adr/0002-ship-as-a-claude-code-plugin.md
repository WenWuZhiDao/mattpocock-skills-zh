# 将技能集作为原生 Claude Code 插件发布；暂缓原生 Codex 插件

这些技能一直都可以通过 [skills.sh](https://skills.sh/mattpocock/skills)（`npx skills add mattpocock/skills`）安装，它会把可编辑的技能文件复制到用户的项目中，覆盖 Claude Code、Codex 以及其他遵循 Agent-Skills 标准的载体。一个反复出现的请求是**即插即用**的分发方式：把整套技能作为一个只读、始终保持最新的捆绑包来订阅，而不是自己拥有并维护一份分叉。这恰恰是原生插件系统所提供的能力。

我们发布一个原生 **Claude Code 插件**，并且目前**暂缓**原生 **Codex 插件**。这一取舍是被迫的，源于每个生态的插件清单如何选择技能，与本仓库分桶式的目录布局之间的矛盾。

## 约束：分桶式技能 vs. 单路径选择

技能存放在 `skills/` 下的分桶文件夹中——`engineering/` 和 `productivity/` 是**已提升**（会发布）的；`misc/`、`personal/`、`in-progress/` 和 `deprecated/` 则**不是**。插件必须只暴露已提升的那一组，而这组技能横跨其中两个分桶文件夹。

- **Claude Code** —— `.claude-plugin/plugin.json` 接受 `skills` 作为**显式技能目录路径的数组**。我们把已提升的技能逐个列出，毫无歧义地排除其他一切，并加入 `.claude-plugin/marketplace.json`，让仓库自身成为一个单插件市场。已端到端验证：`claude plugin validate . --strict` 通过，且 `marketplace add` → `install` 能解析出所有已提升的技能。

- **Codex** —— `.codex-plugin/plugin.json` 只接受 `skills` 作为**单个路径字符串**（数组会被以 `missing or invalid plugin.json` 拒绝），而 Codex 会在该路径下递归发现 `SKILL.md` 文件。没有办法从一个路径命名两个分桶文件夹，也无法从中筛选出一个子集。我们测试并否决了两种变通方案：
  - 指向 `./skills/` 会连带发布 `deprecated/`、`in-progress/`、`personal/` 和 `misc/`——那些我们刻意不提升的已退休、草稿和个人技能。
  - 指向分桶内的**符号链接**构成的扁平目录无法在安装后保留：Codex 会把插件目录树复制进它的缓存并**丢弃符号链接**，于是这些技能安装后是空的。

给 Codex 提供一个只含已提升技能的单一路径，唯一稳健的做法是：(a) **重构**目录，让 `skills/` 只包含已提升的技能（把未提升的分桶移出去——这会波及很大范围，涉及 `CLAUDE.md`、`scripts/link-skills.sh`、各分桶的 README，以及依赖 `in-progress/` 和 `personal/` 的本地开发流程），或 (b) 在一个扁平目录里**提交已提升技能的重复副本**（这带来同步负担，并造成第二个事实来源）。两者都是结构性决策，不该被塞进发布 Claude 插件这件事里。这很可能就是之前一直没有发布插件、如今已模糊记不清的原始原因：清单格式无法干净地表达一个分桶式仓库中经过筛选的子集。

## 决策

- **现在**就发布 **Claude Code 插件**（`.claude-plugin/plugin.json` + `.claude-plugin/marketplace.json`），筛选为已提升的那一组，作为 v1.2 的头号交付物。
- 保留 **skills.sh** 作为通用安装器——它如今已服务于 Codex 和其他载体，因此没有任何 Codex 用户会失去安装途径。
- **暂缓**原生 Codex 插件，直到我们在「把 `skills/` 重构为只含已提升技能」与「提交一份生成的扁平副本」之间做出抉择。等 Codex 要么支持 `skills` 数组／包含列表，要么在安装时保留符号链接时，再重新审视。

## 这带来的不变量

- 每个已提升的技能在 `.claude-plugin/plugin.json` 的 `skills` 数组中都有一条对应条目（这原本就是一条 `CLAUDE.md` 规则；现在它还约束了插件的内容）。
- `.claude-plugin/plugin.json` 的 `version` 跟随 `package.json` 的版本——发布时两者一起升。Claude 用插件的 `version` 来决定已安装用户何时看到更新。

## 更新，2026-08-05

`mattpocock-skills` 已被接纳进 **Claude Code 的官方市场**——配置名为 `claude-plugins-official`，源仓库为 `anthropics/claude-plugins-official`——每个 Claude Code 安装默认都带有这个市场。`claude plugins install mattpocock-skills` 现在是官方文档中的途径，上文的 `marketplace add` → `install` 路径已被取代。安装文案见 [.agents/install-block.md](../install-block.md)。

官方列表指向本仓库的 git URL，并直接读取 `.claude-plugin/plugin.json`，因此不依赖 `.claude-plugin/marketplace.json`。保留该文件只是作为直接安装本仓库（某个未发布的提交，或一个分叉）的后备方案。

于 2026-08-05，在 Claude Code 2.1.222 上，针对线上列表验证：

- `claude plugins install mattpocock-skills` 无需先添加市场即可解析，并报告 `mattpocock-skills@claude-plugins-official`。
- `claude plugin details mattpocock-skills` 随后报告版本 1.2.0 并加载已提升的技能。
- 该列表的 `source` 是 `{"source": "url", "url": "https://github.com/mattpocock/skills.git", "sha": …}`——**sha 是被固定的**，因此当那个固定值移动时，而非我们打标签的那一刻，一个发布才会到达已安装用户。写作本文时该固定值落后 `main` 两个提交，这就是它列出 22 个技能而非 `plugin.json` 中 24 个的原因。
- 会话内的 `/plugin install mattpocock-skills` **未被**验证——`/plugin` 在无头（`claude -p`）会话中不可用。它运行与 CLI 相同的解析器，官方文档中的示例形式为 `/plugin install <name>@claude-plugins-official`。
