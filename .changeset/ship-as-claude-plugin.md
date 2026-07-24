---
"mattpocock-skills": minor
---

以原生 **Claude Code 插件**的形式发布这套技能。本仓库现在是它自己的单插件市场，因此你可以把已推广的技能作为一个受管理的、只读的捆绑包来订阅，而不必复制可编辑的文件：

```
/plugin marketplace add mattpocock/skills
/plugin install mattpocock-skills@mattpocock
```

`.claude-plugin/plugin.json` 增加了完整的市场元数据（version、description、author、license、keywords），并有一个同级的 `.claude-plugin/marketplace.json` 列出该插件。`skills.sh` 仍然是通用安装器（也是如今 Codex 及其他框架的安装途径）；原生 Codex 插件被暂缓——原因见 `.agents/adr/0002-ship-as-a-claude-code-plugin.md`。
