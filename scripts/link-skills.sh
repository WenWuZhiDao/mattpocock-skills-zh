#!/usr/bin/env bash
set -euo pipefail

# 注意：这是一个仅供开发使用的脚本，供本仓库的维护者使用。
# 它不是受支持的安装器。对它的修改——或修改请求——都不会被批准。
#
# 把仓库中所有技能链接进每个智能体 harness 所使用的本地技能目录：
#   - ~/.claude/skills  — Claude Code
#   - ~/.agents/skills  — pi 及其他符合 Agent-Skills 标准的 harness
# 每个条目都是指向本仓库的符号链接，因此只需 `git pull`
# 就能让已安装的技能保持最新。

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DESTS=("$HOME/.claude/skills" "$HOME/.agents/skills")

# 一次性收集仓库的技能，链接进每个目标目录。
names=()
srcs=()
while IFS= read -r -d '' skill_md; do
  src="$(dirname "$skill_md")"
  names+=("$(basename "$src")")
  srcs+=("$src")
done < <(find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -not -path '*/deprecated/*' -print0)

for DEST in "${DESTS[@]}"; do
  # 如果 $DEST 是一个解析后指向本仓库的符号链接，我们会把每个技能的
  # 符号链接写回仓库自己的 skills/ 树。检测到这种情况就直接退出，
  # 而不是污染工作副本。
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
