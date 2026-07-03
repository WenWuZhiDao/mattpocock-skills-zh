---
name: wayfinder
description: 在一个迷雾笼罩的问题中规划一条路线 —— 把一个松散的想法变成你 issue 追踪器上一张由调查工单构成的共享地图，并逐一解决它们，直到通往目标的路径变得清晰。
---

一个松散的想法到来了 —— 大到一个智能体会话装不下，且被迷雾包裹：从这里到一份方案的路线尚不可见。本技能（Wayfinder，领路者）把它规划为仓库 issue 追踪器上的一张**共享地图（shared map）**，然后逐一处理它的工单。这张地图与领域无关 —— 工程工作、课程内容，凡是符合这个形态的都行。

## 以名称指代

每张地图和每个工单都是一个 issue，因此它有一个**名称（name）** —— 即它的标题。在人类所读的一切之中 —— 叙述、地图的 Decisions-so-far、交接 —— 都用那个名称来指代它，绝不要用光秃秃的 id、编号或 slug。一整墙的 `#42, #43, #44` 无法辨读；名称一眼就能读懂。id 和 URL 并不会消失 —— 名称包裹着它的链接，交接命令仍然粘贴 URL —— 但它们藏身*于*名称之内，绝不取而代之。

## 地图

地图是本仓库 issue 追踪器上的单个 issue，标注 `wayfinder:map` 标签 —— 是那个规范产物。它的工单是该地图的子 issue。

地图是一个**索引（index）**，而非一个存储库。它列出已做出的决策，并指向持有其细节的工单；一个决策恰好存在于一处 —— 它的工单 —— 因此地图从不复述它，只给出它的要点并链接过去。

**地图、它的子工单、阻塞关系以及前沿查询在物理上存放于何处，是因追踪器而异的。**查阅 `docs/agents/issue-tracker.md`（"Wayfinding operations"章节）了解_本_仓库如何表达它们。若该文档缺失，则默认使用本地 markdown 追踪器。

### 地图正文

整张地图的低分辨率版本，每次会话加载一次。开放工单**不**被列出 —— 它们是开放的子 issue，通过查询找到。

```markdown
## Notes

<domain; skills every session should consult; standing preferences for this effort>

## Decisions so far

<!-- the index — one line per closed ticket: enough to judge relevance, then zoom the link for the detail the ticket holds -->

- [<closed ticket title>](link) — <one-line gist of the answer>

## Fog

<!-- see "Fog of war" for what belongs here -->
```

### 工单

每个工单都是地图的一个**子 issue（child issue）**；追踪器的 issue id 就是它的身份。它的正文是那个问题，其大小适配一个 10 万 token 的智能体会话：

```markdown
## Question

<the decision or investigation this ticket resolves>
```

两个标签族：

