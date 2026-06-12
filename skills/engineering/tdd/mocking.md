# 何时 Mock

只在**系统边界**处 mock：

- 外部 API（支付、邮件等）
- 数据库（有时——优先用测试库）
- 时间/随机性
- 文件系统（有时）

不要 mock：

- 你自己的类/模块
- 内部协作者
- 任何你能控制的东西

## 为可 Mock 性而设计

在系统边界处，设计易于 mock 的接口：

**1. 使用依赖注入**

把外部依赖传进来，而不是在内部创建它们：

```typescript
// 易于 mock
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}

// 难以 mock
function processPayment(order) {
  const client = new StripeClient(process.env.STRIPE_KEY);
  return client.charge(order.total);
}
```

**2. 偏好 SDK 风格的接口，而非通用的 fetcher**

为每个外部操作创建专门的函数，而不是用一个带条件逻辑的通用函数：

```typescript
// 好：每个函数都可以独立 mock
const api = {
  getUser: (id) => fetch(`/users/${id}`),
  getOrders: (userId) => fetch(`/users/${userId}/orders`),
  createOrder: (data) => fetch('/orders', { method: 'POST', body: data }),
};

// 坏：mock 时需要在 mock 内部写条件逻辑
const api = {
  fetch: (endpoint, options) => fetch(endpoint, options),
};
```

SDK 方式意味着：
- 每个 mock 返回一个确定的形状
- 测试准备中没有条件逻辑
- 更容易看出一个测试执行了哪些端点
- 每个端点都有类型安全
