# Yandex Wordstat Analysis Tool

This skill enables search demand analysis via Yandex Wordstat API. Key capabilities:

## Core Features
- Top keyword queries (up to 2,000 results)
- Semantic associations & expansion
- Regional/seasonal demand analysis
- CSV export for large datasets
- Missed demand analysis via Яндекс Директ XLSX exports

## Critical Workflow

Before any analysis, always:
1. **Ask for target region** and wait for response
2. **Clarify what's being sold** to filter non-target demand
3. **Verify search intent via WebSearch** for every promising query

Never proceed without knowing the region and business context.

## Intent Verification (Mandatory)

**Before marking ANY query as 'target', verify intent via WebSearch!**

High query volume ≠ quality traffic. Distinguish:
- ✅ Target: user wants to **buy your product**
- ❌ Non-target: user wants an accessory, DIY solution, or information

**Red flag patterns:**
- Contains "для [your product]" → buyer wants an accessory, not the product
- "своими руками" / "как сделать" → informational intent, not purchase
- Repair/maintenance terms → existing owner, not new buyer
- Example: "каолиновая вата для дымохода" → NOT a chimney buyer, they want 500₽ insulation wool

## Key Scripts

| Script | Purpose |
|--------|---------|
| `scripts/quota.sh` | Check API connection and token validity |
| `scripts/top_requests.sh` | Fetch top phrases by frequency (up to 2000) |
| `scripts/dynamics.sh` | Trend analysis over time (monthly/weekly/daily) |
| `scripts/regions_stats.sh` | Geographic distribution of demand |
| `scripts/search_region.sh` | Find region ID by city name |
| `scripts/regions_tree.sh` | List all common region IDs |
| `scripts/query_total.sh` | Get totalCount for OR-query (missed demand) |
| `scripts/get_token.sh` | Setup OAuth token interactively |

## Wordstat Operators

- `"phrase"` — exact phrase match only
- `!word` — fixes word form (no morphology)
- `-word` — excludes term
- `(a|b)` — groups variants (OR)

## API Limits

- 10 requests/second, 1,000 requests/day
- Requires `YANDEX_WORDSTAT_TOKEN` in `config/.env`

## Setup

1. Get API access: https://yandex.ru/support2/wordstat/ru/content/api-wordstat
2. Submit the form at the bottom of the page to unlock API
3. Get OAuth token: `bash scripts/get_token.sh --client-id YOUR_CLIENT_ID`
4. Token saved automatically to `config/.env`
5. Verify: `bash scripts/quota.sh`

## Standard Analysis Workflow

1. Run `scripts/quota.sh` to verify connection
2. Run `scripts/top_requests.sh --phrase "ключевой запрос" --limit 200`
3. Group results by intent using WebSearch verification
4. Run `scripts/dynamics.sh` for seasonal patterns
5. Run `scripts/regions_stats.sh` for geographic distribution
6. Report with **целевые** (target) vs **нецелевые** (non-target) split with reasoning

## Missed Demand Analysis (Яндекс Директ)

Use `MISSED_DEMAND.md` for full workflow when analyzing existing ad campaigns.
Requires XLSX export from Яндекс Директ with "Тексты" sheet.

## Report Format

Always separate results into:
- **Целевые запросы** — target queries with purchase intent, sorted by volume
- **Нецелевые запросы** — non-target with explanation of why they're excluded
- **Сезонность** — seasonal patterns if dynamics were checked
- **Регионы** — top regions if geographic analysis was done
