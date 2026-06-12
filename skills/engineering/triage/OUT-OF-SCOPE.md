# 范围之外（Out-of-Scope）知识库

仓库中的 `.out-of-scope/` 目录存储被驳回功能请求的持久记录。它有两个用途：

1. **机构记忆** — 一项功能为什么被驳回，这样在 issue 被关闭时其理由不会丢失
2. **去重** — 当一个与先前驳回相符的新 issue 进来时，技能可以浮现先前的决定，而不是重新争论一遍

## 目录结构

```
.out-of-scope/
├── dark-mode.md
├── plugin-system.md
└── graphql-api.md
```

每个**概念（concept）**一个文件，而非每个 issue 一个文件。多个请求同一件事的 issue 会被归到一个文件下。

## 文件格式

文件应当以一种轻松、易读的风格撰写——更像一份简短的设计文档，而非一条数据库记录。使用段落、代码示例和实例，让其中的理由对于初次接触它的人来说清晰而有用。

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

### 给文件命名

为概念使用一个简短、描述性的 kebab-case 名称：`dark-mode.md`、`plugin-system.md`、`graphql-api.md`。这个名称应当足够可识别，让浏览该目录的人无需打开文件就能理解什么被驳回了。

### 撰写理由

理由应当言之有物——不是 "我们不想要这个"，而是为什么不想要。好的理由会引用：

- 项目范围或理念（"本项目专注于 X；主题化是下游的关注点"）
- 技术约束（"支持这个需要 Y，而 Y 与我们的 Z 架构冲突"）
- 战略决策（"我们选择使用 A 而非 B，因为……"）

理由应当是持久的。避免引用临时性的情形（"我们现在太忙了"）——那些不是真正的驳回，而是延期。

## 何时检查 `.out-of-scope/`

在 triage 过程中（第 1 步：收集上下文），阅读 `.out-of-scope/` 中的所有文件。在评估一个新 issue 时：

- 检查该请求是否与某个已有的 out-of-scope 概念相符
- 匹配是按概念相似度，而非关键词——"night theme" 与 `dark-mode.md` 相符
- 如果有匹配，把它浮现给维护者："这与 `.out-of-scope/dark-mode.md` 相似——我们之前驳回过这个，理由是 [reason]。你现在还是这个看法吗？"

维护者可以：

- **确认** — 这个新 issue 被添加到已有文件的 "Prior requests" 列表中，然后关闭
- **重新考虑** — out-of-scope 文件被删除或更新，issue 走正常的 triage 流程
- **不同意** — 这些 issue 相关但有区别，走正常的 triage 流程

## 何时写入 `.out-of-scope/`

仅当一个**enhancement**（而非 bug）被驳回为 `wontfix` 时。流程：

1. 维护者判定某个功能请求超出范围
2. 检查是否已存在一个相符的 `.out-of-scope/` 文件
3. 如果有：把新 issue 追加到 "Prior requests" 列表
4. 如果没有：创建一个新文件，包含概念名称、决定、理由和第一条先前请求
5. 在该 issue 上发布一条评论，解释这一决定并提及 `.out-of-scope/` 文件
6. 用 `wontfix` 标签关闭该 issue

## 更新或移除 out-of-scope 文件

如果维护者改变了对某个先前驳回概念的看法：

- 删除该 `.out-of-scope/` 文件
- 技能不需要重新打开旧 issue——它们是历史记录
- 触发此次重新考虑的新 issue 走正常的 triage 流程
