---
name: tenderplan-api
description: |
  Work with the Tenderplan (tenderplan.ru) REST API — Russian state/commercial procurement data:
  tenders, ключи/поиски, метки, комментарии (Draft.js), вложения, задачи, уведомления,
  заказчики/поставщики, ЕГРЮЛ/РНП, аналитика, cursor-based streaming, OAuth + PAT.
  Use this whenever the user touches anything related to tenderplan.ru, the Тендерплан API,
  any `/api/tenders`, `/api/keys`, `/api/marks`, `/api/search`, `/api/comments`, `/api/organizations`
  endpoint, the TENDERPLAN_TOKEN env var, or needs to read/write Tenderplan entities.
  Triggers: Tenderplan, Тендерплан, tenderplan.ru, api/tenders, api/keys, ObjectInfo,
  Objects tb, placingWay, РНП Тендерплан, ЕГРЮЛ по API, НМЦ тендер, Draft.js комментарий,
  резолв тендера по ID, cursor тендеров, PAT Тендерплан, resources:external, relations:read.
---

# Tenderplan REST API — Complete Reference

Full OpenAPI spec: `references/swagger.json` (4 MB, 374 paths, 43 tags, version 3.5.0).
Full endpoint catalog (grouped by tag): `references/endpoints.md`.
Detailed request/response schemas for ~150 core endpoints: `references/schemas.md`.
Interactive docs: https://tenderplan.ru/api/doc/

> **Load only what you need.** Start from this SKILL.md. Open `references/schemas.md` when
> you're about to call an endpoint and need exact params. Open `references/endpoints.md`
> only when the recipe you need isn't covered here. `references/swagger.json` is for
> grepping edge cases — never load it wholesale.

## Base URL

```
https://tenderplan.ru
```

All paths below are appended to this origin. Responses are JSON unless noted (file downloads return binary).

## Step 0 — get a token FIRST

**Every working session with this skill starts here.** If the user doesn't have a PAT
(Personal Access Token) handy, nothing else in this skill will work — so check first,
and if missing, give them the exact web-UI walkthrough below.

### How to generate a PAT via the Tenderplan web UI

1. Log in at **https://tenderplan.ru** and open `Настройки аккаунта` (top menu).
2. Switch to the `Интеграции с сервисами` tab.
3. Find the **OpenAPI** card on the "Тендерплан API" screen and click **`Настроить`**.
4. On the token settings page:
   - Enter a token name in `Название токена` (e.g. `supplier-search`, `my-script`).
   - Tick `Подтверждаю разрешение на следующие действия`.
   - Tick only the scopes the integration actually needs (see table below). For read-only
     tender integrations, `resources:external` + `relations:read` + `comments:read` is a
     good starting bundle.
   - Click `Сгенерировать токен`.
5. **Copy the token immediately** — it is shown once. Store it in `TENDERPLAN_TOKEN`
   env var (or your secret manager). Never commit it.

Existing tokens are listed under `Мои токены` on the same page; tokens can be revoked there.

### Minimum scope cheat-sheet

| I want to… | Minimum scopes to tick |
|---|---|
| Read tender details & attachments | `resources:external` |
| List tenders under my marks/keys | `resources:external` + `relations:read` |
| Read comments on a tender | `comments:read` |
| Post comments from my integration | `comments:write` |
| Read firm info (`/api/info/firm`) | `firm:read` |
| Manage saved searches (keys) | `keys:read` (+ `keys:write` to create/edit) |
| Manage marks / assign users to tenders | `marks:read` + `relations:write` |
| Read customer / participant / analytics data | `resources:personal` |
| Read notifications | `notifications:read` |

> **IMPORTANT:** `/api/users/pat/{create,list,revoke}` all require the `private` scope,
> which is reserved for first-party apps. Third-party PATs **cannot** create, list, or
> revoke other PATs programmatically — the UI walkthrough above is the only path. Do not
> suggest API-based PAT management to the user; it will return HTTP 403.

