## 它做什么

`wait-what` 是当一条消息没能领会时你要输入的东西。[智能体（agent）](https://www.aihero.dev/ai-coding-dictionary/agent)随后会重新表述它刚刚说过的话。它补上你缺失的上下文，用平实的英语书写，并使用来自你项目 `CONTEXT.md` 的词汇。

这个技能只有三行长。这是设计，而非一份未完成的草稿。那些对抗啰嗦的技能是靠增长来失败的：一个四百行的简洁技能仍然会让[模型（model）](https://www.aihero.dev/ai-coding-dictionary/model)啰嗦，因为模型读的是篇幅，而非那份恳求。这一个只承载一个精确的引导词，别无其他。

## 何时使用它

你通过输入 `/wait-what` 来调用它。智能体不会自行使用它，也不该。只有你知道自己何时跟不上了。

在你注意到自己开始略读的那一秒就用它。智能体飘进了它自己发明的行话、堆了五个缩写词，或者解释了一个你从没见过其前提的决定。它修复的是你已经身处其中的这场对话。要从一开始就阻止行话到来，请用 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)，它在前期就建立起共享语言。

## 名字就是机制

那个引导词是 **wait**（等等）。「简洁点」是一条关于智能体*输出*的指令，模型服从它的方式是砍词，把你甩得更远。**Wait** 关乎的是*你的*状态。它说：理解在这里失败了。一个听到「简短点」的智能体会写电报。一个听到「等等，你把我说懵了」的智能体会退回去解释。

那个差别就是这整个技能。每一个流行的对抗啰嗦的办法都点名*输出*：`/tldr`、`/no-fluff`、`/talk-normal`。模型过度矫正成一种更短、也并不更清楚的原始人腔调。点名*听者*则一次性索要两半：更少的字**以及**你缺失的那份上下文。

这个技能说重新表述**那个**，而不是「那最后一条消息」。让你懵掉的东西通常比一个段落更大，所以由智能体决定要往回退多远。

## 它接入你已有的语言

它的正文复用你全局 `CLAUDE.md` 和你项目 `CONTEXT.md` 里已有的引导词。ASD-STE100 简化技术英语设定语域。通用语言（ubiquitous language）供给名词。这个技能、`CLAUDE.md` 和 `CONTEXT.md` 都伸手去取同样的[词元（tokens）](https://www.aihero.dev/ai-coding-dictionary/token)，所以调用它不是一条新指令。它是对一条智能体早已同意的指令的提醒。

如果你没有 `CONTEXT.md`，这个技能仍然管用。你只是损失了领域词汇那一半。

## 它生效的标志

- 重新表述后是**更短且更清楚**，而不是更短且更生硬。
- 它补上你缺失的前提，而不是只删词。
- 项目里的名词取代了被发明的名词。你 `CONTEXT.md` 里的术语回来了。
- 你能连用它两次，而它不会退化成简短生硬。

## 它的位置

你可以在任何时刻、任何对话、任何其他技能内部使用 `wait-what`。它在事后修复一条消息。真正的解药是在前期就商定好的共享语言，而那就是 [grill-with-docs](https://aihero.dev/skills-grill-with-docs)：一场一路运行 [domain-modeling](https://aihero.dev/skills-domain-modeling) 的[拷问（grilling）](https://www.aihero.dev/ai-coding-dictionary/grilling)会话，好让你们两方都用的词落进你的 `CONTEXT.md`。如果你不确定此刻哪个技能合适，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你导航。
