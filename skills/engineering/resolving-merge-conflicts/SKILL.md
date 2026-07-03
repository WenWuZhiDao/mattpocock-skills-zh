---
name: resolving-merge-conflicts
description: "在你需要解决一个进行中的 git merge/rebase 合并冲突时使用。"
---

1. **查看 merge/rebase 的当前状态**。检查 git 历史，以及有冲突的文件。

2. **为每个冲突找到主要来源**。深入理解每处变更为何做出，以及原始意图是什么。阅读 commit 消息、查看 PR、查看原始的 issue/工单。

3. **解决每个 hunk。** 在可能之处保留双方的意图。当不兼容时，选择与本次 merge 所声明目标相符的那个，并记下权衡。**不要** 发明新行为。始终解决冲突；永不 `--abort`。

4. 发现项目的 **自动化检查** 并运行它们——通常是类型检查，然后测试，然后格式化。修复 merge 破坏的任何东西。

5. **完成 merge/rebase。** 暂存所有内容并提交。如果是 rebase，继续 rebase 过程，直到所有 commit 都完成 rebase。
