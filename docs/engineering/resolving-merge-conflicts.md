Quickstart:

```bash
npx skills add mattpocock/skills --skill=resolving-merge-conflicts
```

```bash
npx skills update resolving-merge-conflicts
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/resolving-merge-conflicts)

## 它做什么

`resolving-merge-conflicts` 逐块（hunk by hunk）处理一个进行中的 git merge 或 rebase 冲突，并完成整个操作——解决、检查、提交。

它按**意图（intent）**解决，而非按文本。在触碰一个 hunk 之前，它把每一侧追溯回它的**主要来源（primary source）**——提交信息、PR、原始 issue——以理解这个改动为何而做，然后在两个意图兼容的地方保留两者。它绝不发明新行为来糊弄一个冲突，也绝不伸手去用 `--abort`：merge 总会被完成。

## 何时使用它

输入 `/resolving-merge-conflicts`，或者当任务契合时智能体会自动触及它。

当你正处在 merge 或 rebase 中途、git 因它自己无法解决的冲突而停下时，触及它。它是为你面前的那个冲突而设——不是为规划 merge，也不是为调试之后坏掉的行为。如果 merge 已经完成，但某个东西现在因你看不出的原因失败了，改用 [diagnosing-bugs](https://aihero.dev/skills-diagnosing-bugs)。

## Resolving by intent

冲突的陷阱在于把它当作一个文本问题——挑"ours"或"theirs"让标记消失。这个技能把它当作一个**意图**问题。一个 hunk 的每一侧之所以存在，是因为有人想要某个东西；解决办法必须在它能做到的地方尊重双方的想要，而在它们真正不兼容的地方，挑那个契合 merge 既定目标的，并大声记下这个权衡。

这就是为什么主要来源很重要。你无法保留一个你没读过的意图，所以工作从历史开始——提交、PR、工单——而不是从 diff 开始。

## 它生效的标志

- 每个解决的 hunk 都保留双方的行为，或在它做不到的地方点明权衡。
- 没有既不在这个分支也不在那个分支上的新行为出现。
- 项目自己的检查——类型检查、测试、格式化——被找到并在提交前跑绿。
- merge 或 rebase 被一路推进到一个完成的提交，从不中止。

## 它的位置

一个随时可触及的独立技能：你在一个 merge 或 rebase 停滞的那一刻调用它，它交还给你一棵干净、已提交的树。它天然的邻居是 [diagnosing-bugs](https://aihero.dev/skills-diagnosing-bugs)，因为一个干净解决却随后出问题的 merge 是一个诊断问题，而非冲突问题。当你不确定哪个技能契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
