---
"mattpocock-skills": minor
---

把 **`decision-mapping`** 技能重命名为 **`wayfinder`（领路者）**，以 `/wayfinder` 调用。

"Decision map"既行话又不准确——该技能四种工单类型中只有一种（Grilling）真正是决策。这次重构描绘的是穿越一个迷雾问题的路线，一次解决一个调查工单，直到通往目标的路径清晰为止。这形成了一个连贯的领头词框架（战争迷雾 / 前沿 / 地图），而不是在它之上混入一个生造的术语。

同时做了一次修剪：把 `node`→`ticket` 统一，把"the frontier"绑定到未被阻塞的工单，删除重复的"one question at a time"（归属于 `/grilling`），并削减了导言中的无操作（no-op）。
