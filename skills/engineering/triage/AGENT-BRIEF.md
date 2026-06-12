# 撰写 Agent 简报

agent 简报是当一个 GitHub issue 移动到 `ready-for-agent` 时，发布在该 issue 上的一条结构化评论。它是 AFK agent 将据以工作的权威规范。原始的 issue 正文和讨论是上下文——agent 简报才是契约。

## 原则

### 持久性优先于精确性

该 issue 可能会在 `ready-for-agent` 状态停留数天或数周。在此期间代码库会发生变化。撰写简报时要让它即使在文件被重命名、移动或重构后仍然有用。

- **要**描述接口、类型和行为契约
- **要**点名 agent 应当查找或修改的具体类型、函数签名或配置形状
- **不要**引用文件路径——它们会过时
- **不要**引用行号
- **不要**假设当前的实现结构会保持不变

### 描述行为，而非过程

描述系统应当**做什么**，而非**如何**实现。agent 会重新探索代码库并做出自己的实现决策。

- **好：** "`SkillConfig` 类型应当接受一个可选的 `schedule` 字段，类型为 `CronExpression`"
- **差：** "打开 src/types/skill.ts，在第 42 行添加一个 schedule 字段"
- **好：** "当用户运行不带参数的 `/triage` 时，他们应当看到一份需要关注的 issue 摘要"
- **差：** "在主处理函数中添加一个 switch 语句"

### 完整的验收标准

agent 需要知道何时算完成。每份 agent 简报都必须有具体、可测试的验收标准。每条标准都应当能被独立验证。

- **好：** "运行 `gh issue list --label needs-triage` 返回的是已经过初步分类的 issue"
- **差：** "triage 应当正常工作"

### 明确的范围边界

说明什么是范围之外的。这能防止 agent 镀金（过度实现）或对相邻功能做出假设。

## 模板

```markdown
## Agent Brief

**Category:** bug / enhancement
**Summary:** one-line description of what needs to happen

**Current behavior:**
Describe what happens now. For bugs, this is the broken behavior.
For enhancements, this is the status quo the feature builds on.

**Desired behavior:**
Describe what should happen after the agent's work is complete.
Be specific about edge cases and error conditions.

**Key interfaces:**
- `TypeName` — what needs to change and why
- `functionName()` return type — what it currently returns vs what it should return
- Config shape — any new configuration options needed

**Acceptance criteria:**
- [ ] Specific, testable criterion 1
- [ ] Specific, testable criterion 2
- [ ] Specific, testable criterion 3

**Out of scope:**
- Thing that should NOT be changed or addressed in this issue
- Adjacent feature that might seem related but is separate
```

## 示例

### 好的 agent 简报（bug）

```markdown
## Agent Brief

**Category:** bug
**Summary:** Skill description truncation drops mid-word, producing broken output

**Current behavior:**
When a skill description exceeds 1024 characters, it is truncated at exactly
1024 characters regardless of word boundaries. This produces descriptions
that end mid-word (e.g. "Use when the user wants to confi").

**Desired behavior:**
Truncation should break at the last word boundary before 1024 characters
and append "..." to indicate truncation.

**Key interfaces:**
- The `SkillMetadata` type's `description` field — no type change needed,
  but the validation/processing logic that populates it needs to respect
  word boundaries
- Any function that reads SKILL.md frontmatter and extracts the description

**Acceptance criteria:**
- [ ] Descriptions under 1024 chars are unchanged
- [ ] Descriptions over 1024 chars are truncated at the last word boundary
      before 1024 chars
- [ ] Truncated descriptions end with "..."
- [ ] The total length including "..." does not exceed 1024 chars

**Out of scope:**
- Changing the 1024 char limit itself
- Multi-line description support
```

### 好的 agent 简报（enhancement）

```markdown
## Agent Brief

**Category:** enhancement
**Summary:** Add `.out-of-scope/` directory support for tracking rejected feature requests

**Current behavior:**
When a feature request is rejected, the issue is closed with a `wontfix` label
and a comment. There is no persistent record of the decision or reasoning.
Future similar requests require the maintainer to recall or search for the
prior discussion.

**Desired behavior:**
Rejected feature requests should be documented in `.out-of-scope/<concept>.md`
files that capture the decision, reasoning, and links to all issues that
requested the feature. When triaging new issues, these files should be
checked for matches.

**Key interfaces:**
- Markdown file format in `.out-of-scope/` — each file should have a
  `# Concept Name` heading, a `**Decision:**` line, a `**Reason:**` line,
  and a `**Prior requests:**` list with issue links
- The triage workflow should read all `.out-of-scope/*.md` files early
  and match incoming issues against them by concept similarity

**Acceptance criteria:**
- [ ] Closing a feature as wontfix creates/updates a file in `.out-of-scope/`
- [ ] The file includes the decision, reasoning, and link to the closed issue
- [ ] If a matching `.out-of-scope/` file already exists, the new issue is
      appended to its "Prior requests" list rather than creating a duplicate
- [ ] During triage, existing `.out-of-scope/` files are checked and surfaced
      when a new issue matches a prior rejection

**Out of scope:**
- Automated matching (human confirms the match)
- Reopening previously rejected features
- Bug reports (only enhancement rejections go to `.out-of-scope/`)
```

### 差的 agent 简报

```markdown
## Agent Brief

**Summary:** Fix the triage bug

**What to do:**
The triage thing is broken. Look at the main file and fix it.
The function around line 150 has the issue.

**Files to change:**
- src/triage/handler.ts (line 150)
- src/types.ts (line 42)
```

它差在：
- 没有类别
- 描述含糊（"the triage thing is broken"）
- 引用了会过时的文件路径和行号
- 没有验收标准
- 没有范围边界
- 没有描述当前行为与期望行为的对比
