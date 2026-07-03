# 撰写智能体简报

智能体简报是在 GitHub issue 或 PR 转入 `ready-for-agent` 时发布于其上的一条结构化评论。它是 AFK 智能体据以工作的权威规格说明。原始正文和讨论只是上下文——智能体简报才是契约。

简报陈述**智能体应该做什么**，这延伸到两种载体：对于 issue，就是从零构建这项改动；对于 PR，则是*对现有 diff*还剩下什么要做——完成它、补齐缺口、处理评审意见。两种情况原则相同；下面的 PR 示例展示了差异。

## 原则

### 持久性优先于精确性

issue 可能在 `ready-for-agent` 中停留数天或数周。在此期间代码库会发生变化。撰写简报时要让它即便在文件被重命名、移动或重构后仍然有用。

- **要**描述接口、类型和行为契约
- **要**点名智能体应查找或修改的具体类型、函数签名或配置形态
- **不要**引用文件路径——它们会过时
- **不要**引用行号
- **不要**假设当前的实现结构会保持不变

### 面向行为，而非面向过程

描述系统应**做什么**，而不是**如何**实现。智能体会重新探索代码库并做出自己的实现决策。

- **好：** “`SkillConfig` 类型应接受一个可选的 `schedule` 字段，类型为 `CronExpression`”
- **差：** “打开 src/types/skill.ts，在第 42 行加一个 schedule 字段”
- **好：** “当用户不带参数运行 `/triage` 时，他们应看到一份需要关注的 issue 摘要”
- **差：** “在主处理函数里加一个 switch 语句”

### 完整的验收标准

智能体需要知道何时算完成。每份智能体简报都必须有具体的、可测试的验收标准。每条标准都应可独立验证。

- **好：** “运行 `gh issue list --label needs-triage` 会返回已经过初步分类的 issue”
- **差：** “分诊应正确工作”

### 明确的范围边界

陈述什么在范围之外。这可以防止智能体过度镀金，或对相邻功能做出假设。

## 模板

```markdown
## Agent Brief

**Category:** bug / enhancement
**Summary:** 一句话描述需要发生什么

**Current behavior:**
描述现在会发生什么。对于缺陷，这是坏掉的行为。
对于增强，这是该功能所基于的现状。

**Desired behavior:**
描述智能体完成工作后应发生什么。
对边界情况和错误条件要具体。

**Key interfaces:**
- `TypeName` —— 需要改什么以及为什么
- `functionName()` 返回类型 —— 它当前返回什么，对比它应返回什么
- 配置形态 —— 需要的任何新配置选项

**Acceptance criteria:**
- [ ] 具体的、可测试的标准 1
- [ ] 具体的、可测试的标准 2
- [ ] 具体的、可测试的标准 3

**Out of scope:**
- 本 issue 中不应改动或处理的事项
- 可能看起来相关但其实独立的相邻功能
```

## 示例

### 好的智能体简报（缺陷）

```markdown
## Agent Brief

**Category:** bug
**Summary:** 技能描述截断会从词中间断开，产生破损的输出

**Current behavior:**
当技能描述超过 1024 个字符时，它会被精确地在
1024 个字符处截断，而不顾及词边界。这会产生
从词中间结束的描述（例如 "Use when the user wants to confi"）。

**Desired behavior:**
截断应在 1024 字符之前的最后一个词边界处断开，
并追加 "..." 以表示发生了截断。

**Key interfaces:**
- `SkillMetadata` 类型的 `description` 字段 —— 无需更改类型，
  但填充它的校验/处理逻辑需要尊重词边界
- 任何读取 SKILL.md frontmatter 并提取描述的函数

**Acceptance criteria:**
- [ ] 不足 1024 字符的描述保持不变
- [ ] 超过 1024 字符的描述在 1024 字符之前的最后一个词边界处截断
- [ ] 被截断的描述以 "..." 结尾
- [ ] 包含 "..." 在内的总长度不超过 1024 字符

**Out of scope:**
- 更改 1024 字符限制本身
- 支持多行描述
```

