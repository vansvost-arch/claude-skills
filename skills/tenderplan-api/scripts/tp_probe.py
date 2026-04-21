#!/usr/bin/env python3
"""Tenderplan API probe — verifies an access token and exercises the main endpoint
families, printing one concise example per section. Read-only, idempotent, safe.

Usage:
    TENDERPLAN_TOKEN=<token> python3 tp_probe.py

Optional commands:
    tp_probe.py health                     # token-alive check only
    tp_probe.py tender <tenderId>          # full model of one tender
    tp_probe.py tender-list <markId>       # first page under a mark
    tp_probe.py search <regnum>            # search by EIS regnumber
    tp_probe.py comments <tenderId>        # dump Draft.js comments (plain-text)
    tp_probe.py org <inn>                  # lookup organization by INN
    tp_probe.py lookups                    # refresh cached lookups to stdout

Exit code 0 = token works; 1 = token dead or spec endpoint unreachable.
"""
from __future__ import annotations

import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request

BASE = "https://tenderplan.ru"


def _scan_local_json_for_token() -> str | None:
    """Best-effort: scan a few common local JSON secret files for a `tenderplan_token`
    key. Purely a convenience for repos that stash it that way. Env var is primary.
    """
    candidates = [
        "tenderplan_token.json",
        ".tenderplan_token.json",
        "secrets.json",
        "config/secrets.json",
        "data/secrets.json",
    ]
    for path in candidates:
        try:
            with open(path) as f:
                d = json.load(f)
            if isinstance(d, dict) and d.get("tenderplan_token"):
                return d["tenderplan_token"]
        except Exception:
            continue
    return None


def _token() -> str:
    t = os.environ.get("TENDERPLAN_TOKEN") or _scan_local_json_for_token()
    if not t:
        sys.stderr.write(
            "No token. Set $TENDERPLAN_TOKEN (recommended) or place a JSON file "
            "like `secrets.json` in cwd with a `tenderplan_token` key.\n"
        )
        sys.exit(1)
    return t


def _get(path: str, params: dict | None = None, token: str | None = None,
         timeout: int = 30) -> object:
    url = BASE + path
    if params:
        url += "?" + urllib.parse.urlencode(params)
    req = urllib.request.Request(url)
    if token:
        req.add_header("Authorization", f"Bearer {token}")
    req.add_header("Connection", "keep-alive")
    with urllib.request.urlopen(req, timeout=timeout) as r:
        raw = r.read()
    try:
        return json.loads(raw)
    except Exception:
        return raw


def _post(path: str, body: dict, token: str | None = None,
          timeout: int = 30) -> object:
    data = json.dumps(body).encode("utf-8")
    req = urllib.request.Request(BASE + path, data=data, method="POST")
    if token:
        req.add_header("Authorization", f"Bearer {token}")
    req.add_header("Content-Type", "application/json")
    req.add_header("Connection", "keep-alive")
    with urllib.request.urlopen(req, timeout=timeout) as r:
        raw = r.read()
    try:
        return json.loads(raw)
    except Exception:
        return raw


def _print_json(obj, title: str, limit: int = 1200) -> None:
    s = json.dumps(obj, ensure_ascii=False, indent=2, default=str)
    if len(s) > limit:
        s = s[:limit] + f"\n... [truncated, total {len(s)} chars]"
    print(f"\n━━━ {title} ━━━\n{s}")


def health(token: str) -> bool:
    """Probe a dummy tender id; a 404 means token works, 401/403 means token dead."""
    try:
        _get("/api/tenders/get", {"id": "000000000000000000000000"}, token=token)
        print("health: OK (got 200 unexpectedly — token definitely works)")
        return True
    except urllib.error.HTTPError as e:
        if e.code == 404:
            print("health: OK (404 as expected — token works)")
            return True
        if e.code in (401, 403):
            print(f"health: FAIL (HTTP {e.code}) — token is dead or wrong scope")
            return False
        print(f"health: UNKNOWN (HTTP {e.code}) — token probably works")
        return True
    except Exception as e:
        print(f"health: NETWORK ERROR — {e}")
        return False


