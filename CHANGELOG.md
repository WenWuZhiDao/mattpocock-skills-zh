# mattpocock-skills

## 1.0.1

### Patch Changes

- [`d20ee26`](https://github.com/mattpocock/skills/commit/d20ee2684e2a9442698ac3c1e0f2c5b68c4cf296) Thanks [@mattpocock](https://github.com/mattpocock)! - 让 **`teach`** 技能以复用为先。课程现在由 `./assets/` 中可复用的**组件**构建——样式表、测验小部件、模拟器、图示辅助工具。复用是默认做法：智能体在编写一节课之前先读 `./assets/`，用已有的东西来构建，并把任何新的、可复用的东西提取成组件，而不是内联它。

## 1.0.0

### Major Changes

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) Thanks [@mattpocock](https://github.com/mattpocock)! - 新增 **`ask-matt`** 技能——一个用户调用的路由器，为你的处境指向正确的技能或流程。

  **破坏性变更：**`ask-matt` 在本仓库的其他用户调用技能之上做路由，因此它要求这些技能已经安装。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) Thanks [@mattpocock](https://github.com/mattpocock)! - 新增共享的设计技能，并把现有技能重新接线到它们之上。

  - 新增 **`codebase-design`** 技能——深模块的词汇（module、interface、depth、seam、adapter）以及把大量行为放到小接口后面的原则。此前存放在 `improve-codebase-architecture/LANGUAGE.md` 中的语言现在存放在这里，经过泛化以便跨技能复用。
  - 新增 **`domain-modeling`** 技能——主动构建并打磨项目的领域模型，用术语表对术语做压力测试，并让 `CONTEXT.md` 和 ADR 保持最新。
  - `improve-codebase-architecture` 现在从 `/codebase-design` 汲取其架构词汇，从 `/domain-modeling` 汲取其领域模型。
  - `tdd` 现在依靠 `/codebase-design` 提供接口设计指引——它内联的 `deep-modules.md` / `interface-design.md` 说明已被移除，改用共享技能。
  - `grill-with-docs` 现在通过 `/domain-modeling` 就地构建领域模型。

  **破坏性变更：**这些技能现在依赖新的 `codebase-design` / `domain-modeling` 技能，因此你必须一并安装它们。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) Thanks [@mattpocock](https://github.com/mattpocock)! - 移除 **`caveman`** 和 **`zoom-out`** 技能。

  - `caveman` 是我在测试的另一个技能的副本，从未打算公开。
  - `zoom-out` 在实践中一直没被用到，因此已从仓库中移除。

  **破坏性变更：**两个技能都已被移除。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) Thanks [@mattpocock](https://github.com/mattpocock)! - 将 **`diagnose`** 技能重命名为 **`diagnosing-bugs`**。

  **破坏性变更：**请以 `/diagnosing-bugs` 调用它——旧的 `/diagnose` 名称已不存在。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) Thanks [@mattpocock](https://github.com/mattpocock)! - 用 **`writing-great-skills`** 替换 **`write-a-skill`**。

  - 移除了 `write-a-skill`。
  - 新增了 `writing-great-skills`（外加它的 `GLOSSARY.md`）——写好和编辑好技能的参考：让技能变得可预测的词汇与原则，把无操作（no-op）追查到句子层面。
  - 把 `grilling` 暴露为模型调用技能——`grill-me` 和 `grill-with-docs` 背后可复用的访谈回路。

  **破坏性变更：**`write-a-skill` 已被移除；请改用 `writing-great-skills`。

### Minor Changes

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) Thanks [@mattpocock](https://github.com/mattpocock)! - 新增 **`resolving-merge-conflicts`** 技能——用于解决正在进行的 git merge 或 rebase 冲突的回路。独立运行，不依赖其他技能。

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) Thanks [@mattpocock](https://github.com/mattpocock)! - 在文档中把技能分类法从 **Commands / Skills** 重命名为 **User-invoked / Model-invoked**，并新增 `docs/invocation.md` 定义这一划分：用户调用技能只有你输入时才能触及，且存在的目的是编排；模型调用技能也可以在任务契合时被自动触及。用户调用技能可以调用模型调用技能，但绝不会调用另一个用户调用技能。

### Patch Changes

- [`47bde84`](https://github.com/mattpocock/skills/commit/47bde84da032afb2e5058f997f3bbca47d321dbd) Thanks [@mattpocock](https://github.com/mattpocock)! - 收紧 **`review`** 技能：快速失败的 ref 检查、单一来源的规则，以及削减无操作（no-op）。
