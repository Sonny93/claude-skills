#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/Sonny93/claude-skills.git"
REPO_DIR="$HOME/.claude/skills-repo"
SKILLS_DIR="$HOME/.claude/skills"

mkdir -p "$SKILLS_DIR"

if [ -d "$REPO_DIR/.git" ]; then
  git -C "$REPO_DIR" pull --ff-only
else
  git clone "$REPO_URL" "$REPO_DIR"
fi

for skill_path in "$REPO_DIR"/*/; do
  name="$(basename "$skill_path")"
  target="$SKILLS_DIR/$name"

  if [ -L "$target" ]; then
    continue
  fi

  if [ -e "$target" ]; then
    echo "skip $name: $target existe deja et n'est pas un symlink"
    continue
  fi

  ln -s "$skill_path" "$target"
  echo "linked $name"
done