def _try(title: str, fn):
    """Run `fn()` and print the result; on HTTP errors, print one-line summary
    instead of aborting the whole tour. Lets readers see which scopes their
    token does and doesn't have."""
    try:
        _print_json(fn(), title)
    except urllib.error.HTTPError as e:
        body = ""
        try:
            body = e.read().decode("utf-8", "replace")[:120]
        except Exception:
            pass
        print(f"\n━━━ {title} ━━━\n[HTTP {e.code}] {e.reason}  {body}")
    except Exception as e:
        print(f"\n━━━ {title} ━━━\n[ERROR] {e}")


def tour(token: str) -> None:
    """Light tour of each resource family, one call each. Individual 403s are
    tolerated — they tell you which scopes your token holds."""
    _try("user info",          lambda: _get("/api/info/user", token=token))
    _try("firm info",          lambda: _get("/api/info/firm", token=token))
    _try("marks (getall)",     lambda: _get("/api/marks/getall", token=token))
    _try("keys (getall)",      lambda: _get("/api/keys/getall", token=token))
    _try("notifications.count",lambda: _get("/api/notifications/count", token=token))


def cmd_tender(tid: str, token: str) -> None:
    _print_json(_get("/api/tenders/get", {"id": tid}, token=token),
                f"tender {tid} (full model)")
    _print_json(_get("/api/tenders/attachments", {"id": tid}, token=token),
                "attachments")


def cmd_tender_list(mark_id: str, token: str) -> None:
    _print_json(_get("/api/tenders/v2/getlist",
                     {"type": 1, "id": mark_id, "page": 0}, token=token),
                f"first page of tenders under mark {mark_id}")


def cmd_search(regnum: str, token: str) -> None:
    _print_json(_get("/api/search/tender", {"number": regnum}, token=token),
                f"search by regnumber {regnum}")


def cmd_comments(tid: str, token: str) -> None:
    data = _get("/api/comments/getall", {"id": tid}, token=token)
    comments = (data or {}).get("comments", []) if isinstance(data, dict) else []
    if not comments:
        print(f"(no comments on {tid})")
        return
    for c in comments:
        text_obj = c.get("text") or {}
        blocks = text_obj.get("blocks", []) if isinstance(text_obj, dict) else []
        text = "\n".join(b.get("text", "") for b in blocks if b.get("type") != "atomic").strip()
        user = (c.get("userId") or "?")[:8]
        print(f"  [{c.get('createdAt')}] by {user}  {text[:200]!r}")


def cmd_org(query: str, token: str) -> None:
    """Look up an organization. `query` may be an INN, KPP, OGRN, or free-text name —
    `/api/organizations/search` handles them all. (`/api/organizations/get` takes a
    Tenderplan ObjectId, not an INN — do NOT use it for INN lookup.)"""
    data = _get("/api/organizations/search", {"query": query}, token=token)
    items = data.get("items", []) if isinstance(data, dict) else []
    _print_json(
        {"total": data.get("total") if isinstance(data, dict) else None,
         "first_match": items[0] if items else None},
        f"org search for '{query}'")


def cmd_lookups() -> None:
    for name in ("placingways", "statuses", "regions", "types"):
        data = _get(f"/api/tools/{name}/list")
        _print_json(data, f"lookup: {name}")


def main() -> None:
    argv = sys.argv[1:]
    cmd = argv[0] if argv else "health"
    arg = argv[1] if len(argv) > 1 else None

    # `lookups` hits unauthenticated endpoints — no token needed.
    if cmd == "lookups":
        cmd_lookups()
        return

    token = _token()
    if cmd == "health":
        if not health(token):
            sys.exit(1)
        if len(argv) == 0:   # bare invocation → health + full tour
            tour(token)
        return

    dispatch = {
        "tender":      lambda: cmd_tender(arg, token),
        "tender-list": lambda: cmd_tender_list(arg, token),
        "search":      lambda: cmd_search(arg, token),
        "comments":    lambda: cmd_comments(arg, token),
        "org":         lambda: cmd_org(arg, token),
    }
    fn = dispatch.get(cmd)
    if not fn:
        sys.stderr.write(f"unknown command: {cmd}\n{__doc__}\n")
        sys.exit(2)
    if not arg:
        sys.stderr.write(f"{cmd} requires an argument\n")
        sys.exit(2)
    fn()


if __name__ == "__main__":
    main()
