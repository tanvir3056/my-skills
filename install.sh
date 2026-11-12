#!/usr/bin/env bash
# Links every skill in this repo into each Claude Code account on this Mac.
# Safe to run again. Update later with: git -C ~/my-skills pull
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

# Claude account folders to install into. Only folders that exist are used.
candidates=("$HOME/.claude" "$HOME/.claude-main")
if [ -n "${CLAUDE_CONFIG_DIR:-}" ]; then
  candidates+=("$CLAUDE_CONFIG_DIR")
fi

dirs=()
for d in "${candidates[@]}"; do
  [ -d "$d" ] || continue
  real="$(cd "$d" && pwd -P)"
  case " ${dirs[*]-} " in *" $real "*) continue ;; esac
  dirs+=("$real")
done

if [ "${#dirs[@]}" -eq 0 ]; then
  echo "STOP: no Claude folder found (~/.claude or ~/.claude-main). Start Claude Code once, then run this again."
  exit 1
fi

skills=()
for f in "$REPO"/*/SKILL.md; do
  [ -e "$f" ] || continue
  skills+=("$(basename "$(dirname "$f")")")
done

for d in "${dirs[@]}"; do
  echo "Account folder: $d"
  mkdir -p "$d/skills"
  for s in "${skills[@]}"; do
    target="$d/skills/$s"
    if [ -L "$target" ]; then
      rm "$target"
    elif [ -e "$target" ]; then
      # Keep the old copy outside the skills folder, so Claude does not load it twice.
      mkdir -p "$d/skills-backup"
      mv "$target" "$d/skills-backup/$s-$STAMP"
      echo "  Old copy kept: $d/skills-backup/$s-$STAMP"
    fi
    ln -s "$REPO/$s" "$target"
    echo "  Linked: $s"
  done
done

echo
echo "Done. Start a new Claude session to load the skills."
