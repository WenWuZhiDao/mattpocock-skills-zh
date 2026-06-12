---
name: write-a-skill
description: 创建结构合理、采用渐进式披露并附带捆绑资源的新智能体技能。当用户想创建、编写或构建一个新技能时使用。
---

# 编写技能（Skills）

## 流程

1. **收集需求** —— 向用户询问：
   - 这个技能涵盖什么任务/领域？
   - 它应处理哪些具体用例？
   - 它需要可执行脚本，还是仅需说明？
   - 有哪些参考资料需要包含？

2. **起草技能** —— 创建：
   - 带有简洁说明的 SKILL.md
   - 如果内容超过 500 行，则增加额外的参考文件
   - 如果需要确定性操作，则增加实用脚本

3. **与用户一起审阅** —— 呈现草稿并询问：
   - 这是否覆盖了你的用例？
   - 有没有遗漏或不清楚的地方？
   - 是否应让某些部分更详细/更简略？

## 技能结构

```
skill-name/
├── SKILL.md           # 主要说明（必需）
├── REFERENCE.md       # 详细文档（如需要）
├── EXAMPLES.md        # 使用示例（如需要）
└── scripts/           # 实用脚本（如需要）
    └── helper.js
```

## SKILL.md 模板

```md
---
name: skill-name
description: Brief description of capability. Use when [specific triggers].
---

# Skill Name

## Quick start

[最小可运行示例]

## Workflows

[针对复杂任务的分步流程，附带清单]

## Advanced features

[链接到单独文件：See [REFERENCE.md](REFERENCE.md)]
```

## 描述（description）的要求

描述是你的智能体在决定加载哪个技能时**唯一能看到的东西**。它与所有其他已安装的技能一起呈现在系统提示中。你的智能体阅读这些描述，并根据用户的请求挑选相关技能。

**目标**：给你的智能体刚好足够的信息，让它知道：

1. 这个技能提供什么能力
2. 何时/为何触发它（具体关键词、上下文、文件类型）

**格式**：

- 最多 1024 字符
- 用第三人称书写
- 第一句：它做什么
- 第二句：“Use when [具体触发条件]”

**好例子**：

```
Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when user mentions PDFs, forms, or document extraction.
```

**坏例子**：

```
Helps with documents.
```

坏例子没有给你的智能体任何方法把它与其他文档类技能区分开来。

## 何时添加脚本

在以下情况添加实用脚本：

- 操作是确定性的（校验、格式化）
- 同样的代码会被反复生成
- 错误需要显式处理

相比生成的代码，脚本能节省 token 并提高可靠性。

## 何时拆分文件

在以下情况拆分为单独文件：

- SKILL.md 超过 100 行
- 内容包含不同的领域（财务 schema vs 销售 schema）
- 高级特性很少用到

## 审阅清单

起草后，核对：

- [ ] 描述包含触发条件（“Use when...”）
- [ ] SKILL.md 不超过 100 行
- [ ] 没有时效性信息
- [ ] 术语一致
- [ ] 包含具体示例
- [ ] 引用只下探一层
