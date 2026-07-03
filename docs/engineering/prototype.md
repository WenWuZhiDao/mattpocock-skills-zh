Quickstart:

```bash
npx skills add mattpocock/skills --skill=prototype
```

```bash
npx skills update prototype
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/prototype)

## 它做什么

`prototype` 构建一个小小的、可丢弃的程序，它唯一的职责是回答一个设计问题——这个状态模型感觉对吗，或者这个 UI 应该长什么样。

代码**从第一天起就是一次性的**，并且被如此标记。它不带测试、不带超出让它跑起来所需的错误处理、不带抽象、不带持久化。重点是快速学到某个东西然后删掉它——所以你一开始加固它的那一刻，你就已经不在做原型了。

## 何时使用它

输入 `/prototype`，或者当任务契合时智能体会自动触及它。

当你有一个在纸上难以敲定的设计问题时触及它——一个案例多到你脑子装不下的状态机，或一个不看几个版本并排就想象不出来的屏幕。如果反过来，某个已经构建好的东西在出问题，你需要找出为什么，用 [diagnosing-bugs](https://aihero.dev/skills-diagnosing-bugs)；原型探索的是要构建什么，而不是已构建之物为何坏了。

## Two branches

问题决定形态，而形态有两种：

- **"这个逻辑 / 状态模型感觉对吗？"**—— 一个微小的交互式终端应用，把状态机推过那些别扭的案例，在每个动作后打印完整状态，让你看清什么在变。
- **"这个应该长什么样？"**—— 在一个路由上放若干个截然不同的 UI 变体，可从一个浮动栏切换，让你比较真实渲染而不是去想象它们。

选错分支会浪费整个原型，所以问题先行。两个分支都把状态保存在内存中，从一个命令运行，并在每一步呈现完整状态。

## The answer is the artifact

代码是可丢弃的；**答案**才是唯一值得留下的东西。当原型解决了它的问题时，把结论捕捉到某个持久的地方——一条提交信息、一份 ADR、一个 issue，或它旁边的一个 `NOTES.md`——连同它所回答的问题，然后删除或吸收那些代码。一个烂在仓库里的原型已经活过了它的用处。

## 它的位置

`prototype` 是一个随时可触及的独立技能：你切入它去解决一个设计问题，然后再切出来。它的答案常常喂给下一步——一个经过验证的状态模型或 UI 方向成为 [to-prd](https://aihero.dev/skills-to-prd) 写下来的稳定输入，或一个值得通过 [domain-modeling](https://aihero.dev/skills-domain-modeling) 记录的架构决策。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
