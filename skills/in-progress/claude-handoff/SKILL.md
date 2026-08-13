---
name: claude-handoff
description: 把当前对话移交给一个全新的后台 agent，它会立即接手工作。
argument-hint: "下一个会话将用于做什么？"
disable-model-invocation: true
---

写一份当前对话的移交摘要，好让一个全新的 agent 能继续这项工作。不要把它保存下来，而是启动一个后台 agent，以这份摘要作为它的 prompt 种子：`claude --bg --name "<descriptive name>" "<handoff summary>"`。它会在当前工作目录中启动并立即返回；用户用 `claude agents` 来管理它。

始终传入 `-n`/`--name` 并给一个描述性名称（例如 `--name "Fix login bug"`）——它设置的是在任务列表、会话选择器和终端标题中显示的名称。

在摘要中包含一个 "suggested skills" 部分，用来建议该 agent 应当调用的技能。

不要重复那些已经被其他产物（规格、计划、ADR、issue、commit、diff）记录过的内容。改为通过路径或 URL 引用它们。

删改任何敏感信息，例如 API key、密码或个人可识别信息——这份摘要会成为 agent 的 prompt。

如果用户传入了参数，就把它们当作对下一个会话将聚焦什么的描述，并据此调整摘要。
