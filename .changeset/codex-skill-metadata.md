---
"mattpocock-skills": minor
---

在每个技能的 Claude Code frontmatter 旁边添加 Codex 元数据，让这套技能在两个框架中都能工作，且无需生成副本。

- 在每个 `SKILL.md` 旁边添加一个 `agents/openai.yaml`，携带 Codex 的 UI 元数据（`interface.display_name`、`interface.short_description`）。
- 给每个用户调用型技能标记 `policy.allow_implicit_invocation: false`，即 `disable-model-invocation: true` 在 Codex 中的对应项，从而让 Codex 把它排除在隐式调用之外，而显式的 `$skill` 调用依然有效。
- 在 `.agents/invocation.md`、`CLAUDE.md` 以及已推广桶的 README 中记录双框架调用模型。
- 添加 `AGENTS.md` 作为指向 `CLAUDE.md` 的符号链接，让 Codex 读取同一份仓库说明。
