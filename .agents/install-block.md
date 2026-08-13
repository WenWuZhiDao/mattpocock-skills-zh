# 标准安装文案块

只有一套安装说法，一种措辞。`README.md`、`.changeset/*`，以及 `docs/` 下的每个页面都必须说**这一套**，别无其他。要改就先在这里改，然后再传播出去。

`mattpocock-skills` 列在 **Claude Code 的官方市场**中——配置名为 `claude-plugins-official`，源仓库为 `anthropics/claude-plugins-official`——每个 Claude Code 安装开箱即带这个市场。无需先添加任何市场。官方 Anthropic 市场默认启用自动更新（[discover-plugins](https://code.claude.com/docs/en/discover-plugins)），所以「更新会自动到达」是一个真实的断言，而非一厢情愿。

## Claude Code —— 插件

<canonical-block name="claude-code">

```bash
claude plugins install mattpocock-skills
```

或者，在会话内：

```
/plugin install mattpocock-skills
```

它在 Claude Code 的官方市场里，所以无需先添加任何东西，更新也会自动到达。

</canonical-block>

## Codex 及其他智能体 —— skills.sh

该插件仅限 Claude Code。在其他任何地方，[skills.sh](https://skills.sh/mattpocock/skills) 会把可编辑的技能文件复制进项目。在 `README.md` 上使用整套形式：

<canonical-block name="skills-sh-whole-set">

```bash
npx skills@latest add mattpocock/skills
```

挑选你想要的技能，以及要在哪些编码智能体上安装它们。**安装器让你选择要拿哪些技能——确保 `setup-matt-pocock-skills` 是其中之一。**

</canonical-block>

……以及在单独提到某一个技能的任何地方使用单技能形式。注意 **`docs/` 页面不是这个文案块的消费者**：ai-hero 会在正文上方渲染安装小组件，因此一个把命令写出来的页面会重复它。见 [writing-docs.md](./writing-docs.md)。

<canonical-block name="skills-sh-one-skill">

```bash
npx skills@latest add mattpocock/skills --skill=<name>
```

```bash
npx skills@latest update <name>
```

</canonical-block>

`skills@latest` 是这三处中固定的写法。`docs/` 下的页面过去带有它们自己的这些命令副本；那些块现在被删除而非修正，因为站点会自行渲染安装命令。

## 两条途径互斥

插件是一个受管、只读、供你订阅的捆绑包。skills.sh 写入的是你拥有并编辑的文件。两个都装会让用户拥有每个技能各两份——一定要说「二选一」。

## 不是安装说法

`.claude-plugin/marketplace.json` 让仓库自身成为一个单插件市场（`/plugin marketplace add mattpocock/skills`，然后 `/plugin install mattpocock-skills@mattpocock`）。官方列表取代了它。它作为直接安装本仓库——某个未发布的提交，或一个分叉——的后备方案被保留，并且**不**对用户公开文档。
