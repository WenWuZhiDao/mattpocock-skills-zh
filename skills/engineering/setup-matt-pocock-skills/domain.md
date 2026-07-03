# 领域文档

在探索代码库时，工程技能应如何消费这个仓库的领域文档。

## 探索之前，先读这些

- 仓库根目录的 **`CONTEXT.md`**，或者
- 如果存在，则读仓库根目录的 **`CONTEXT-MAP.md`**——它为每个上下文指向一个 `CONTEXT.md`。阅读与主题相关的每一个。
- **`docs/adr/`**——阅读触及你即将着手区域的 ADR。在多上下文仓库中，也检查 `src/<context>/docs/adr/` 中的上下文范围内决策。

如果这些文件中有任何不存在，**静默继续**。不要标记它们的缺失；不要一上来就建议创建它们。`/domain-modeling` 技能（通过 `/grill-with-docs` 和 `/improve-codebase-architecture` 触及）会在术语或决策真正被确定下来时惰性地创建它们。

## 文件结构

单上下文仓库（大多数仓库）：

```
/
├── CONTEXT.md
├── docs/adr/
│   ├── 0001-event-sourced-orders.md
│   └── 0002-postgres-for-write-model.md
└── src/
```

多上下文仓库（根目录存在 `CONTEXT-MAP.md`）：

```
/
├── CONTEXT-MAP.md
├── docs/adr/                          ← 系统级决策
└── src/
    ├── ordering/
    │   ├── CONTEXT.md
    │   └── docs/adr/                  ← 上下文专属决策
    └── billing/
        ├── CONTEXT.md
        └── docs/adr/
```

## 使用术语表的词汇

当你的输出为某个领域概念命名时（在一个 issue 标题、一个重构提案、一个假设、一个测试名中），使用 `CONTEXT.md` 中所定义的术语。不要漂移到术语表明确回避的同义词。

如果你所需要的概念还不在术语表里，那是一个信号——要么你在发明项目不使用的语言（重新考虑），要么存在一个真实的缺口（记下它以交给 `/domain-modeling`）。

## 标记 ADR 冲突

如果你的输出与现有 ADR 相抵触，明确地把它浮现出来，而不是静默地覆盖：

> _与 ADR-0007（event-sourced orders）相抵触——但值得重开，因为……_