### 好的智能体简报（增强）

```markdown
## Agent Brief

**Category:** enhancement
**Summary:** 添加 `.out-of-scope/` 目录支持，用于跟踪被拒绝的功能请求

**Current behavior:**
当一个功能请求被拒绝时，issue 会被打上 `wontfix` 标签并附评论后关闭。
对该决策或其理由没有持久记录。
未来类似的请求需要维护者回忆或搜索
先前的讨论。

**Desired behavior:**
被拒绝的功能请求应记录在 `.out-of-scope/<concept>.md`
文件中，这些文件记录该决策、理由，以及指向所有
请求该功能的 issue 的链接。在分诊新 issue 时，应
检查这些文件是否有匹配。

**Key interfaces:**
- `.out-of-scope/` 中的 Markdown 文件格式 —— 每个文件应有一个
  `# Concept Name` 标题、一行 `**Decision:**`、一行 `**Reason:**`，
  以及一个带 issue 链接的 `**Prior requests:**` 列表
- 分诊工作流应尽早读取所有 `.out-of-scope/*.md` 文件，
  并按概念相似度将传入的 issue 与之匹配

**Acceptance criteria:**
- [ ] 将某功能作为 wontfix 关闭时，会在 `.out-of-scope/` 中创建/更新一个文件
- [ ] 该文件包含决策、理由，以及指向被关闭 issue 的链接
- [ ] 如果已存在匹配的 `.out-of-scope/` 文件，则将新 issue
      追加到其 "Prior requests" 列表，而不是创建重复项
- [ ] 分诊期间，当新 issue 与先前的拒绝匹配时，会检查并浮现
      已有的 `.out-of-scope/` 文件

**Out of scope:**
- 自动匹配（由人类确认匹配）
- 重开先前被拒绝的功能
- 缺陷报告（只有增强类的拒绝才进入 `.out-of-scope/`）
```

### 好的智能体简报（PR）

对于 PR，“Current behavior”描述 diff 的状态，且简报要求智能体去完成或修复它，而不是从头构建。

```markdown
## Agent Brief

**Category:** enhancement
**Summary:** 完成贡献者为 `triage list` 添加的 `--json` 输出标志

**Current behavior:**
该 PR 添加了一个 `--json` 标志，将 issue 列表序列化为 JSON。顺利
路径可用，且 diff 符合项目的命令结构。还剩两处缺口：
错误仍以人类可读文本（而非 JSON）打印，且这个新标志
没有测试覆盖。

**Desired behavior:**
在 `--json` 下，所有输出——包括错误——都是 stdout 上格式良好的 JSON，
且命令的退出码保持不变。当该标志缺席时，现有的人类可读输出
不受影响。

**Key interfaces:**
- 在 `--json` 下，命令的错误路径应发出 `{ "error": string }`
  而非纯文本错误
- 复用该 PR 已添加的现有序列化器；不要再引入第二个

**Acceptance criteria:**
- [ ] `triage list --json` 对成功和错误两种情况都发出有效的 JSON
- [ ] 退出码与非 JSON 命令一致
- [ ] 有一个测试覆盖 `--json` 成功输出和一种错误情况
- [ ] 默认（非 JSON）输出逐字节保持不变

**Out of scope:**
- 为任何其他命令添加 `--json`
- 更改该 PR 已定义的成功负载的 JSON 形态
```

### 坏的智能体简报

```markdown
## Agent Brief

**Summary:** 修复分诊的 bug

**What to do:**
分诊那个东西坏了。看一下主文件把它修好。
第 150 行附近的函数有问题。

**Files to change:**
- src/triage/handler.ts (line 150)
- src/types.ts (line 42)
```

这很糟糕，因为：
- 没有类别
- 描述含糊（“分诊那个东西坏了”）
- 引用了会过时的文件路径和行号
- 没有验收标准
- 没有范围边界
- 没有描述当前行为与期望行为的对比
