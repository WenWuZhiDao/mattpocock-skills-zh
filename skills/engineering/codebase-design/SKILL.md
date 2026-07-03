---
name: codebase-design
description: 用于设计深模块的共享词汇。当用户想设计或改进一个模块的接口、寻找深化机会、决定接缝放在何处、让代码更可测试或更易于 AI 导航，或当另一个技能需要深模块词汇时使用。
---

# Codebase Design

设计 **深模块（deep modules）**：在一个小接口后托起大量行为，置于一个干净的接缝处，可通过该接口测试。凡是在设计或重构代码之处都使用这套语言和这些原则。目标是给调用方杠杆、给维护者局部性、给所有人可测试性。

## 词汇表

精确使用这些术语——不要用 "component"、"service"、"API" 或 "boundary" 来替代。语言一致正是全部要义。

**Module（模块）** — 任何拥有接口和实现的东西。刻意与规模无关：一个函数、类、包，或跨层的切片。_避免_：unit、component、service。

**Interface（接口）** — 调用方为正确使用模块所必须知道的一切：类型签名，但也包括不变式、顺序约束、错误模式、必需的配置和性能特征。_避免_：API、signature（太窄——它们只指类型层面的表层）。

**Implementation（实现）** — 模块内部的东西，它的代码主体。与 **Adapter（适配器）** 有别：一个东西可以是小适配器带大实现（Postgres 仓库），也可以是大适配器带小实现（内存假件）。当话题是接缝时用 "adapter"；否则用 "implementation"。

**Depth（深度）** — 接口处的杠杆：调用方（或测试）每学习一个单位的接口所能施展的行为量。当大量行为坐落于小接口之后时，模块是 **深的**；当接口几乎和实现一样复杂时，是 **浅的**。

**Seam（接缝）** _(Michael Feathers)_ — 一个你无需在该处编辑就能改变行为的地方；模块接口所在的 *位置*。接缝放在何处是它自己的设计决策，与接缝后面放什么有别。_避免_：boundary（与 DDD 的限界上下文重载）。

**Adapter（适配器）** — 在接缝处满足某个接口的具体之物。描述 *角色*（它填哪个槽），而非实质（它内部是什么）。

**Leverage（杠杆）** — 调用方从深度中得到的：每学习一个单位的接口就获得更多能力。一份实现跨 N 个调用点和 M 个测试回本。

**Locality（局部性）** — 维护者从深度中得到的：变化、bug、知识和验证集中在一个地方，而非散布到各调用方。修一次，处处修好。

## 深 vs 浅

**深模块** = 小接口 + 大量实现：

```
┌─────────────────────┐
│   Small Interface   │  ← Few methods, simple params
├─────────────────────┤
│                     │
│  Deep Implementation│  ← Complex logic hidden
│                     │
└─────────────────────┘
```

**浅模块** = 大接口 + 少量实现（避免）：

```
┌─────────────────────────────────┐
│       Large Interface           │  ← Many methods, complex params
├─────────────────────────────────┤
│  Thin Implementation            │  ← Just passes through
└─────────────────────────────────┘
```

设计接口时，问：

- 我能减少方法的数量吗？
- 我能简化参数吗？
- 我能在内部隐藏更多复杂性吗？

## 原则

- **深度是接口的属性，不是实现的属性。** 一个深模块内部可以由小的、可 mock 的、可替换的部件组成——它们只是不属于接口。一个模块可以既有 **内部接缝**（对其实现私有，供它自己的测试使用），也有其接口处的 **外部接缝**。
- **删除测试。** 想象删掉这个模块。如果复杂性消失了，它就是个直通件。如果复杂性在 N 个调用方处重新冒出来，那它就是在挣自己的饭钱。
- **接口就是测试面。** 调用方和测试跨过同一个接缝。如果你想测试接口 *之外* 的东西，那这个模块的形态多半错了。
- **一个适配器意味着一个假想的接缝。两个适配器才意味着一个真实的接缝。** 除非确有东西跨它而变化，否则不要引入接缝。

## 为可测试性而设计

好的接口让测试变得自然：

1. **接收依赖，别创建它们。**

   ```typescript
   // Testable
   function processOrder(order, paymentGateway) {}

   // Hard to test
   function processOrder(order) {
     const gateway = new StripeGateway();
   }
   ```

2. **返回结果，别产生副作用。**

   ```typescript
   // Testable
   function calculateDiscount(cart): Discount {}

   // Hard to test
   function applyDiscount(cart): void {
     cart.total -= discount;
   }
   ```

3. **小表面积。** 方法越少 = 需要的测试越少。参数越少 = 测试搭建越简单。

## 关系

- 一个 **Module** 恰好有一个 **Interface**（它呈现给调用方和测试的表面）。
- **Depth** 是 **Module** 的属性，相对于其 **Interface** 来衡量。
- **Seam** 是 **Module** 的 **Interface** 所在之处。
- **Adapter** 坐落于一个 **Seam**，并满足其 **Interface**。
- **Depth** 为调用方产生 **Leverage**，为维护者产生 **Locality**。

## 被否决的框定

- **把深度当作实现行数与接口行数之比**（Ousterhout）：这会奖励往实现里注水。我们改用深度即杠杆。
- **把 "Interface" 当作 TypeScript 的 `interface` 关键字或一个类的公有方法**：太窄——这里的接口包含调用方必须知道的每一个事实。
- **"Boundary"**：与 DDD 的限界上下文重载。请说 **seam** 或 **interface**。

## 更深入

- **在给定依赖的情况下深化一簇模块** — 见 [DEEPENING.md](DEEPENING.md)：依赖类别、接缝准则，以及「替换而非叠加」的测试。
- **探索备选接口** — 见 [DESIGN-IT-TWICE.md](DESIGN-IT-TWICE.md)：拉起并行子智能体，用几种根本不同的方式设计接口，然后从深度、局部性和接缝放置上比较。
