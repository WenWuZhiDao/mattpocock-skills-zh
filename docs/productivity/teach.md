Quickstart:

```bash
npx skills add mattpocock/skills --skill=teach
```

```bash
npx skills update teach
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/productivity/teach)

## 它做什么

`teach` 把当前目录变成一个常驻的教学工作区，并跨许多个会话教会你一个主题——设计出短小、优美、交互式的课程，紧扣你_为什么_想学。

它**不**从模型自己的记忆里教。参数化知识被当作不可信；在它能教之前，它收集高可信度的资源，并把每个论断都锚定到一处引用。而且它是有状态的——工作区记住你学过什么，因此每个会话从上一次离开的地方接续，而不是从头开始。

## 何时使用它

你通过输入 `/teach` 来调用它——智能体不会自行触及它。

当你想随着时间_学习_一个主题时触及它——一门语言、一个框架、瑜伽、理论物理——并想让这些会话累积而不是蒸发。它不是为了一次性的讲解；如果你只需要当下澄清某个东西，直接问。当学习本身是一个项目时，触及 `teach`。

## 前置条件

`teach` 就地构建一整个目录，所以在一个你乐意保留为专用工作区的地方运行它。随着时间它会写：

- `MISSION.md` —— 你学这个的理由，它为其余一切奠基。如果它是空的，`teach` 的第一件事就是盘问你直到它不再为空。
- `RESOURCES.md` —— 它据以教学的、经过审核的高可信度来源。
- `./lessons/*.html` —— 编号的、自包含的课程（教学的主要单元）。
- `./reference/*.html` —— 你会回头看的压缩速查表、算法、术语表。
- `./learning-records/*.md` —— 你学过什么，ADR 风格，用来判断接下来教什么。
- `./assets/*` —— 可复用组件（先是一个共享样式表），好让课程看起来像同一门课。
- `NOTES.md` —— 你的教学偏好。

## Mission, and the zone of proximal development

每一节课都挂在**使命（mission）**上。没有它，知识就没有可依附之处，课程感觉抽象——所以使命是 `teach` 最先敲定的东西，并随着你的成长不断更新。从使命和你的学习记录，它计算出你的**最近发展区（zone of proximal development）**：下一节课应该_恰到好处_地挑战你，不多不少。

## Storage strength, not fluency

要用来思考的词是**存储强度（storage strength）**——长期保持——与之相对的是**流畅度（fluency）**，即当下那种感觉像是精通却并非如此的即时回忆。`teach` 刻意通过合意困难（desirable difficulty）来构建前者：提取练习、间隔、交错。知识先被教授（困难在此是敌人），然后技能通过一个紧的反馈回路被操练（困难在此是工具）。

## 它的位置

`teach` 是一个随时可触及的独立技能——一个你逐个会话驱动的长期学习项目，而非某条构建链中的步骤。它不与其他生产力技能共享工作流；它只是拥有它的工作区目录并住在那里。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
