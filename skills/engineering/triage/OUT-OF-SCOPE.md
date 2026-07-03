# 范围之外知识库

代码仓库中的 `.out-of-scope/` 目录存储被拒绝功能请求的持久记录。它有两个用途：

1. **机构记忆** —— 某功能为何被拒绝，这样在 issue 关闭时其理由不会丢失
2. **去重** —— 当有新 issue 进来且与先前的拒绝匹配时，技能可以浮现之前的决策，而不是重新争论一遍

## 目录结构

```
.out-of-scope/
├── dark-mode.md
├── plugin-system.md
└── graphql-api.md
```

一个**概念**一个文件，而不是一个 issue 一个文件。请求同一件事的多个 issue 归入同一个文件。

## 文件格式

文件应以一种轻松、易读的风格来写——更像一篇简短的设计文档，而不是一条数据库记录。使用段落、代码示例和例子，让理由对第一次接触它的人清晰而有用。

```markdown
# Dark Mode

This project does not support dark mode or user-facing theming.

## Why this is out of scope

The rendering pipeline assumes a single color palette defined in
`ThemeConfig`. Supporting multiple themes would require:

- A theme context provider wrapping the entire component tree
- Per-component theme-aware style resolution
- A persistence layer for user theme preferences

This is a significant architectural change that doesn't align with the
project's focus on content authoring. Theming is a concern for downstream
consumers who embed or redistribute the output.

```ts
// The current ThemeConfig interface is not designed for runtime switching:
interface ThemeConfig {
  colors: ColorPalette; // single palette, resolved at build time
  fonts: FontStack;
}
```

## Prior requests

- #42 — "Add dark mode support"
- #87 — "Night theme for accessibility"
- #134 — "Dark theme option"
```

### 为文件命名

为概念使用一个简短的、描述性的 kebab-case 名称：`dark-mode.md`、`plugin-system.md`、`graphql-api.md`。名称应足够可辨识，让浏览该目录的人无需打开文件就能理解被拒绝的是什么。

### 撰写理由

理由应有实质内容——不是“我们不想要这个”，而是为什么。好的理由会引用：

- 项目范围或理念（“本项目专注于 X；主题化是下游的关注点”）
- 技术约束（“支持它需要 Y，而这与我们的 Z 架构冲突”）
- 战略决策（“我们选择用 A 而不是 B，因为……”）

理由应具持久性。避免引用临时性的情形（“我们现在太忙了”）——那些不是真正的拒绝，只是推迟。

## 何时检查 `.out-of-scope/`

在分诊期间（第 1 步：收集上下文），读取 `.out-of-scope/` 中的所有文件。在评估新 issue 时：

- 检查该请求是否匹配某个已有的范围之外概念
- 匹配是按概念相似度，而非关键词——“night theme”匹配 `dark-mode.md`
- 如果有匹配，向维护者浮现它：“这与 `.out-of-scope/dark-mode.md` 相似——我们之前因为[理由]拒绝过。你现在仍然这么认为吗？”

维护者可能会：

- **确认** —— 新 issue 被添加到已有文件的 "Prior requests" 列表，然后关闭
- **重新考虑** —— 该范围之外文件被删除或更新，issue 进入正常分诊流程
- **不同意** —— 这些 issue 相关但有区别，进入正常分诊流程

## 何时写入 `.out-of-scope/`

仅当一个**增强**（而非缺陷）被作为 `wontfix` *拒绝*时。这一点对增强类 PR 的适用与对 issue 完全相同——被拒绝的 PR 记录在此，这样同一请求不会以全新代码的形式再次出现。

当某项因为**已经实现**而被作为 `wontfix` 关闭时，**不要**写入这里。那是一个已构建的功能，而非被拒绝的功能；记录它会用虚假的拒绝污染去重检查。相反，关闭评论应指向该功能已存在的位置。

流程：

1. 维护者判定某个功能请求属于范围之外
2. 检查是否已存在匹配的 `.out-of-scope/` 文件
3. 如果是：将新 issue 追加到 "Prior requests" 列表
4. 如果否：创建一个新文件，包含概念名称、决策、理由和第一个先前请求
5. 在该 issue 上发布一条评论，解释决策并提及 `.out-of-scope/` 文件
6. 用 `wontfix` 标签关闭该 issue

## 更新或删除范围之外文件

如果维护者改变了对先前被拒绝概念的想法：

- 删除该 `.out-of-scope/` 文件
- 技能无需重开旧 issue——它们是历史记录
- 触发重新考虑的那个新 issue 进入正常分诊流程
