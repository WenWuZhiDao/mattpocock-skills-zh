Quickstart:

```bash
npx skills add mattpocock/skills --skill=tdd
```

```bash
npx skills update tdd
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/engineering/tdd)

## 它做什么

`tdd` 以测试先行的方式构建一个功能或修复一个 bug，一次一个行为，通过一个红-绿回路把代码逼出来。

它**不会**在前期把所有测试都写好。把测试先批量写（"水平切片"）会产出_想象中_行为的测试——它们检查东西的形状，并对真实的改动变得麻木。`tdd` 取而代之地取垂直切片：一个测试，然后刚好够让它通过的代码，然后下一个测试，每一轮都受上一轮所教内容的启发。测试只瞄准公开接口，因此底下的实现可以改变而测试不必移动。

## 何时使用它

输入 `/tdd`，或者当任务契合时智能体会自动触及它——以测试先行的方式构建一个功能或修复一个 bug，或当你说"red-green-refactor"时。

当有一个具体的行为要构建、且你想要能挺过重构的测试时，触及它。如果行为还没敲定，先定规格——为此，用 [to-prd](https://aihero.dev/skills-to-prd)。当工作真正关乎接口的形状而非测试时，用 [codebase-design](https://aihero.dev/skills-codebase-design)；`tdd` 在规划期间会调用它以获取深模块词汇。

## Red-green, one slice at a time

领头理念是**红-绿回路**：写一个失败的测试（红），加刚好够让它通过的代码（绿），然后为下一个行为重复——每一轮都受上一轮所教内容的启发。第一轮是一颗**曳光弹（tracer bullet）**：一个证明单条路径端到端可用的测试，然后你从它向外构建。因为你刚写了代码，你确切知道哪个行为要紧、以及如何验证它——你绝不会因为一头扎进你还不理解的测试结构而开过头。

两条规则让测试保持诚实。一个好测试读起来像一份规格（"user can checkout with valid cart"），并通过公开 API 操练真实代码路径，因此重命名一个内部函数永远不会破坏它。而期望值来自一个独立的真相来源——一个已知良好的字面量、一个手算的例子、规格本身——绝不以代码计算它的相同方式重新算出，那正是一个**同义反复（tautological）**测试从构造上必然通过却什么都告诉不了你的原因。

重构只在套件变绿后才发生；从不在红着的时候。

## 它生效的标志

- 它写一个测试，让它通过，然后才写下一个——而不是一批测试后跟一批代码。
- 测试命名行为，而非内部细节，并且能挺过一次内部重命名。
- 期望值是来自规格的字面量，而非以代码推导它的相同方式推导出来的数字。

## 它的位置

`tdd` 是主构建链用来写代码所运行的红-绿回路：

```txt
grill-with-docs → to-prd → to-issues → implement → code-review
```

[implement](https://aihero.dev/skills-implement) 是链条的构建步骤，它在内部驱动 `tdd`，以测试先行的方式构建每个工单，然后交接给 [code-review](https://aihero.dev/skills-code-review)——所以 `tdd` 是那个步骤内部的引擎，而非它自己的一个步骤。你也可以直接触及它，每当有一个具体行为要构建而没有完整规格时。它的另一个邻居是 [codebase-design](https://aihero.dev/skills-codebase-design)，它依靠后者找到值得在其处测试的深模块接缝。当你不确定哪个技能或流程契合时，[ask-matt](https://aihero.dev/skills-ask-matt) 会为你路由。
