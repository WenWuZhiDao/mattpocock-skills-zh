快速开始：

```bash
npx skills add mattpocock/skills --skill=research
```

```bash
npx skills update research
```

[源码](https://github.com/mattpocock/skills/tree/main/skills/engineering/research)

## 它做什么

`research` 通过阅读那些拥有答案的来源来回答一个问题，并留下一份带引用的 Markdown 文件。它只从**第一手来源**工作——官方文档、源代码、规格、第一方 API——绝不从它们的二手转述工作，因此它所保存的东西能追溯回某个权威的东西，而不是一份摘要的摘要。

## 何时使用它

输入 `/research`，或者当任务变成阅读的跑腿活时智能体会自动触发它。

当下一步是*把某件事弄清楚*时就用它——一个 API 如何表现、一份规格实际说了什么、一个论断是否成立——而你宁愿不为做这些阅读而卡住自己的思路。若要通过访谈而非阅读来磨利一个计划，请用 [grilling](https://aihero.dev/skills-grilling)；若要用用完即弃的代码探索该构建什么，请用 [prototype](https://aihero.dev/skills-prototype)。

## 委派出去的跑腿活

其定义性的动作是，阅读作为一个**后台智能体**运行。你继续工作；它跑开去，把每个论断追溯回它的第一手来源，然后把一份带引用的 Markdown 文件丢进仓库存放此类笔记的地方。研究是你委派出去的跑腿活，而不是你外包出去的思考——你拿回一份可以据之反应的文档，附带它的来源。

## 它的位置

一个随时可取用的独立技能，喂给那些思考型技能：它产出的文件是可供拷问、规划或据以设计的东西，所以它坐落在 [grilling](https://aihero.dev/skills-grilling) 和 [to-prd](https://aihero.dev/skills-to-prd) 这类工作的上游，而不是在构建链中。要看整张地图，见 [ask-matt](https://aihero.dev/skills-ask-matt)。
