# Product Research Subagent Prompt

Use this template when dispatching the product identification subagent.

```
Agent tool (general-purpose):
  description: "Research product {ARTICLE}"
  prompt: |
    Identify this industrial product and its manufacturer.

    ## Input
    - Article: {ARTICLE}
    - Name: {PRODUCT_NAME}
    - Manufacturer (approximate): {MANUFACTURER}

    ## Your Job
    1. Search for the exact article number to find product specs
    2. Identify the manufacturer (full legal name, country, website)
    3. Determine product category and series
    4. Find search keywords useful for finding distributors

    ## Search Strategy (specific → general)
    1. WebSearch: "{ARTICLE}" (exact match)
    2. WebSearch: "{ARTICLE} {MANUFACTURER}"
    3. WebSearch: "{ARTICLE} datasheet"
    4. If manufacturer unclear: WebSearch "{MANUFACTURER} {PRODUCT_TYPE} manufacturer"
    5. WebFetch manufacturer website to confirm product exists

    ## Budget
    Max 10 WebSearch + 5 WebFetch. Stop when you have enough info.

    ## Output Format (plain text, not JSON)
    Return exactly this structure:

    PRODUCT:
    - Article: [exact part number]
    - Name: [full product name]
    - Series: [product series if applicable]
    - Specs: [key specifications, one line]

    MANUFACTURER:
    - Name: [full legal company name]
    - Country: [2-letter code]
    - Website: [URL]
    - Domain: [email domain if different from website]

    CATEGORY: [e.g. "EV fuses", "industrial adhesives"]

    SEARCH KEYWORDS: [comma-separated terms for finding distributors]
```
