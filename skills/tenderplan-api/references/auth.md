# Tenderplan API — Authentication, Scopes, Limits

All authenticated endpoints accept a **Bearer access token** in the `Authorization` header:

```
Authorization: Bearer <access_token>
```

A missing / wrong / expired token → HTTP **401**. A valid token without the right scope → HTTP **403**.
Rate limit violations → HTTP **429** (see Limits below).

## Three token acquisition paths

### 1. PAT — Personal Access Token (easiest)

PATs are created **only through the Tenderplan web UI**. The `/api/users/pat/*` endpoints
all require the `private` scope and are reserved for first-party clients — attempting to
use them with a normal PAT returns HTTP 403.

**UI walkthrough** (matches the current Tenderplan cabinet):

1. Log in at https://tenderplan.ru → top-menu `Настройки аккаунта`.
2. Tab `Интеграции с сервисами` → card **OpenAPI** → button `Настроить`.
3. On the token settings page:
   - Fill `Название токена` (anything — used only to identify the token in your list).
   - Check `Подтверждаю разрешение на следующие действия`.
   - Tick the scope checkboxes you want the token to carry (full scope table below —
     each scope corresponds one-to-one with a checkbox like `resources:external`,
     `comments:write`, etc.).
   - Click `Сгенерировать токен`.
4. **The token string is shown once.** Copy it immediately and store it in
   `TENDERPLAN_TOKEN` env var (or your secret manager). Losing it = generating a new one.

Existing tokens appear under `Мои токены` on the same page; click a token to see its
scopes or revoke it.

**What PATs are for:** server-side scripts under a single user account, where you don't
need OAuth redirects. Each PAT identifies a specific user + its granted scopes; rate
limits are tied to the user/token pair.

**Scope rules for PATs:**
- A PAT can hold **any scope the user is allowed to grant** except `private`.
- To expand an existing token's scopes you must generate a new one (scopes are frozen at creation).
- Treat PATs like passwords — they give the same data access as the user's login.

### 2. OAuth 2.0 Authorization Code flow (for multi-user apps)

For third-party apps acting on behalf of a user. You register the app once via `POST /auth/client/register`:

```json
{
  "displayName": "MyApp",
  "clientType": "confidential",       // "confidential" | "public"
  "clientDomain": "user",             // "user" | "firm"
  "redirectURIs": ["https://my.app/oauth/callback"],
  "scope": ["resources:external", "marks:read", "marks:write"]
}
```

Response: `{ clientId, clientSecret }`.

**Step A — redirect user to:**

```
GET https://tenderplan.ru/auth/client/authorize
    ?response_type=code
    &client_id=<clientId>
    &redirect_uri=https://my.app/oauth/callback
    &scope=resources:external%20marks:read
    &state=<anti-CSRF>
```

The user approves → browser is redirected to
`https://my.app/oauth/callback?code=<auth_code>&state=...`.

**Step B — exchange code for tokens (server-side):**

```
POST /auth/client/token
Content-Type: application/json

{
  "grant_type":    "authorization_code",
  "code":          "<auth_code>",
  "redirect_uri":  "https://my.app/oauth/callback",
  "client_id":     "<clientId>",
  "client_secret": "<clientSecret>"
}
```

Response: `{ access_token, refresh_token, token_type: "Bearer", expires_in, scope }`.

**Refreshing:**

```
POST /auth/client/token
{
  "grant_type":    "refresh_token",
  "refresh_token": "<refresh_token>",
  "client_id":     "<clientId>",
  "client_secret": "<clientSecret>"
}
```

**Introspect (check if a token is still live):**

```
POST /auth/client/introspect
{ "token": "<token>" }
```

Returns `{ active, scope, exp, ... }` per RFC 7662.

### 3. Client Credentials flow (server-only, no user)

For endpoints that don't need user context — only scopes flagged `resources:external`:
acts, bank guarantees, public tender data, organization lookups, etc.

```
POST /auth/client/token
{
  "grant_type":    "client_credentials",
  "client_id":     "<clientId>",
  "client_secret": "<clientSecret>",
  "scope":         "resources:external"
}
```

