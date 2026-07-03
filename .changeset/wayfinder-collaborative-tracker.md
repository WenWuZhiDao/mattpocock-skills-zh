---
"mattpocock-skills": minor
---

让 **`wayfinder`（领路者）**变得可协作，把地图从本地 Markdown 文件搬到仓库的 issue 追踪器上。

地图现在是单个 `wayfinder:map` issue，其工单是它的子 issue——一个整个团队都能关注和评论的共享 URL。阻塞、认领（`wayfinder:claimed`）和前沿（frontier）查询全部使用追踪器的原生语义，因此一个会话以低分辨率加载地图（Notes + 每个已关闭工单一个上下文指针 + Fog 散文），并按需放大到单个工单，而不是每次都加载整张地图。

领路者保持与追踪器无关：按追踪器的机制藏在 `docs/agents/issue-tracker.md` 中的一个指针后面，因此 `setup-matt-pocock-skills` 现在会为 GitHub、GitLab 和 local-markdown 播种一个"Wayfinding operations"小节。若缺少该文档，领路者默认使用 local-markdown。