For the Authorization Code (OAuth) and Client Credentials flows, scope descriptions,
and rate-limit details, see `references/auth.md`.

## Authentication — one line summary

Every authenticated request sends `Authorization: Bearer <access_token>`.

```bash
curl 'https://tenderplan.ru/api/info/firm' \
  -H 'Authorization: Bearer 96b1...d53f'
```

Three ways to obtain a token:

1. **PAT (Personal Access Token)** — user creates it in the web UI (see Step 0 above). Simplest. Store it in `TENDERPLAN_TOKEN` env var or a secret store. *Not* creatable from a third-party API call — the create/list/revoke endpoints are `[private]`.
2. **Authorization Code flow** — for third-party apps acting on behalf of a user. See `references/auth.md`.
3. **Client Credentials flow** — for server-to-server requests that don't need a user context (only scopes marked `resources:external`).

Full auth flow details, scope list, and rate limits: `references/auth.md`.

**Rate limits:** 250 req / 10 s  **and**  800 req / 60 s per token. Exceed → HTTP 429. Use keep-alive.

## Mental model — how the data fits together

```
Tenderplan user account  ─► Firm (company in Тендерплан)
                             │
                             ├─ Keys (поисковые ключи — saved searches)
                             │    └─ each key has words/regions/okpd2/price filters
                             │       → server matches tenders → they appear under this key
                             │
                             ├─ Marks (метки — user-applied labels/folders)
                             │    └─ user or rule can tag a tender with a mark
                             │
                             ├─ Relations (каждая связка "firm ↔ tender")
                             │    └─ has users assigned, marks applied, read/unread, комментарии
                             │
                             └─ Tasks / Comments / Attachments (per-tender, per-firm)

Tenders live in a shared Тендерплан database (not owned by a firm).
You read them by ID, or list them via a Key/Mark/cursor.
```

Everything identifiable by ID uses **MongoDB ObjectId format** — 24 hex characters (`507f191e810c19729de860ea`).

## The 20% of endpoints that cover 80% of tasks

| Task | Endpoint | Notes |
|---|---|---|
| Health-check your token | `GET /api/info/firm` or `GET /api/tenders/get?id=000000000000000000000000` | 401/403 = token dead. 404 from the second = token works, tender doesn't exist. |
| Full tender model by ID | `GET /api/tenders/get?id=<tid>` | Returns nested `{fn, ft, fv}` structure — see `references/response-shapes.md`. |
| Tender full-info v2 | `GET /api/tenders/v2/fullinfo?id=<tid>` | Newer variant, no auth needed (`PERMISSION: NO`). |
| List tenders under a key/mark/user | `GET /api/tenders/v2/getlist?type=<0-5>&id=<entityId>&page=<n>` | `type` 0=key, 1=mark, 2=user, 3=корзина, 4=юр.заявки, 5=задачи |
| Attachments (ZIP files on zakupki) | `GET /api/tenders/attachments?id=<tid>` | Array of `{displayName, realName, href}`. `href` is a zakupki.gov.ru URL. |
| Download a tender file | `GET /api/tenders/file?href=<url>` | Auth'd proxy for the `href` returned above. |
| Protocols/contracts/explanations/RNP | `GET /api/tenders/{protocols,contracts,explanations,rnp,bankguarantees,stages,complaints}?id=<tid>` | Same shape each. |
| All comments for a tender | `GET /api/comments/getall?id=<tid>` | Returns `{comments: [...], attachments: {...}}`. Comment text is Draft.js JSON — see quirks. |
| Add a comment | `POST /api/comments/add` `{id, text}` | `text` can be plain string OR Draft.js `{blocks, entityMap}`. |
| Search tender by regnumber/EIS | `GET /api/search/tender?number=<regnum>` | Returns matching tenders in Тендерплан. |
| Ad-hoc search preview | `POST /api/search/preview` `{words, regions, ...}` | No auth. Same body shape as `/api/keys/add`. |
| List my keys | `GET /api/keys/getall` |  |
| Create a key (saved search) | `POST /api/keys/add` `{name, words, regions, okpd2, ...}` | Body schema is large — see `references/schemas.md`. |
| List my marks | `GET /api/marks/getall` |  |
| Apply marks to tenders | `POST /api/relations/marks/set` `{tenders:[…], marks:[…]}` | Overwrites. `add`/`remove` exist too. |
| Assign responsible users | `POST /api/relations/users/set` `{tenders:[…], users:[…]}` |  |
| Tenders cursor (streaming) | `POST /api/tenders/cursor/create` → `GET /api/tenders/cursor/get?cursor=<id>` | For bulk ingestion / replication. Must `POST /api/cursors/ack` each batch unless `noack=true`. |
| Organization lookup (INN/OGRN/KPP/name) | `GET /api/organizations/search?query=<text>` | Returns `{total, items:[{inn,kpp,name,ogrn,address,...}]}`. **Use this for INN lookup.** |
| Full organization profile by Tenderplan ID | `GET /api/organizations/get?id=<tpOrgId>` | `id` = Tenderplan's internal ObjectId (24-hex). Passing `inn=` here returns 400 — always go via `/search` first. |
| ЕГРЮЛ data for org | `GET /api/organizations/data/egrul?id=<orgId>` | `set` param: branches/agencies/founders/changes/arbitration |
| РНП for org | `GET /api/organizations/data/rnp?id=<orgId>` |  |
| Notifications count / list | `GET /api/notifications/count`, `GET /api/notifications/v2/getlist` |  |
| Image (from Draft.js comment) | `GET /api/images/get?id=<uuid>.png` | Returns binary. |
| Upload attachment | `POST /api/attachments/upload` (multipart) → get attachment id → reference in comment body |

