---
name: git-guardrails-claude-code
description: 设置 Claude Code 钩子，在危险的 git 命令（push、reset --hard、clean、branch -D 等）执行前将其拦截。当用户想阻止破坏性 git 操作、添加 git 安全钩子，或在 Claude Code 中拦截 git push/reset 时使用。
---

# 设置 Git 防护栏

设置一个 PreToolUse 钩子，在 Claude 执行危险的 git 命令之前将其拦截并阻止。

## 哪些命令会被阻止

- `git push`（包括 `--force` 在内的所有变体）
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

被阻止时，Claude 会看到一条消息，告知它无权访问这些命令。

## 步骤

### 1. 询问适用范围

询问用户：只为**当前项目**安装（`.claude/settings.json`），还是为**所有项目**安装（`~/.claude/settings.json`）？

### 2. 复制钩子脚本

随附脚本位于：[scripts/block-dangerous-git.sh](scripts/block-dangerous-git.sh)

根据适用范围将其复制到目标位置：

- **项目级**：`.claude/hooks/block-dangerous-git.sh`
- **全局级**：`~/.claude/hooks/block-dangerous-git.sh`

用 `chmod +x` 赋予可执行权限。

### 3. 在设置中添加钩子

添加到相应的设置文件：

**项目级**（`.claude/settings.json`）：

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/block-dangerous-git.sh"
          }
        ]
      }
    ]
  }
}
```

**全局级**（`~/.claude/settings.json`）：

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/block-dangerous-git.sh"
          }
        ]
      }
    ]
  }
}
```

如果设置文件已存在，将该钩子合并进现有的 `hooks.PreToolUse` 数组——不要覆盖其他设置。

### 4. 询问是否自定义

询问用户是否想从阻止列表中添加或移除某些模式。相应地编辑复制后的脚本。

### 5. 验证

运行一个快速测试：

```bash
echo '{"tool_input":{"command":"git push origin main"}}' | <path-to-script>
```

应以退出码 2 退出，并向 stderr 打印一条 BLOCKED 消息。
