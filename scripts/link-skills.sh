#!/usr/bin/env bash
set -euo pipefail

# 注意：这是一个仅供开发使用的脚本，面向本仓库的维护者。
# 它不是受支持的安装程序。对它的修改——或修改它的请求——
# 都不会被批准。
#
# 将仓库中的所有技能链接到各个 agent harness 所使用的本地技能目录：
#   - ~/.claude/skills  — Claude Code
#   - ~/.agents/skills  — Codex 及其他兼容 Agent Skills 的 harness
# 每一项都是指向本仓库的符号链接，因此只需一次 `git pull`
# 就能让已安装的技能保持最新。

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DESTS=("$HOME/.claude/skills" "$HOME/.agents/skills")

# 一次性收集仓库中的技能，链接到每个目标目录。
names=()
srcs=()
while IFS= read -r -d '' skill_md; do
  src="$(dirname "$skill_md")"
  names+=("$(basename "$src")")
  srcs+=("$src")
done < <(find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -not -path '*/deprecated/*' -print0)

for DEST in "${DESTS[@]}"; do
  # 如果 $DEST 是一个解析后指向本仓库的符号链接，我们最终会把
  # 各个技能的符号链接写回仓库自身的 skills/ 目录树。此时进行检测并
  # 退出，而不是污染工作副本。
  if [ -L "$DEST" ]; then
    resolved="$(readlink -f "$DEST")"
    case "$resolved" in
      "$REPO"|"$REPO"/*)
        echo "error: $DEST is a symlink into this repo ($resolved)." >&2
        echo "Remove it (rm \"$DEST\") and re-run; the script will recreate it as a real dir." >&2
        exit 1
        ;;
    esac
  fi

  mkdir -p "$DEST"

  for i in "${!names[@]}"; do
    name="${names[$i]}"
    src="${srcs[$i]}"
    target="$DEST/$name"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
      rm -rf "$target"
    fi

    ln -sfn "$src" "$target"
    echo "linked $name -> $src ($DEST)"
  done
done