Returns `{ access_token, token_type:"Bearer", expires_in, scope }` (no refresh token — just re-request).

The resulting **service token** identifies the *app*, not a user. Attempts to call user-scoped endpoints with it will 403.

## Scope reference

Scopes are space-separated in OAuth requests. You can grant the root form (e.g. `comments`) which is equivalent to both `comments:read` and `comments:write`. Pick the minimum needed.

| Scope | What it grants |
|---|---|
| `resources:external` | Read tender data, acts, bank guarantees, org data — anything not personal to the user. |
| `resources:personal` | Read data tied to the user/firm (analytics, relations with tenders). |
| `firm:read` | Read current firm info (`/api/info/firm`, firm members, settings). |
| `firm:write` | Update firm info (rare, typically admin-only). |
| `user:read` | Read user's own info (`/api/info/user`, settings). |
| `user:write` | Update user's own info/settings. |
| `keys:read` | Read saved searches (`/api/keys/*`). |
| `keys:write` | Create/edit/remove saved searches. |
| `marks:read` | Read mark list (`/api/marks/*`). |
| `marks:write` | Create/edit/remove marks. |
| `relations:read` | Read the firm's relationship with tenders (the subset mapping from `/api/tenders/v2/getlist`). |
| `relations:write` | Apply marks / assign users / change read-state. |
| `comments:read` | Read tender comments. |
| `comments:write` | Write/edit comments and upload attachments. |
| `users:read` | Read the firm's user list. |
| `users:write` | Remove/restore firm users. |
| `invites:read` | Read pending invites. |
| `invites:write` | Send / revoke invites. |
| `notes:read` | Read notes on customers/suppliers. |
| `notes:write` | Write notes on customers/suppliers. |
| `notifications:read` | Read firm notifications. |
| `notifications:write` | Mark notifications as read. |
| `partners:read` | Partner-cabinet data (Tenderplan's partner program). |
| `partners:write` | Edit partner-cabinet data. |
| `calendar:read` | Read firm calendar events. |
| `private` | Reserved — first-party only, not grantable to third-party apps. Many `[private]` endpoints exist in the spec; they are not for external use. |

In `references/endpoints.md`, each row's **Permission** column shows what scope that endpoint requires.
`NO` means no scope check (the endpoint might still need an Authorization header — test before assuming it's public).

## IP allowlisting (optional)

In the app settings page on Tenderplan's site you can restrict the client secret / service token to a list of IPs. Without the allowlist, the service token works from anywhere (risky — store it as carefully as a password).

## Rate limits

Hard ceilings per token (user or service):

- **250 requests per 10 seconds**
- **800 requests per 60 seconds**

Exceeding either → **HTTP 429** response. The 429 does not count against your quota, but repeated abuse may get your IP or app temporarily denied.

**Recommendations:**

- Keep HTTP connection alive (`Connection: keep-alive`) — default in `urllib3`, `requests`, Node's `http.Agent({keepAlive:true})`.
- For heavy reads, prefer a **cursor** (`/api/tenders/cursor/create`) over looping `/api/tenders/get`.
- Batch where batching exists: `/api/tenders/getmanyshort`, `/api/tenders/getmanydata`, `/api/organizations/getmanyshort`, `/api/comments/getmany`, `/api/tasks/getmany`, `/api/notes/getmany`, `/api/attachments/uploadmany`.

## Token-health check

A lightweight ping that touches no business logic:

```bash
curl -sI -H "Authorization: Bearer $TP_TOKEN" \
  'https://tenderplan.ru/api/tenders/get?id=000000000000000000000000' \
  | head -1
```

Interpretation:
- `HTTP/2 401` or `HTTP/2 403` → token is dead / revoked / expired / wrong scope.
- `HTTP/2 404` → token is valid (server reached the lookup step, tender doesn't exist).
- Any 5xx → transient server issue, retry.

Python version: `scripts/tp_probe.py` in this skill (run `python3 scripts/tp_probe.py health`).
