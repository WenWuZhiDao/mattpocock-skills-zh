---
name: to-prd
description: 将当前对话变成一份 PRD 并发布到项目问题追踪器——不做访谈，只综合你们已经讨论过的内容。
disable-model-invocation: true
---

本技能获取当前对话上下文和对代码库的理解，并产出一份 PRD。不要访谈用户——只综合你已经知道的内容。

问题追踪器和分诊标签词汇应该已经提供给你——如果没有，请运行 `/setup-matt-pocock-skills`。

## 流程

1. 探索代码仓库以理解代码库的当前状态（如果你还没做过）。在整份 PRD 中使用项目的领域术语表词汇，并尊重你所触及区域内的任何 ADR。

2. 勾勒出你将在哪些接缝处测试该功能。应优先选择已有接缝而非新增接缝。使用尽可能高层的接缝。如果需要新接缝，把它们提在你能提到的最高点上。跨代码库的接缝越少越好——理想数量是一个。

与用户确认这些接缝符合他们的预期。

3. 使用下面的模板撰写 PRD，然后将其发布到项目问题追踪器。应用 `ready-for-agent` 分诊标签——无需额外分诊。

<prd-template>

## Problem Statement

用户正面临的问题，从用户的视角出发。

## Solution

对该问题的解决方案，从用户的视角出发。

## User Stories

一个很长的、带编号的用户故事列表。每个用户故事应采用如下格式：

1. As an <actor>, I want a <feature>, so that <benefit>

<user-story-example>
1. As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending
</user-story-example>

这个用户故事列表应极其详尽，覆盖该功能的所有方面。

## Implementation Decisions

已做出的实现决策列表。这可以包括：

- 将构建/修改的模块
- 这些模块中将被修改的接口
- 来自开发者的技术澄清
- 架构决策
- Schema 变更
- API 契约
- 具体的交互

不要包含具体的文件路径或代码片段。它们可能很快就会过时。

例外：如果某个原型产出了一个比散文更精确地编码了某项决策的片段（状态机、reducer、schema、类型形态），把它内联在相关决策中，并简要注明它来自原型。裁剪到富含决策的部分——不是一个可运行的演示，只是重要的片段。

## Testing Decisions

已做出的测试决策列表。包括：

- 对什么构成好测试的描述（只测试外部行为，而非实现细节）
- 将测试哪些模块
- 测试的先例（即代码库中类似类型的测试）

## Out of Scope

对本 PRD 范围之外事项的描述。

## Further Notes

关于该功能的任何补充说明。

</prd-template>