- `wayfinder:<type>` —— `research`、`prototype`、`grilling`、`task` 之一（见 [Ticket Types](#ticket-types)）。
- `wayfinder:claimed` —— 一个会话在任何工作之前**首先**设置它，以便并发的会话跳过它。

阻塞使用追踪器的原生语义。当阻塞某工单的每一个工单都已关闭时，该工单便**解除阻塞（unblocked）**。**前沿（frontier）**是那些开放、已解除阻塞、未被认领的子工单 —— 已知的边缘。

答案不是正文的一部分 —— 它在解决时被记录（见 [Work through the map](#work-through-the-map)）。解决一个工单时创建的产物从该 issue 链接过去，而非粘贴进正文。

## Ticket Types

- **Research**：阅读文档、第三方 API，或知识库之类的本地资源。创建一份 markdown 摘要作为被链接的产物。当需要当前工作目录之外的知识时使用。
- **Prototype**：通过制作一个廉价、粗糙、具体的产物来提高讨论的保真度，好让人有东西可以反应 —— 一个提纲、一个粗略的尝试、一个桩，或通过 /prototype 技能生成的 UI/逻辑代码。把原型作为产物链接过去。当"它应该看起来如何"或"它应该表现如何"是关键问题时使用。
- **Grilling**：与智能体的对话。使用 /grilling 和 /domain-modeling 技能。一次只问一个问题。默认情形。
- **Task**：在讨论能够向前推进之前必须完成的、字面意义上的手动工作 —— 没有什么可决定、可原型化或可研究的。搬运数据、注册某个服务、开通访问权限。智能体能自动化的地方就自动化；否则就交给人类一份精确的清单。工作完成即算解决；答案记录做了什么以及由此产生的、后续工单所依赖的任何事实（凭据位置、新 URL、行数）。

## Fog of war

地图是_有意_不完整的：别去规划你还看不见的东西。工单之外便是迷雾 —— 你能感到即将到来、却还无法确切定位的那些决策与调查的模糊视野，因为它们悬挂在仍然开放的问题之上。解决一个工单会清除它前方的迷雾，把如今可规格化的东西升级为新工单 —— 一次一个，直到通往目标的路径清晰、且没有工单剩下为止。

地图的 **Fog** 章节就是那种模糊视野被写下来的地方：可疑的问题、日后要重访的区域、你正在推迟的风险。视野允许多松散就写多松散、允许多充分就写多充分；它同时充当一个路标，供协作者阅读这项工作正驶向何方。

**是迷雾还是工单？**检验标准在于你现在能否精确地陈述那个问题 —— 而_不_是你现在能否回答它。

- **工单**：当问题已经足够锐利 —— 即便它被阻塞、你还无法着手它。
- **迷雾**：当你还无法把它表述得那么锐利。别把迷雾预先切成工单大小的块：它比一个工单更粗粒度，而一片迷雾一旦被前沿触及，可能升级为若干工单，或一个也没有。

迷雾只排除那些已经决定的（那属于 Decisions so far）和已经是一个工单的东西。

## Invocation

两种模式。无论哪一种，**每次会话都以一次 [Handoff](#handoff) 结束** —— 每次会话解决的工单绝不超过一个。

### 规划地图

用户带着一个松散的想法来调用。

1. 运行一次 `/grilling` 和 `/domain-modeling` 会话，让开放的决策浮现出来。
2. **创建地图**（标签 `wayfinder:map`）：填好 Notes、Decisions-so-far 留空、Fog 勾勒出来。
3. **把你现在能规格化的工单**作为地图的子 issue 创建 —— 然后在**第二遍**中接上阻塞边（issue 需要先有 id 才能相互引用）。接线把它们分入前沿与被阻塞两类；一切你还无法规格化的东西留在 Fog 里。
4. 交接。规划地图是一个会话的工作量；不要同时也去解决工单。

### 沿地图推进

用户带着一张地图（URL 或编号）来调用。工单是**可选的** —— 没有工单时，由你来挑下一个决策，而非用户。

1. 加载**地图** —— 那个低分辨率视图，而非每个工单的正文。
2. 选择工单。如果用户点名了一个，就用它。否则按顺序取第一个前沿工单。**认领它**：设置 `wayfinder:claimed` 并在任何工作之前保存。
3. 解决它 —— **按需放大**：按需拉取任何相关或已关闭工单的完整正文；调用 `## Notes` 块所点名的技能。如有疑问，使用 `/grilling` 和 `/domain-modeling`。
4. 记录解决结果：把答案作为一条**解决评论（resolution comment）**发布，**关闭**该 issue，并向地图的 Decisions-so-far **追加一个上下文指针**。
5. 添加新浮现出来的工单（先创建再接线）；把答案已使之可规格化的任何迷雾升级为工单，并从 Fog 中清除每一片被升级的迷雾，使它只作为它的新工单而存在。如果该决策使地图的其他部分失效，就更新或删除那些工单。
6. 交接。

用户可能并行运行已解除阻塞的工单，所以要预料到其他会话正在并发地编辑追踪器。

## Handoff

每次会话都以一个用户可以复制粘贴的 **Next steps** 块结束。两种情形：

**仍有开放工单。**向地图查询当前已解除阻塞的子工单，然后给出两个复制粘贴选项：一个用于单个会话的裸命令（由你挑下一个工单），以及每个已解除阻塞的工单各一条固定命令用于并行运行它们。每个新窗口粘贴一行 —— 打开其中一个、几个或全部。

> **Next steps** — *<map name>*: 3 tickets unblocked. Clear the context, then open fresh sessions.
>
> **One session** — resolves the next unblocked ticket:
>
> ```
> Invoke /wayfinder with the map <map-url>.
> ```
>
> **Parallel** — paste one line per window, up to all 3:
>
> ```
> Invoke /wayfinder with the map <map-url>, ticket <issue-url>.  # <ticket name>
> Invoke /wayfinder with the map <map-url>, ticket <issue-url>.  # <ticket name>
> Invoke /wayfinder with the map <map-url>, ticket <issue-url>.  # <ticket name>
> ```

**没有开放工单剩下。**迷雾已被推远到通往目标的路径变得清晰的程度 —— 地图完成了。（最初的拷问也可能根本没有浮现出任何迷雾，那样的话从来就没有一张地图需要规划。）建议直接实现，或使用 `/to-prd` 来安排一次多会话的实现。
