Quickstart:

```bash
npx skills add mattpocock/skills --skill=handoff
```

```bash
npx skills update handoff
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/productivity/handoff)

## 它做什么

`handoff` 把当前对话压缩成一份**交接文档（handoff document）**——一份写就的东西，让一个全新的智能体可以读它、从你离开的地方接手工作。

它**不**重述已经存在于别处的内容。任何被 PRD、计划、ADR、issue、提交或 diff 捕捉过的东西，都以路径或 URL 引用，绝不复制。这份文档只承载活跃的线索——你在做什么、为什么、接下来做什么——并且它被保存到你操作系统的临时目录，而非工作区，因此它绝不会变成又一个要维护的产物。

## 何时使用它

你通过输入 `/handoff` 来调用它——智能体不会自行触及它。传入一条关于下一个会话目的的说明，文档就会为它量身定制。

当一次对话长到它的上下文有风险时触及它——你接近上下文上限、准备收工，或刻意把工作交给另一个智能体——而你想在不拖着整份文字记录的情况下保存那条线索。

## What the document carries

- **活跃的线索**—— 什么在进行中、为什么，用对话自己的措辞，减去任何已经写在别处的东西。
- **建议的技能**—— 一个指向下一个智能体应该触及以继续的技能的指针。
- **引用，而非复制**—— 指向那些持有已敲定细节的 PRD、计划、ADR、issue 和 diff 的链接和路径。
- **脱敏的机密**—— API 密钥、密码和 PII 在文档写就前被剥离。

要抓住的理念是**压缩（compaction）**：一份交接是被挤压到只剩其可续接内核的对话，因此一个全新的智能体继承的是势头，而非噪音。

## 它的位置

`handoff` 是一个随时可触及的独立技能——它位于两个会话之间的接缝处，而非某条构建链之内。它天然地与那些产出产物的技能配对，它指向它们的输出：[to-prd](https://aihero.dev/skills-to-prd)，因为一份完成的 PRD 正是一份交接会去引用而非重复的那种已敲定细节。当你不确定此刻哪个技能契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
