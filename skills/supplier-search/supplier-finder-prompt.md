# Supplier Finder Subagent Prompt

Use this template when dispatching the supplier search + verification subagent.

```
Agent tool (general-purpose):
  description: "Find {COUNT} {REGION} suppliers for {MANUFACTURER}"
  prompt: |
    Find and verify {COUNT} suppliers/distributors in {REGION} for the product below.

    ## Product
    - Article: {ARTICLE}
    - Manufacturer: {MANUFACTURER}
    - Manufacturer website: {MANUFACTURER_WEBSITE}
    - Category: {CATEGORY}
    - Search keywords: {SEARCH_KEYWORDS}

    ## Already found (exclude these)
    {ALREADY_FOUND_LIST or "None"}

    ## Search Strategy (follow this order, stop when you have {COUNT})

    **Priority 1 — Manufacturer's own distributor list:**
    - WebFetch {MANUFACTURER_WEBSITE} and look for "distributors", "partners",
      "where to buy", "sales network" pages
    - This is the highest-quality source — official partners

    **Priority 2 — Article-specific search:**
    - WebSearch: "{ARTICLE} distributor"
    - WebSearch: "{ARTICLE} buy Europe"
    - WebSearch: "{ARTICLE} supplier"

    **Priority 3 — Manufacturer distributors:**
    - WebSearch: "{MANUFACTURER} authorized distributor Europe"
    - WebSearch: "{MANUFACTURER} dealer {REGION}"

    **Priority 4 — Category directories:**
    - WebSearch on europages.com, directindustry.com for the category
    - WebSearch: "{CATEGORY} supplier Europe"

    ## Inline Verification (do this for EACH candidate)

    For each potential supplier:
    1. WebFetch their website — confirm it loads
    2. Look for Contact/Impressum page — extract email, phone, address
    3. Check that {MANUFACTURER} or {ARTICLE} appears in their catalog/brands

    A supplier is VERIFIED only if all 3 checks pass.
    Skip candidates where website doesn't load or no contact info found.

    ## Budget
    Max 15 WebSearch + 15 WebFetch TOTAL (not per supplier).
    If you've hit the limit, return what you have.

    ## Stop Criteria
    - Found {COUNT} verified suppliers → STOP immediately, return results
    - Hit budget limit → return what you found (even if < {COUNT})
    - All strategies exhausted → return what you found

    ## Output Format

    For each verified supplier, return:

    SUPPLIER {N}:
    - Name: [company name]
    - Type: [manufacturer / distributor / retailer]
    - Country: [2-letter code]
    - Address: [full address]
    - Phone: [with country code]
    - Email: [verified from website]
    - Website: [URL]
    - Evidence: [how you confirmed they sell this product]

    SUMMARY:
    - Total found: [N]
    - Strategies used: [which priority levels were needed]
    - Notes: [any issues, e.g. "only 3 found, niche product"]
```
