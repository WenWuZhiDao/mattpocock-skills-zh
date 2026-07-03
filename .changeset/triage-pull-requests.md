---
"mattpocock-skills": patch
---

扩展 **`triage`** 技能以分诊外部 pull request，把 PR 当作附带了代码的 issue，让它走过同样的角色和状态机。PR 与 issue 内联并流（由按仓库的设置开关控制），发现过程只呈现外部 PR，仅用于 bug 的"reproduce"步骤被泛化为单一的"verify the claim"步骤，且一个冗余检查会把已经实现的请求解析为 `wontfix`，而不污染范围外（out-of-scope）知识库。`setup-matt-pocock-skills` 为 GitHub/GitLab 新增了"PR 作为请求来源"的开关。
