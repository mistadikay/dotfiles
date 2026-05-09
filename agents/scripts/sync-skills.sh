#!/usr/bin/env bash
#
# Symlink shared skills into local agent harnesses.

set -euo pipefail

agents_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src="$agents_dir/skills"
old_src="$HOME/.dotfiles/agent-skills/skills"
dry_run=false

for arg in "$@"; do
  case "$arg" in
    --dry-run)
      dry_run=true
      ;;
    *)
      echo "Unknown sync-skills option: $arg" >&2
      exit 2
      ;;
  esac
done

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

# OpenCode discovers ~/.claude/skills globally, so we do not create duplicate
# native OpenCode links.
destinations=(
  "$HOME/.claude/skills"
  "$HOME/.codex/skills"
)

echo "Syncing agent skills"

for dest in "${destinations[@]}"; do
  if [ "$dry_run" = false ]; then
    mkdir -p "$dest"
  elif [ ! -d "$dest" ]; then
    echo "Would create $dest"
  fi

  echo "Linking to $dest:"

  if [ -d "$dest" ]; then
    for target_path in "$dest"/*; do
      [ -L "$target_path" ] || continue
      link_target="$(readlink "$target_path")"
      case "$link_target" in
        "$src"/*|"$old_src"/*)
          if [ ! -e "$target_path" ] || [ ! -e "$link_target" ]; then
            if [ "$dry_run" = true ]; then
              echo "  - would remove stale $(basename "$target_path")"
            else
              rm -f "$target_path"
            fi
          fi
          ;;
      esac
    done
  fi

  for skill in "${skills[@]}"; do
    source_path="$src/$skill"
    target_path="$dest/$skill"

    if [ ! -d "$source_path" ]; then
      echo "Missing skill: $source_path" >&2
      exit 1
    fi

    if [ -L "$target_path" ]; then
      if [ "$(readlink "$target_path")" = "$source_path" ]; then
        echo "  - $skill"
        continue
      fi

      if [ "$dry_run" = true ]; then
        echo "  - $skill would be relinked"
        continue
      fi

      rm -f "$target_path"
    elif [ -e "$target_path" ]; then
      echo "  - $skill skipped; $target_path already exists and is not a symlink"
      continue
    fi

    if [ "$dry_run" = true ]; then
      echo "  - $skill would be linked"
      continue
    fi

    ln -s "$source_path" "$target_path"
    echo "  - $skill"
  done
done
