# 模型调用 vs 用户调用

本仓库中的每个 `SKILL.md` 都是一个技能。划分它们的唯一一个轴是**调用（invocation）**——谁能触及它：

- **用户调用（User-invoked）**—— **只有人输入它的名字才能触及**。在 frontmatter 中设置 `disable-model-invocation: true`。`description` 是**面向人的**：一行摘要，供浏览 slash 命令的人阅读。去掉触发列表（"Use when the user says…"）。
- **模型调用（Model-invoked）**—— **模型或用户均可触及**。默认做法：省略 `disable-model-invocation`。`description` 是**面向模型的**，并保留丰富的触发措辞（"Use when the user wants…, mentions…, asks for…"），以便自动调用能被触发。判断一个技能是否应保持模型调用的检验标准是：_模型能否自主地有用地触及它？_（复用是提取一个技能的理由，而不是这项检验。）

因为用户调用技能没有 description，除了人以外没有任何东西能触及它——没有其他技能能触发它。所以用户调用技能可以调用模型调用技能，但它绝不能触及另一个用户调用技能。

Bucket 的 `README.md` 以及顶层 `README.md` 会把条目分组为**用户调用（User-invoked）**和**模型调用（Model-invoked）**。

## 二者之间的依赖

依赖以 **`/skill` 风格的散文调用**表达（"Run the `/grilling` skill"），而不是深层的 `../other-skill/FILE.md` 交叉引用。共享的参考文档存放在拥有它们的技能内部；其他技能通过调用该技能来触及那份材料，而不是跨文件夹链接。

## 被动 vs 主动的领域工作

仅仅是_读_ `CONTEXT.md` 获取词汇，是一行散文指引，而不是 `domain-modeling` 技能。只有主动的构建/打磨纪律（挑战术语、边缘案例场景、写 ADR、就地更新 `CONTEXT.md`）才是 `domain-modeling`。