For a larger catalog, see `references/schemas.md`. For the full 374-endpoint list, see `references/endpoints.md`.

## Minimal client (Python)

Check the current repo for an existing Tenderplan client (`grep -r 'tenderplan.ru' src/`) before writing anything — many projects already have one. Skeleton if you need to start from scratch:

```python
import json, urllib.parse, urllib.request

BASE = "https://tenderplan.ru"

def tp_get(path, params=None, token=None, timeout=30):
    url = BASE + path
    if params: url += "?" + urllib.parse.urlencode(params)
    req = urllib.request.Request(url)
    req.add_header("Authorization", f"Bearer {token}")
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return json.loads(r.read())

def tp_post(path, body, token=None, timeout=30):
    url = BASE + path
    data = json.dumps(body).encode()
    req = urllib.request.Request(url, data=data, method="POST")
    req.add_header("Authorization", f"Bearer {token}")
    req.add_header("Content-Type", "application/json")
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return json.loads(r.read())
```

A ready-to-run probe script that exercises auth + a handful of endpoints: `scripts/tp_probe.py`.

## Response shape gotchas (critical — read once)

Two response patterns will burn you if you don't know them.

### 1. The `{fn, ft, fv}` nested JSON (tender body)

`GET /api/tenders/get` returns top-level simple fields (`orderName`, `maxPrice`, `publicationDateTime`, etc.) **plus** a `json` field (sometimes string-encoded) containing nested categories keyed by position (`"0"`, `"1"`, `"2"`, …). Inside each category, values are always the triple:

```
{ "fn": "fieldName",   // semantic name — use THIS, not the positional key
  "ft": "fieldType",   // rarely needed
  "fv":  "fieldValue" }  // or nested dict, or array
```

**Never assume column 0 means X.** The positional keys are unstable across tenders — match on `fn` instead. A helper pattern:

```python
def fv_by_fn(category, field_name):
    if not isinstance(category, dict): return None
    for v in category.values():
        if isinstance(v, dict) and v.get("fn") == field_name:
            return v.get("fv")
    return None
```

More examples in `references/response-shapes.md`.

