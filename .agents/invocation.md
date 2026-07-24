# 模型调用型 vs 用户调用型

本仓库中的每个 `SKILL.md` 都是一个技能。区分它们的唯一维度是**调用方式**——谁能触达它：

- **用户调用型**——**只能由人输入其名称**来触达。在 frontmatter 中设置 `disable-model-invocation: true`（Claude Code），并在 `agents/openai.yaml` 中设置 `policy.allow_implicit_invocation: false`（Codex）。`description` 是**面向人的**：一句由浏览斜杠命令的人阅读的摘要。去掉触发词列表（"当用户说……时使用"）。
- **模型调用型**——可由**模型或用户**触达。这是默认：省略 `disable-model-invocation`，并在 `agents/openai.yaml` 中省略 `policy` 块。`description` 是**面向模型的**，保留丰富的触发短语（"当用户想要……、提到……、请求……时使用"），以便自动调用能被触发。判断一个技能是否应保持模型调用型的检验标准是：_模型能否自主地、有用地伸手去用它？_（复用是抽取一个技能的理由，而不是这个检验标准。）

每个框架各自以自己的方式把用户调用型技能排除在模型可触达范围之外，因此除了人以外没有任何东西能触发它——其他技能都不能。用户调用型技能可以调用模型调用型技能，但它永远无法触达另一个用户调用型技能。

每个技能还在其 `SKILL.md` 旁边携带一个 `agents/openai.yaml`。它保存 Codex 的 UI 元数据——用于技能选择器的 `interface.display_name` 和 `interface.short_description`——以及对用户调用型技能而言，与 `disable-model-invocation` 配对的 `policy.allow_implicit_invocation: false`。要保持两者同步：一个技能要么在两个框架中都是用户调用型，要么都不是。

分桶的 `README.md` 和顶层 `README.md` 把条目分组为**用户调用型**和**模型调用型**。

## 它们之间的依赖

依赖以 **`/skill` 风格的散文调用**来表达（"运行 `/grilling` 技能"），而不是深层的 `../other-skill/FILE.md` 交叉引用。共享的参考文档存放在拥有它们的技能内部；其他技能通过调用该技能来触达那些材料，而不是跨文件夹链接。

## 被动 vs 主动的领域工作

仅仅为了词汇而_阅读_ `CONTEXT.md`，只是一行散文指针，而不是 `domain-modeling` 技能。只有主动的构建／磨砺纪律（质疑术语、边界情形场景、撰写 ADR、就地更新 `CONTEXT.md`）才是 `domain-modeling`。
