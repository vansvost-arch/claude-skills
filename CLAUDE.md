# Claude Code Skills — Auto-Installer

This repository contains Claude Code skills and configuration.
When asked to "install skills" or "set up Claude", follow these steps exactly.

## Your task

Install all skills from this repository onto the user's machine.

### Step 1 — Run install.sh

```bash
bash install.sh
```

This script:
- Copies all skills from `skills/` → `~/.claude/skills/`
- Installs the superpowers plugin via `claude plugin install`
- Installs `GLOBAL_CLAUDE.md` as `~/.claude/CLAUDE.md` (if not already present)

### Step 2 — Verify installation

After running install.sh, confirm:
```bash
ls ~/.claude/skills/ | wc -l    # should be 40+
claude plugin list               # should show superpowers
```

### Step 3 — Skills requiring API keys

Some skills need credentials configured before they work.
For each of these, copy the example config and fill in credentials:

**yandex-search-api** (Yandex Cloud search):
```bash
cd ~/.claude/skills/yandex-search-api
cp config/config.example.json config/config.json
# Edit config/config.json — add yandex_cloud_folder_id
# Add config/service_account_key.json from Yandex Cloud console
```

**yandex-metrika** (Yandex Analytics):
```bash
# See ~/.claude/skills/yandex-metrika/config/README.md
```

**yandex-wordstat** (keyword research):
```bash
# See ~/.claude/skills/yandex-wordstat/config/README.md
```

**codex-review** (cross-agent review with GPT/Codex):
```bash
cd ~/.claude/skills/codex-review
cp config/defaults.env.example config/defaults.env
# Edit config/defaults.env — add OPENAI_API_KEY
```

### Step 4 — Confirm to user

Tell the user:
- How many skills were installed
- Which skills need API key configuration
- That they should restart Claude Code to pick up the new `~/.claude/CLAUDE.md`
