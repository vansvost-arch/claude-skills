# Claude Code Skills — Team Setup

This repository contains the full Claude Code skill configuration used by the team.
Clone it once, run the installer, and Claude Code will behave identically to the reference setup.

## What's included

### Custom skills (32) — copied to `~/.claude/skills/`

| Skill | What it does |
|-------|-------------|
| `5whys` | Root cause analysis via 5 Whys method |
| `antv-g2-chart` | AntV G2 chart generation |
| `antv-s2-expert` | AntV S2 spreadsheet/pivot expert |
| `brainstorming` | *(via superpowers plugin)* Idea → design → plan workflow |
| `chart-visualization` | Data → chart via AntV API |
| `codex-review` | Cross-agent review: Claude implements, GPT reviews |
| `customer-value-audit` | Customer value analysis framework |
| `cynefin` | Complexity framework for problem classification |
| `feynman` | Deep explanation via Feynman technique |
| `frontend-design` | Distinctive UI design with production-grade code |
| `grill-me` | Clarification drill for ambiguous tasks |
| `icon-retrieval` | Find and retrieve icons |
| `infographic-creator` | Data → infographic |
| `mcp-builder` | Build MCP servers |
| `meta-review-plan` | Meta-level plan review |
| `narrative-text-visualization` | Text → visual narrative |
| `ooda` | OODA loop for real-time decisions |
| `pipeline-runner` | Pipeline execution skill |
| `premortem` | Pre-mortem risk analysis |
| `redteam` | Adversarial / security analysis |
| `socratic` | Assumption examination via Socratic questioning |
| `ssh-remote-connection` | SSH remote server connection helper |
| `supplier-search` | B2B supplier research workflow |
| `tdcompass-seo-enrichment` | SEO enrichment for TDCompass catalog |
| `tdd` | Test-driven development deep guide |
| `tenderplan-api` | Tenderplan (tenderplan.ru) REST API — tenders, keys, marks, comments, orgs, ЕГРЮЛ/РНП, cursors |
| `web-artifacts-builder` | Build shareable web artifacts |
| `webapp-testing` | Web application testing workflow |
| `wrap` | Decision wrap-up for risky choices |
| `yandex-direct-ads` | Yandex Direct ad management |
| `yandex-metrika` | Yandex Metrika analytics via API |
| `yandex-search-api` | Yandex Cloud search API integration |
| `yandex-wordstat` | Yandex Wordstat keyword research |

### Superpowers plugin (14 skills) — installed via `claude plugin install`

`brainstorming` · `dispatching-parallel-agents` · `executing-plans` ·
`finishing-a-development-branch` · `receiving-code-review` · `requesting-code-review` ·
`subagent-driven-development` · `systematic-debugging` · `test-driven-development` ·
`using-git-worktrees` · `using-superpowers` · `verification-before-completion` ·
`writing-plans` · `writing-skills`

### Global skill routing (`GLOBAL_CLAUDE.md` → `~/.claude/CLAUDE.md`)

Defines when Claude Code invokes which skill automatically:
- Bug/unexpected behavior → `systematic-debugging`
- Ambiguous task → `brainstorming` or `grill-me`
- New feature → `writing-plans` before coding
- Tests needed → `test-driven-development`
- Done? → `verification-before-completion`
- *(and more — see `GLOBAL_CLAUDE.md`)*

---

## Install

### Option A — One command (recommended)

```bash
git clone https://github.com/YOUR_ORG/claude-skills.git
cd claude-skills
bash install.sh
```

### Option B — Let Claude Code install for you

Clone the repo, then open Claude Code in that directory and say:

> "Install all skills from this repository"

Claude Code reads `CLAUDE.md` in this repo and runs the install automatically.

---

## Post-install: configure API-based skills

Some skills need credentials before they work:

### yandex-search-api
Requires a Yandex Cloud service account with Search API access.
```bash
cd ~/.claude/skills/yandex-search-api
cp config/config.example.json config/config.json
# Fill in: yandex_cloud_folder_id
# Add: config/service_account_key.json (from Yandex Cloud IAM)
```
→ Full setup: `~/.claude/skills/yandex-search-api/config/README.md`

### yandex-metrika
Requires Yandex OAuth token with Metrika access.
→ Setup: `~/.claude/skills/yandex-metrika/config/README.md`

### yandex-wordstat
Requires Yandex Direct OAuth token.
→ Setup: `~/.claude/skills/yandex-wordstat/config/README.md`

### codex-review
Requires OpenAI API key + Codex CLI installed.
```bash
cd ~/.claude/skills/codex-review
cp config/defaults.env.example config/defaults.env
# Fill in: OPENAI_API_KEY
```

### ssh-remote-connection
No config needed — uses your existing SSH config (`~/.ssh/`).

### tenderplan-api
Requires a Tenderplan Personal Access Token (PAT). Tokens are **only creatable via the
Tenderplan web UI** — the PAT-management API endpoints are reserved for first-party
clients. Walkthrough:

1. Log in at https://tenderplan.ru → `Настройки аккаунта` (top menu).
2. Tab `Интеграции с сервисами` → card **OpenAPI** → button `Настроить`.
3. Fill `Название токена`, tick `Подтверждаю разрешение на следующие действия`, then tick
   the scope checkboxes (e.g. `resources:external` + `relations:read` + `comments:read`
   for a read-only tender integration).
4. Click `Сгенерировать токен` — **the string is shown once**, copy it immediately.

Store it and expose it as the env var `TENDERPLAN_TOKEN`:
```bash
export TENDERPLAN_TOKEN="<paste>"
```

Verify the token works:
```bash
python3 ~/.claude/skills/tenderplan-api/scripts/tp_probe.py health
# → "health: OK (404 as expected — token works)"
```

→ Full scope table, OAuth flows and rate-limits: `~/.claude/skills/tenderplan-api/references/auth.md`

---

## Verify installation

```bash
# Count installed skills (should be 40+)
ls ~/.claude/skills/ | wc -l

# Check superpowers plugin
claude plugin list

# Check global CLAUDE.md
cat ~/.claude/CLAUDE.md | head -5
```

---

## Update

To pull the latest skills:
```bash
cd claude-skills
git pull
bash install.sh   # safe to re-run, never overwrites your configs
```

---

## Structure

```
claude-skills/
├── README.md           ← This file
├── CLAUDE.md           ← Auto-installer instructions for Claude Code
├── GLOBAL_CLAUDE.md    ← Global skill routing policy → ~/.claude/CLAUDE.md
├── install.sh          ← One-command installer
└── skills/
    ├── 5whys/
    │   └── SKILL.md
    ├── yandex-search-api/
    │   ├── SKILL.md
    │   ├── config/
    │   │   ├── README.md
    │   │   └── config.example.json   ← Copy → config.json and fill in keys
    │   └── scripts/
    │       └── *.sh
    └── ...
```

> **Note:** Real API keys and credentials are never stored in this repo.
> Only `.example` files are included — copy and fill in your own credentials.
