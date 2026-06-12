---
name: scaffold-exercises
description: 创建包含章节、习题、解答和讲解的练习目录结构，并能通过 lint 检查。当用户想搭建练习脚手架、创建练习存根，或新建一个课程章节时使用。
---

# 脚手架生成练习

创建能通过 `pnpm ai-hero-cli internal lint` 的练习目录结构，然后用 `git commit` 提交。

## 目录命名

- **章节（Sections）**：`exercises/` 内的 `XX-section-name/`（例如 `01-retrieval-skill-building`）
- **练习（Exercises）**：某章节内的 `XX.YY-exercise-name/`（例如 `01.03-retrieval-with-bm25`）
- 章节编号 = `XX`，练习编号 = `XX.YY`
- 名称采用 dash-case（小写，连字符）

## 练习变体

每个练习需要以下子文件夹中的至少一个：

- `problem/` —— 带 TODO 的学员工作区
- `solution/` —— 参考实现
- `explainer/` —— 概念性材料，无 TODO

生成桩代码时，除非计划另有规定，否则默认使用 `explainer/`。

## 必需文件

每个子文件夹（`problem/`、`solution/`、`explainer/`）都需要一个 `readme.md`，要求：

- **非空**（必须有真实内容，哪怕只有一行标题也行）
- 没有失效链接

生成桩代码时，创建一个带标题和描述的最小 readme：

```md
# Exercise Title

Description here
```

如果子文件夹有代码，还需要一个 `main.ts`（多于 1 行）。但对于桩代码而言，只有 readme 的练习也可以。

## 工作流程

1. **解析计划** —— 提取章节名称、练习名称和变体类型
2. **创建目录** —— 为每个路径执行 `mkdir -p`
3. **创建桩 readme** —— 每个变体文件夹一个带标题的 `readme.md`
4. **运行 lint** —— 用 `pnpm ai-hero-cli internal lint` 验证
5. **修复所有错误** —— 反复迭代直到 lint 通过

## Lint 规则摘要

linter（`pnpm ai-hero-cli internal lint`）会检查：

- 每个练习都有子文件夹（`problem/`、`solution/`、`explainer/`）
- 至少存在 `problem/`、`explainer/` 或 `explainer.1/` 中的一个
- 主子文件夹中存在非空的 `readme.md`
- 没有 `.gitkeep` 文件
- 没有 `speaker-notes.md` 文件
- readme 中没有失效链接
- readme 中没有 `pnpm run exercise` 命令
- 除非只有 readme，否则每个子文件夹都需要 `main.ts`

## 移动/重命名练习

重新编号或移动练习时：

1. 使用 `git mv`（而非 `mv`）重命名目录 —— 保留 git 历史
2. 更新数字前缀以维持顺序
3. 移动后重新运行 lint

示例：

```bash
git mv exercises/01-retrieval/01.03-embeddings exercises/01-retrieval/01.04-embeddings
```

## 示例：从计划生成桩代码

给定这样一个计划：

```
Section 05: Memory Skill Building
- 05.01 Introduction to Memory
- 05.02 Short-term Memory (explainer + problem + solution)
- 05.03 Long-term Memory
```

创建：

```bash
mkdir -p exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer
mkdir -p exercises/05-memory-skill-building/05.02-short-term-memory/{explainer,problem,solution}
mkdir -p exercises/05-memory-skill-building/05.03-long-term-memory/explainer
```

然后创建 readme 桩：

```
exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer/readme.md -> "# Introduction to Memory"
exercises/05-memory-skill-building/05.02-short-term-memory/explainer/readme.md -> "# Short-term Memory"
exercises/05-memory-skill-building/05.02-short-term-memory/problem/readme.md -> "# Short-term Memory"
exercises/05-memory-skill-building/05.02-short-term-memory/solution/readme.md -> "# Short-term Memory"
exercises/05-memory-skill-building/05.03-long-term-memory/explainer/readme.md -> "# Long-term Memory"
```
