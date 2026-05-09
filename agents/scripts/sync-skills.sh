#!/usr/bin/env bash
#
# Symlink shared skills into local agent harnesses.

set -euo pipefail

agents_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
repo_dir="$(cd "$agents_dir/.." && pwd)"
src="$agents_dir/skills"
old_src="$HOME/.dotfiles/agent-skills/skills"
expo_skills_repo="$agents_dir/sources/expo-skills"
expo_skills_src="$expo_skills_repo/plugins/expo/skills"
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

sync_external_sources() {
  echo "Updating external skill sources"

  if [ "$dry_run" = true ]; then
    echo "  - would update agents/sources/expo-skills"
    return
  fi

  git -C "$repo_dir" submodule update --init --remote --merge agents/sources/expo-skills
}

has_skill() {
  local candidate="$1"
  local existing
  local index

  for ((index = 0; index < ${#skills[@]}; index++)); do
    existing="${skills[$index]}"
    if [ "$existing" = "$candidate" ]; then
      return 0
    fi
  done

  return 1
}

add_skill_source() {
  local source_root="$1"
  local source_path
  local skill

  [ -d "$source_root" ] || return

  managed_roots+=("$source_root")

  for source_path in "$source_root"/*/; do
    [ -d "$source_path" ] || continue
    skill="${source_path%/}"
    skill="${skill##*/}"

    if has_skill "$skill"; then
      echo "Duplicate skill skipped from $source_root: $skill" >&2
      continue
    fi

    skills+=("$skill")
    skill_paths+=("$source_root/$skill")
  done
}

is_managed_link_target() {
  local link_target="$1"
  local root

  for root in "${managed_roots[@]}"; do
    case "$link_target" in
      "$root"/*)
        return 0
        ;;
    esac
  done

  return 1
}

sync_external_sources

skills=()
skill_paths=()
managed_roots=("$old_src")

add_skill_source "$src"
add_skill_source "$expo_skills_src"

if [ "${#skills[@]}" -eq 0 ]; then
  echo "No skills found in configured skill sources" >&2
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

      if is_managed_link_target "$link_target" && { [ ! -e "$target_path" ] || [ ! -e "$link_target" ]; }; then
        if [ "$dry_run" = true ]; then
          echo "  - would remove stale $(basename "$target_path")"
        else
          rm -f "$target_path"
        fi
      fi
    done
  fi

  for index in "${!skills[@]}"; do
    skill="${skills[$index]}"
    source_path="${skill_paths[$index]}"
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
