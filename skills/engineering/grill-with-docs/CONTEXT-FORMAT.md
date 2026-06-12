# CONTEXT.md 格式

## 结构

```md
# {上下文名称}

{用一两句话描述这个上下文是什么以及它为何存在。}

## Language

**Order**:
{用一两句话描述该术语}
_Avoid_: Purchase, transaction

**Invoice**:
A request for payment sent to a customer after delivery.
_Avoid_: Bill, payment request

**Customer**:
A person or organization that places orders.
_Avoid_: Client, buyer, account
```

## 规则

- **要有主见。** 当同一个概念存在多个词时，选出最好的一个，把其余的列在 `_Avoid_` 下面。
- **定义要紧凑。** 最多一两句话。定义它"是"什么，而不是它"做"什么。
- **只收录该项目上下文特有的术语。** 通用编程概念（超时、错误类型、工具模式）即便项目里大量使用也不属于这里。在添加一个术语之前，先问：这是该上下文独有的概念，还是通用编程概念？只有前者才属于这里。
- **当出现自然的聚类时，把术语分组到子标题下。** 如果所有术语都属于同一个内聚的领域，那么平铺的列表也没问题。

## 单上下文 vs 多上下文仓库

**单上下文（大多数仓库）：** 仓库根目录下有一个 `CONTEXT.md`。

**多上下文：** 仓库根目录下的 `CONTEXT-MAP.md` 列出各个上下文、它们所在的位置以及它们之间的关系：

```md
# Context Map

## Contexts

- [Ordering](./src/ordering/CONTEXT.md) — receives and tracks customer orders
- [Billing](./src/billing/CONTEXT.md) — generates invoices and processes payments
- [Fulfillment](./src/fulfillment/CONTEXT.md) — manages warehouse picking and shipping

## Relationships

- **Ordering → Fulfillment**: Ordering emits `OrderPlaced` events; Fulfillment consumes them to start picking
- **Fulfillment → Billing**: Fulfillment emits `ShipmentDispatched` events; Billing consumes them to generate invoices
- **Ordering ↔ Billing**: Shared types for `CustomerId` and `Money`
```

该技能会推断适用哪种结构：

- 如果存在 `CONTEXT-MAP.md`，读取它来找到各个上下文
- 如果只存在根目录的 `CONTEXT.md`，则为单上下文
- 如果两者都不存在，在第一个术语被确定时惰性地创建一个根目录 `CONTEXT.md`

当存在多个上下文时，推断当前主题与哪一个相关。如果不清楚，就询问。
