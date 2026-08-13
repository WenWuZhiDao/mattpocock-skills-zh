#!/usr/bin/env bash
# 人在回路（human-in-the-loop）复现流程。
# 复制此文件，编辑下方步骤，然后运行它。
# 由智能体运行脚本；用户在自己的终端里按提示操作。
#
# 用法：
#   bash hitl-loop.template.sh
#
# 两个辅助函数：
#   step "<instruction>"          → 显示指令，等待回车
#   capture VAR "<question>"      → 显示问题，将回复读入 VAR
#
# 结束时，捕获到的值会以 KEY=VALUE 形式打印出来，供智能体解析。
#
# `capture` 会把它的值回显到终端，智能体从中读取——所以要捕获观察结果，
# 而把登录之类的操作作为 `step` 交给用户完成。

set -euo pipefail

step() {
  printf '\n>>> %s\n' "$1"
  read -r -p "    [Enter when done] " _
}

capture() {
  local var="$1" question="$2" answer
  printf '\n>>> %s\n' "$question"
  read -r -p "    > " answer
  printf -v "$var" '%s' "$answer"
}

# --- 在下方编辑 ---------------------------------------------------------

step "打开 http://localhost:3000 上的应用并登录。"

capture ERRORED "点击 'Export' 按钮。它是否抛出了错误？(y/n)"

capture ERROR_MSG "粘贴错误信息（若无则填 'none'）："

# --- 在上方编辑 ---------------------------------------------------------

printf '\n--- Captured ---\n'
printf 'ERRORED=%s\n' "$ERRORED"
printf 'ERROR_MSG=%s\n' "$ERROR_MSG"
