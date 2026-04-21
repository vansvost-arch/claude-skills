#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────────────────────
# install.sh — Claude Code Skills Installer
# Copies all skills to ~/.claude/skills/ and installs the superpowers plugin.
# Safe to re-run: never overwrites existing config files.
# ──────────────────────────────────────────────────────────────────────────────
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$REPO_DIR/skills"
SKILLS_DST="$HOME/.claude/skills"
CLAUDE_GLOBAL="$HOME/.claude/CLAUDE.md"

echo "╔══════════════════════════════════════════╗"
echo "║   Claude Code Skills — Team Installer    ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# ── 1. Ensure ~/.claude/skills exists ────────────────────────────────────────
mkdir -p "$SKILLS_DST"

# ── 2. Copy custom skills (never overwrite existing config files) ─────────────
echo "▶ Installing custom skills..."
for skill_dir in "$SKILLS_SRC"/*/; do
  skill="$(basename "$skill_dir")"
  rsync -a \
    --exclude="cache/*.json" \
    --exclude="cache/*.jsonl" \
    --ignore-existing \
    "$skill_dir" "$SKILLS_DST/$skill/"
  echo "  ✓ $skill"
done
echo ""

# ── 3. Install superpowers plugin (provides 14 core workflow skills) ──────────
if command -v claude &>/dev/null; then
  echo "▶ Installing superpowers plugin..."
  claude plugin install superpowers@superpowers-marketplace 2>&1 | grep -v "^$" || true
  echo ""
else
  echo "⚠ 'claude' CLI not found — install Claude Code first, then run:"
  echo "    claude plugin install superpowers@superpowers-marketplace"
  echo ""
fi

# ── 4. Install global CLAUDE.md (skill routing policy) ───────────────────────
echo "▶ Installing global CLAUDE.md..."
if [ -f "$CLAUDE_GLOBAL" ]; then
  echo "  ℹ ~/.claude/CLAUDE.md already exists — skipping (review GLOBAL_CLAUDE.md manually)"
else
  cp "$REPO_DIR/GLOBAL_CLAUDE.md" "$CLAUDE_GLOBAL"
  echo "  ✓ Installed to ~/.claude/CLAUDE.md"
fi
echo ""

# ── 5. Done ───────────────────────────────────────────────────────────────────
echo "✅ Done! Skills installed to $SKILLS_DST"
echo ""
echo "Next steps:"
echo "  1. For skills with API keys (yandex-search-api, yandex-metrika, yandex-wordstat):"
echo "     copy the .example config files and fill in your credentials."
echo "     See skills/<skill-name>/config/README.md for instructions."
echo ""
echo "  2. Start Claude Code in any project — skills are active immediately."