### 2. Draft.js comments

Comment `text` is a Draft.js document: `{blocks: [...], entityMap: {...}}`. Images live in `entityMap` as `{type: "IMAGE", data: {src: "/api/images/get?id=<uuid>.png"}}`. Event-only comments have `text: null`. Render plain text by joining block `text` fields, skipping `type == "atomic"` blocks (image placeholders). Worked example in `references/response-shapes.md`.

### 3. Millisecond timestamps

All date fields (`publicationDateTime`, `submissionCloseDateTime`, etc.) are **unix ms integers** (UTC). To render for humans: `datetime.fromtimestamp(v/1000, tz=timezone.utc)`. To filter via `fromX`/`toX` params, also pass ms integers.

### 4. Numeric enum lookups

`placingWay`, `type` (law/platform), `status`, `kind`, `region` — all numeric IDs. Never hardcode their meanings — fetch the live lookups or use the cached ones:

- Placing ways (0–30, e.g. `14=Запрос предложений`, `15=Электронный аукцион`, `22=Запрос котировок в электронной форме`): `references/lookup_placingways.json`
- Tender statuses (`1=Прием заявок`, `3=Размещение завершено`, …): `references/lookup_statuses.json`
- Regions (RU + KZ + BY): `references/lookup_regions.json`
- Law/platform types (`0=223-ФЗ`, `1=44-ФЗ`, `2=B2B-Center`, …): `references/lookup_types.json`
- Kinds: inline, `0 = тендер, 1 = план-график, 2 = запрос цен`.

The live endpoints that feed these files (no auth required, safe to re-fetch):
```
GET /api/tools/placingways/list
GET /api/tools/statuses/list
GET /api/tools/regions/list
GET /api/tools/types/list
```

Full details on all quirks + examples: `references/response-shapes.md`.

## Common recipes

### Resolve a Tenderplan web URL to a tender ID

URLs look like `https://tenderplan.ru/app?mark=<markId>&tender=<tenderId>`. Prefer the `tender=` query param; fall back to "first 24-char hex" heuristic:

```python
import re, urllib.parse
def extract_tender_id(url: str):
    q = urllib.parse.parse_qs(urllib.parse.urlparse(url).query)
    if "tender" in q: return q["tender"][0]
    m = re.search(r'[0-9a-f]{24}', url)
    return m.group(0) if m else None
```

### Pull positions from a tender body

The product/position table lives at `json["0"]["fv"]` where one entry has `fn == "Objects"`, and its `fv.tb` is either a dict keyed `"0"`, `"1"`, … or a list of rows. Each row's columns have `fn` keys `Name`, `Code` (OKPD2), `Quantity`, `Price`. `Price.fv` is the unit NMC; `Price.md` (metadata array) carries currency (`RUB`) and whether it's total/unit. See `references/response-shapes.md` for the full traversal.

### Paginate tenders under a mark

```python
page = 0
while True:
    batch = tp_get("/api/tenders/v2/getlist", {
        "type": 1, "id": mark_id, "page": page
    }, token=TOKEN)
    tenders = batch if isinstance(batch, list) else batch.get("tenders", [])
    if not tenders: break
    for t in tenders: ...
    page += 1
```

`GET /api/tenders/v2/getlist` uses `page` (integer, 0-based-ish; the server decides page size — usually 50). When the response is empty, you've exhausted the set.

### Bulk ingest via cursor (large datasets)

```python
cur = tp_post("/api/tenders/cursor/create", {
    "kinds":[0], "placingWays":[15,22], "regions":[77,50],
    "publicationDateTime": 1700000000000
}, token=TOKEN)
cursor_id = cur["cursor"]
while True:
    batch = tp_get("/api/tenders/cursor/get",
                   {"cursor": cursor_id, "noack": True},
                   token=TOKEN)
    tenders = batch.get("tenders", [])
    if not tenders: break
    process(tenders)
    # if you want at-least-once semantics, omit noack and:
    # tp_post("/api/cursors/ack", {"cursor": cursor_id, "ack": batch["ack"]}, token=TOKEN)
```

