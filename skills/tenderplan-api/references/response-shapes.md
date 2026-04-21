# Tenderplan Response Shapes — The Stuff That Looks Wrong At First

Four structures recur in Tenderplan responses and trip people up. If you've read this
document once, you won't be surprised again.

## 1. Tender body: top-level + nested `json`

`GET /api/tenders/get?id=<tid>` returns something like:

```json
{
  "_id": "507f191e810c19729de860ea",
  "orderName": "Поставка оборудования",
  "number": "0123456789012345",
  "futureNumber": null,
  "href": "https://zakupki.gov.ru/epz/order/notice/...",
  "eid": "0123456789012345",
  "maxPrice": 1500000.0,
  "currency": "rub",
  "guaranteeApp":      15000.0,
  "guaranteeContract": 150000.0,
  "prepayment": true,
  "type": 1,                              // numeric — 0=223-ФЗ, 1=44-ФЗ, see lookup_types.json
  "placingWay": 15,                       // numeric — see lookup_placingways.json
  "smp": true,
  "multilot": false,
  "preference": [0, 2],                   // numeric codes
  "customers": [ { "name": "МБУ ...", "region": 77, "regNum": "...", "inn": "...", ... } ],
  "platform":  { "name": "ЕИС", "href": "https://zakupki.gov.ru", ... },
  "publicationDateTime":     1713600000000,   // ms since epoch, UTC
  "submissionStartDateTime": 1713700000000,
  "submissionCloseDateTime": 1714500000000,
  "scoringDateTime":         1714600000000,
  "biddingDateTime":         1714700000000,
  "summingUpDateTime":       1714800000000,

  "attachments": [ { "displayName": "...", "realName": "...", "href": "https://..." } ],
  "feed":        [ { "event": "Публикация извещения", "eventDateTime": 1713600000000 } ],

  "json": {
    "0": { "fn": "ObjectInfo", "ft": "Category", "fv": { /* positions, objects */ } },
    "1": { "fn": "Procedure",  "ft": "Category", "fv": { /* procedure details */ } },
    "2": { "fn": "Contacts",   "ft": "Category", "fv": { /* contacts */ } },
    "general": { ... common metadata ... }
  }
}
```

- Simple fields (prices, dates, customer list, etc.) live **at the top level** — stable names.
- Everything else — positions, contacts, delivery places, procedure parameters — lives inside `json`, which may arrive as a string (call `json.loads`) or already as an object. Always tolerate both.

### The `{fn, ft, fv}` triple

Inside `json`, **every value is a dict** with at least these keys:

| Key | Meaning |
|---|---|
| `fn` | **field name** — semantic identifier (e.g. `"Objects"`, `"Name"`, `"Price"`, `"Code"`, `"Quantity"`) |
| `ft` | **field type** — `"Category"`, `"Table"`, `"String"`, `"Number"`, `"Array"`, `"Row"`, etc. Informational. |
| `fv` | **field value** — scalar, dict, or array. |
| `md` | optional **metadata** — present on Price (holds currency `"RUB"` and whether the price is per-unit or total). |

Inside a dict of values, the **keys are positional** (`"0"`, `"1"`, `"2"`, …). Those positions
**are not stable** across tenders. Different platforms and laws emit columns in different
orders. Always resolve by `fn`:

```python
def fv_by_fn(category: dict, field_name: str):
    if not isinstance(category, dict): return None
    for v in category.values():
        if isinstance(v, dict) and v.get("fn") == field_name:
            return v.get("fv")
    return None
```

(The same helper appears in `SKILL.md` quick-reference section.)

### Position table (the most useful nested thing)

```
json["0"]                       # ObjectInfo category
   .fv                          # dict of subfields
   [<some key>] where fn=="Objects"
   .fv.tb                       # table body — dict (keyed "0","1",...) OR list
     [ row_0, row_1, ... ]      # one row per position
       row[<col key>]           # column — again { fn, ft, fv, md? }
         fn=="Name"     → product name
         fn=="Code"     → OKPD2 code
         fn=="Quantity" → qty (string/number)
         fn=="Price"    → { fv: unit_price, md: ["RUB","Unit"|"Total"] }
```

`tb` can be a stringified JSON (happens with legacy tenders) — catch `json.loads` failures.

Contacts sit at `json["2"].fv`, under a field whose `fn=="Contacts"`, `fv` containing sub-entries
with `fn` in `{FIO, Phone, Email}`.

Delivery place is `json["general"]` → `fn=="deliveryPlace"`.
Summing-up place is `json["1"].fv` → `fn=="SummingupPlace"`.

## 2. Comments — Draft.js documents with images

`GET /api/comments/getall?id=<tid>` returns:

```json
{
  "comments":    [ /* Comment[] */ ],
  "attachments": { "<attachmentId>": { ... } }
}
```

Each Comment looks like:

```json
{
  "_id":          "<commentId>",
  "tenderId":     "<tid>",
  "userId":       "<userId>",
  "createdAt":    1713700000000,
  "updatedAt":    1713700100000,
  "pinned":       false,
  "reactions":    { "👍": ["<userId>", ...] },
  "readBy":       ["<userId>", ...],
  "attachmentIds": ["<attId>", ...],

  "text": {                                     // Draft.js editor state, or null for event-only
    "blocks": [
      { "key":"abc", "type":"unstyled",  "text":"Hello",        "depth":0,
        "inlineStyleRanges":[], "entityRanges":[] },
      { "key":"def", "type":"atomic",    "text":" ",            "depth":0,
        "inlineStyleRanges":[], "entityRanges":[{"offset":0,"length":1,"key":0}] }
    ],
    "entityMap": {
      "0": { "type":"IMAGE", "mutability":"IMMUTABLE",
             "data": { "src":"/api/images/get?id=<uuid>.png", "alt":"" } }
    }
  }
}
```

**Flatten to plain text** — iterate `blocks`, skip `type=="atomic"` (image stubs), join:

```python
def comment_text(c):
    t = (c.get("text") or {}).get("blocks", [])
    return "\n".join(b["text"] for b in t if b.get("type") != "atomic")
```

**Collect images** — iterate `entityMap` for `type=="IMAGE"`:

```python
def comment_images(c):
    em = (c.get("text") or {}).get("entityMap", {})
    return [e["data"] for e in em.values() if e.get("type") == "IMAGE"]
```

`data.src` is a relative path like `/api/images/get?id=<uuid>.png`; fetch it with
`GET <BASE>/api/images/get?id=...` (auth required, returns binary).

System/event comments (status changes, assignments) have `text: null`. Return "" for them.

## 3. Attachments

Two different shapes, depending on origin:

### Tender's official attachments (from `/api/tenders/attachments`)

```json
[
  {
    "displayName": "Спецификация.pdf",
    "realName":    "tz_spec_v2.pdf",
    "href":        "https://zakupki.gov.ru/44fz/filestore/public/1.0/download/priz/file.html?uid=...",
    "sizeBytes":   512000,
    "createdAt":   1713600000000
  }
]
```

`href` is a direct zakupki URL. Prefer the authenticated proxy
`GET /api/tenders/file?href=<encoded_href>` when pulling at scale or from a server IP —
zakupki sometimes rate-limits non-consumer IPs.

### User-uploaded / comment attachments (from `/api/tenders/comments/attachments` or comment payloads)

```json
{
  "_id":       "<attachmentId>",
  "name":      "коммерческое-предложение.xlsx",
  "size":      81920,
  "mimeType":  "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  "uploadedBy":"<userId>",
  "uploadedAt":1713700000000
}
```

Download with `GET /api/attachments/get?id=<attachmentId>`.

## 4. Dates: always unix ms, UTC

Every date-like field in Tenderplan is a **unix millisecond integer**, UTC. Seconds (10-digit)
never appear. ISO strings never appear. If a field looks stringy, it's a name, not a date.

- Decode for humans: `datetime.fromtimestamp(v / 1000, tz=timezone.utc)`.
- Filter in requests: `fromSubmissionCloseDateTime=1713600000000&toSubmissionCloseDateTime=1714500000000`
  (milliseconds on both ends).

The `feed` array uses the same format: `{event: str, eventDateTime: ms int}`.

## 5. Sort params — the `-1` / `1` convention

Several list endpoints accept a sort via one of many parameters:

```
publicationDateTime=-1   → sort by publication date, descending (newest first)
publicationDateTime=1    → ascending
maxPrice=-1              → sort by price, descending
isChanged=-1             → changed tenders first
isRead=1                 → read tenders last
```

Only pass **one** sort param per request. The server picks the first it recognizes if you pass
multiple; behavior is undefined.

## 6. Empty set vs error

List endpoints (`/api/tenders/v2/getlist`, `/api/search/list`, analytics lists) **return an
empty array or `{tenders: []}`** when there are no results — never a 404. Treat empty as a
termination signal in paginators:

```python
while True:
    batch = tp_get("/api/tenders/v2/getlist", {"type":1,"id":mid,"page":page}, token=TOK)
    tenders = batch if isinstance(batch, list) else batch.get("tenders") or []
    if not tenders: break
    yield from tenders
    page += 1
```

Some list endpoints return the bare array, others wrap it — tolerate both in one code path.

## 7. 401 vs 403 vs 429

- **401 Unauthorized** — missing, malformed, expired, or revoked token.
- **403 Forbidden** — token is valid but lacks the scope the endpoint requires, OR is
  a service token trying to hit a user-scoped endpoint.
- **429 Too Many Requests** — rate limit. Back off (sleep a few seconds), then retry.
  There is no `Retry-After` header guarantee — just wait.

Don't conflate 401 and 403 in error messages: 401 means "refresh the token"; 403 means
"get a different token with wider scopes."
