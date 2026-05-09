#!/usr/bin/env bash
#
# Symlink agent skills into local agent harnesses.

set -euo pipefail

src="$HOME/.dotfiles/agent-skills/skills"

skills=()
for source_path in "$src"/*/; do
  [ -d "$source_path" ] || continue
  skill="${source_path%/}"
  skills+=("${skill##*/}")
done

if [ "${#skills[@]}" -eq 0 ]; then
  echo "No skills found in $src" >&2
  exit 1
fi

# OpenCode also discovers ~/.claude/skills globally, so we do not create
# duplicate native OpenCode links.
destinations=(
  "$HOME/.claude/skills"
  "$HOME/.codex/skills"
)

echo "Installing agent skills"

for dest in "${destinations[@]}"; do
  mkdir -p "$dest"
  echo "Linking to $dest:"

  for skill in "${skills[@]}"; do
    source_path="$src/$skill"
    target_path="$dest/$skill"

    if [ ! -d "$source_path" ]; then
      echo "Missing skill: $source_path" >&2
      exit 1
    fi

    if [ -L "$target_path" ]; then
      rm -f "$target_path"
    elif [ -e "$target_path" ]; then
      echo "  - $skill skipped; $target_path already exists and is not a symlink"
      continue
    fi

    ln -s "$source_path" "$target_path"
    echo "  - $skill"
  done
done

printf "\n"
