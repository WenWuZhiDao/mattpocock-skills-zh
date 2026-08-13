---
name: to-spec
description: 把当前对话转化为一份规格说明，并发布到项目工单跟踪器——无需访谈，只是综合你们已经讨论过的内容。
disable-model-invocation: true
---

这个技能拿当前对话上下文和对代码库的理解，产出一份规格说明。不要访谈用户——只综合你已经知道的东西。

工单跟踪器和分诊标签词汇应当已经提供给你——如果没有，运行 `/setup-matt-pocock-skills`。

## 流程

1. 探索仓库以理解代码库的当前状态（如果你还没做）。在整份规格里使用项目的领域词汇表词汇，并尊重你正在触碰的区域里的任何 ADR。

2. 勾画出你打算在其处测试这个功能的接缝。已有接缝应优先于新接缝。用尽可能高的接缝。如果需要新接缝，就在你能做到的最高点提出它们。跨代码库的接缝越少越好——理想数量是一个。

与用户核对这些接缝是否符合他们的预期。

3. 用下面的模板写规格，然后把它发布到项目工单跟踪器。应用 `ready-for-agent` 分诊标签——无需额外分诊。

<spec-template>

## Problem Statement

用户正面临的问题，从用户的视角出发。

## Solution

对这个问题的解决方案，从用户的视角出发。

## User Stories

一个长长的、带编号的用户故事列表。每个用户故事都应采用如下格式：

1. As an <actor>, I want a <feature>, so that <benefit>

<user-story-example>
1. As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending
</user-story-example>

这个用户故事列表应当极其详尽，覆盖该功能的所有方面。

## Implementation Decisions

一个做出的实现决策列表。它可以包括：

- 将要构建/修改的模块
- 那些模块中将被修改的接口
- 来自开发者的技术澄清
- 架构决策
- schema 变更
- API 契约
- 具体的交互

不要包含具体的文件路径或代码片段。它们可能很快就过时。

例外：如果一个原型产出了一个比散文更精确地编码了某个决策的片段（状态机、reducer、schema、类型形状），就把它内联进相关决策，并简要注明它来自一个原型。修剪到富含决策的部分——不是一个可运行的演示，只是重要的那些位。

## Testing Decisions

一个做出的测试决策列表。包括：

- 一段关于什么是好测试的描述（只测外部行为，不测实现细节）
- 哪些模块将被测试
- 测试的先例（即代码库里类似类型的测试）

## Out of Scope

一段关于这份规格范围之外的东西的描述。

## Further Notes

关于这个功能的任何进一步说明。

</spec-template>
