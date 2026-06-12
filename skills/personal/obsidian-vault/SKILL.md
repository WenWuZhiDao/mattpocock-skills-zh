---
name: obsidian-vault
description: 在 Obsidian 知识库中搜索、创建和管理笔记，使用 wikilink 和索引笔记。当用户想在 Obsidian 中查找、创建或整理笔记时使用。
---

# Obsidian 知识库

## 知识库位置

`/mnt/d/Obsidian Vault/AI Research/`

大体上在根目录下扁平存放。

## 命名约定

- **索引笔记（Index notes）**：聚合相关主题（例如 `Ralph Wiggum Index.md`、`Skills Index.md`、`RAG Index.md`）
- 所有笔记名称使用 **Title Case（标题大小写）**
- 不用文件夹来组织 —— 改用链接和索引笔记

## 链接

- 使用 Obsidian 的 `[[wikilinks]]` 语法：`[[Note Title]]`
- 笔记在底部链接到依赖项/相关笔记
- 索引笔记就是一组 `[[wikilinks]]` 列表

## 工作流

### 搜索笔记

```bash
# 按文件名搜索
find "/mnt/d/Obsidian Vault/AI Research/" -name "*.md" | grep -i "keyword"

# 按内容搜索
grep -rl "keyword" "/mnt/d/Obsidian Vault/AI Research/" --include="*.md"
```

或者直接在知识库路径上使用 Grep/Glob 工具。

### 创建新笔记

1. 文件名使用 **Title Case（标题大小写）**
2. 将内容写成一个学习单元（遵循知识库规则）
3. 在底部添加指向相关笔记的 `[[wikilinks]]`
4. 如果是某个编号序列的一部分，使用分层编号方案

### 查找相关笔记

在整个知识库中搜索 `[[Note Title]]` 以找到反向链接：

```bash
grep -rl "\\[\\[Note Title\\]\\]" "/mnt/d/Obsidian Vault/AI Research/"
```

### 查找索引笔记

```bash
find "/mnt/d/Obsidian Vault/AI Research/" -name "*Index*"
```