Requires scope `resources:external`. Survives server restarts as long as you hold the cursor id. See `schemas.md` for the full filter body shape.

### Download the "tender-relevant" attachments

For NMC / spec / ТЗ / извещение extraction, rank attachments by filename patterns — `обоснование нмц` first, then `спецификация`, `техническое задание`, `описание объекта`, `извещение`. Skip images. Take the top 1–3 by pattern score; prefer `/api/tenders/file?href=<encoded>` over direct zakupki download for server-side IPs.

### Test a token without hitting quota

```python
try:
    tp_get("/api/tenders/get", {"id": "000000000000000000000000"}, token=TOKEN)
    # 404 = token valid, tender doesn't exist
except urllib.error.HTTPError as e:
    if e.code in (401, 403): raise RuntimeError("token dead")
    # 404 passes through — treat as "ok"
```

Used by both `check_token_health` and `TenderPlanClient.health_check` in the SS repo.

## Things that look like footguns

- **Do not confuse `type` meanings.** In `/api/tenders/v2/getlist` query, `type` selects the *subset* (0=by key, 1=by mark, …). In the tender body, `type` is the *platform/law* (0=223-ФЗ, 1=44-ФЗ, …). Same word, two universes.
- **`PERMISSION: NO` does not mean "public."** It means the handler doesn't check a scope, but you may still need an `Authorization` header to get meaningful data. Test before relying on unauth'd access.
- **`PERMISSION: [private]`** means the endpoint is reserved for first-party clients (Tenderplan's own UI). Third-party apps can't get this scope. If an endpoint you need is marked `[private]`, look for a non-private alternative (often `/api/.../v2/...`) or call it via a PAT issued for a user who has UI-level access.
- **Writing via `POST` that look like GETs.** `/api/search/list`, `/api/relations/v2/list`, `/api/customers/v2/list`, `/api/participants/v2/list`, `/api/products/list` are POSTs that take query params on the URL *and* a JSON body. Don't omit either half — see schemas.md.
- **Rate limit is bucketed.** Hitting 249 requests in 1 second is fine; hitting 251 in 10 seconds is a 429. For bulk work prefer `/api/tenders/cursor/*` over thousands of `/api/tenders/get`.
- **Token storage is project-specific.** The canonical env var is `TENDERPLAN_TOKEN`. If you land in a repo that stashes it elsewhere (e.g. inside a shared JSON secrets file), read that file — don't invent a new path.
- **`/api/tenders/file?href=...` is the authenticated way to download tender files.** The raw `href` (pointing to zakupki.gov.ru) often works from a consumer IP but is rate-limited and sometimes blocked from servers. Prefer the `/api/tenders/file` proxy when pulling at scale.

## Deeper references (load on demand)

- `references/auth.md` — OAuth Authorization Code + Client Credentials flows, PAT management, the full 22-scope list with plain-English descriptions.
- `references/endpoints.md` — all 374 endpoints grouped by tag, method, summary, permission. Grep this when you need "is there an endpoint for X?".
- `references/schemas.md` — ~150 most-used endpoints with every query param and request-body property, including required flags, enums, defaults, and field descriptions (Russian).
- `references/response-shapes.md` — handwritten explainers for the tricky response structures: tender body `{fn,ft,fv}`, Draft.js comments with images, attachment objects, time formats.
- `references/lookup_*.json` — live dumps of placing ways, statuses, regions, law/platform types (no auth needed to refresh).
- `references/swagger.json` — raw OpenAPI 3.0.3 spec from `https://tenderplan.ru/api/doc/`. Grep for an endpoint to get its exact OpenAPI definition.
- `scripts/tp_probe.py` — quick CLI that verifies auth and prints one example response per category. Run with `TENDERPLAN_TOKEN=... python3 scripts/tp_probe.py`.
