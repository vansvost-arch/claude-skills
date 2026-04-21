---
name: pipeline-runner
description: |
  Use when user wants to run, inspect, or debug individual pipeline blocks step by step,
  like n8n node inspection. Works with any project/language.
  Triggers (RU): "прогони", "покажи блок", "пайплайн", "поблочно", "B1", "B2".
  Triggers (EN): "run block", "pipeline runner", "inspect block", "run pipeline".
---

# Pipeline Runner

Interactive block-by-block pipeline execution and inspection. Like n8n — click a node, see INPUT/PROCESS/OUTPUT.

## Quick Start

```
/pipeline-runner B2 на 3 рандомных товарах
/pipeline-runner Discovery для Stromag
/pipeline-runner B1->B3 цепочка для "Pall HC9601FCP8Z"
/pipeline-runner full pipeline на рандомном товаре
/pipeline-runner B4 для тест-кейса Woodward
/pipeline-runner init
```

## Entry Point

On every invocation:

1. Look for `pipeline.yaml` in the project root (current working directory)
2. If **NOT found** → go to [Workflow 1: Onboarding](#workflow-1-onboarding)
3. If **found** → go to [Workflow 2: Run](#workflow-2-run)

---

## Workflow 1: Onboarding

Create `pipeline.yaml` for a new project.

### Step 1: Scan Project

Search for pipeline-related artifacts:

```
Glob: **/*.md                    → look for mermaid (flowchart/graph TD/LR)
Glob: **/*_test.go, **/*.test.*, **/test_*.py, **/*_spec.*  → test files
Glob: **/data/**/*.csv, **/fixtures/**, **/testdata/**       → test data
Glob: .env, .env.example         → env vars
Glob: README.md, docs/**/*.md    → architecture docs
```

### Step 2: Identify Blocks

From mermaid diagrams and code, identify pipeline blocks. For each block determine:
- **Name** and **aliases** (what user might call it)
- **What function/method** implements it
- **Input/output types** (struct names, field types)
- **Can it be called in isolation?** (standalone vs needs service instance)
- **Needs API keys?** Which ones?
- **Approximate duration**

### Step 3: Ask User

Use AskUserQuestion to confirm:
- "Found these blocks in mermaid diagram — is this correct?"
- "How to call each block? (go test / python / curl / CLI)"
- "What env vars are needed?"
- "Where are test data files?"

### Step 4: Create Test Harness (if needed)

If blocks can't be called in isolation, create a test harness file in the project:

**Convention:** The harness reads `PIPELINE_BLOCK` and `PIPELINE_INPUT` (or `PIPELINE_INPUT_JSON`) from env vars, runs the appropriate block, and outputs JSON between markers.

**Go projects:**
```go
// pipeline_runner_test.go — inside the pipeline package
package mypipeline

func TestPipelineRunner(t *testing.T) {
    if os.Getenv("PROCURE_INTEGRATION_TEST") == "" {
        t.Skip("Set PROCURE_INTEGRATION_TEST=1")
    }
    block := os.Getenv("PIPELINE_BLOCK")
    input := os.Getenv("PIPELINE_INPUT")
    inputJSON := os.Getenv("PIPELINE_INPUT_JSON")

    var result blockResult
    switch block {
    case "B1": result = runB1(input)
    case "B2": result = runB2(ctx, input, ...)
    // ...
    }

    data, _ := json.MarshalIndent(result, "", "  ")
    fmt.Println("===PIPELINE_JSON_START===")
    fmt.Println(string(data))
    fmt.Println("===PIPELINE_JSON_END===")
}
```

**Python projects:**
```python
# pipeline_runner.py
import json, os, sys

block = os.environ["PIPELINE_BLOCK"]
inp = os.environ.get("PIPELINE_INPUT", "")

result = {"block": block, "input": {}, "process": [], "output": {}}

if block == "B1":
    result = run_b1(inp)
# ...

print("===PIPELINE_JSON_START===")
print(json.dumps(result, indent=2, ensure_ascii=False))
print("===PIPELINE_JSON_END===")
```

**TypeScript projects:**
```typescript
// pipeline-runner.ts
const block = process.env.PIPELINE_BLOCK;
const input = process.env.PIPELINE_INPUT;
// ... run block, output JSON between markers
```

**JSON envelope:**
```json
{
  "block": "B1",
  "block_name": "Input Parsing",
  "input": { "raw_name": "Stromag 29_HGE_552_FV50_A1R" },
  "process": [
    { "step": "normalize_whitespace", "detail": "trimmed 3 trailing spaces" },
    { "step": "detect_part_codes", "detail": "found: 29_HGE_552_FV50_A1R" }
  ],
  "output": { "cleaned": "stromag 29_hge_552_fv50_a1r", "confidence": 0.90 },
  "duration_ms": 1
}
```

### Step 5: Create pipeline.yaml

Write `pipeline.yaml` to the project root. Use the format from [pipeline.yaml Format](#pipelineyaml-format).

### Step 6: Verify

Run the simplest standalone block (no API keys needed) to verify the harness works.

---

## Workflow 2: Run

Execute pipeline blocks based on user request.

### Step 1: Parse Request

Determine from user message:

| What | How to detect | Default |
|------|---------------|---------|
| Block(s) | Number: B1, B2... Name: Discovery, Parsing... Alias from pipeline.yaml | Required |
| Chain | Arrow notation: B1->B3, B1→B3. Word: "цепочка", "chain" | Single block |
| Count | Number: "3 рандомных", "5 товаров" | 1 |
| Data source | "рандом"/"random" → CSV. "тест-кейс"/"test case" → test_cases. Quoted text → manual. "предыдущий"/"previous" → last run output | Random CSV |
| Product name | Quoted or after "для"/"for" | Random |

### Step 2: Prepare Data

**Random from CSV:**
```bash
# Pick N random lines (skip header), handle CSV quoting
tail -n +2 "$CSV_PATH" | sort -R | head -n $COUNT
```
Parse CSV columns according to `pipeline.yaml` data_sources.csv.columns mapping.

**From test cases:**
Look up by name/keyword in the test_cases path specified in pipeline.yaml.

**Manual input:**
Use the text provided by the user directly.

### Step 3: Load Environment

```bash
cd $PROJECT_ROOT && export $(grep -v '^#' .env | grep -v '^\s*$' | xargs)
```

### Step 4: Execute Block(s)

For each product x each block in the chain:

1. **Build INPUT** — from raw data (first block) or previous block's OUTPUT (chaining)
2. **Run command** — substitute `$INPUT` or `$INPUT_JSON` in the block's `run` template:
   ```bash
   cd $CWD && PIPELINE_BLOCK=$BLOCK PIPELINE_INPUT="$INPUT" $RUN_COMMAND 2>&1
   ```
3. **Extract JSON** — find text between `===PIPELINE_JSON_START===` and `===PIPELINE_JSON_END===`
4. **Parse** — JSON decode the blockResult

### Step 5: Format Output

For each block execution, display to user:

#### INPUT

Markdown table with key fields:

```markdown
| Field | Value |
|-------|-------|
| raw_name | Stromag 29_HGE_552_FV50_A1R Schalter |
```

#### PROCESS

Numbered steps from `process` array:

```markdown
1. **normalize_whitespace** — trimmed 3 trailing spaces
2. **detect_part_codes** — found: 29_HGE_552_FV50_A1R
3. **classify_format** — mixed (brand + part_code)
```

#### OUTPUT

Markdown table with key fields + full JSON:

```markdown
| Field | Value |
|-------|-------|
| cleaned | stromag 29_hge_552_fv50_a1r |
| detected_format | mixed |
| confidence | 0.90 |
| preserved_codes | ["29_HGE_552_FV50_A1R"] |

<details><summary>Full JSON</summary>

\`\`\`json
{ ... complete output ... }
\`\`\`

</details>
```

### Step 6: Chain

If running a chain (e.g., B1→B2→B3):
1. After each block, apply chaining rules from `pipeline.yaml`
2. Map OUTPUT fields of current block to INPUT fields of next block
3. Show a separator between blocks: `--- B1 → B2 ---`
4. Run next block with the mapped input

---

## pipeline.yaml Format

```yaml
name: pipeline-name
description: "Short description"
diagram: docs/architecture.md         # optional mermaid reference

env:                                   # required env vars
  - SERPER_API_KEY
  - OPENAI_API_KEY

data_sources:
  csv:
    path: data/products.csv
    columns: [product_name, article, quantity, unit, manufacturer, category]
  test_cases:
    path: backend/internal/.../real_data_test.go
    var: realDataTestCases             # Go var name or Python dict
    description: "9 curated products"

blocks:
  B1:
    name: Input Parsing
    aliases: [parsing, input, preprocess, B1]
    run: |
      PIPELINE_BLOCK=B1 PIPELINE_INPUT="$INPUT" \
      go test -run TestPipelineRunner -timeout 30s ./path/to/package/
    cwd: backend                       # working directory relative to project root
    input:
      raw_name: string
    output:
      cleaned: string
      tokens: string[]
      detected_format: string
      confidence: float
      removed_tokens: string[]
      preserved_codes: string[]
    needs_api: false
    duration: "<1ms"

  B2:
    name: Discovery Search
    aliases: [discovery, enrichment, seed, B2]
    run: |
      PIPELINE_BLOCK=B2 PIPELINE_INPUT="$INPUT" \
      go test -run TestPipelineRunner -timeout 60s ./path/to/package/
    cwd: backend
    input:
      raw_name: string
    output:
      brand: string
      part_codes: string[]
      category: string
      model: string
      llm_analyzed: bool
    needs_api: true
    env: [SERPER_API_KEY, OPENAI_API_KEY]
    duration: "5-15s"

chaining:
  B1->B2:
    cleaned: raw_name
  B2->B3:
    brand: brand
    category: category
    part_codes: part_codes
  B3->B4:
    brand: brand
    model_series: model
    category: category
    part_codes: part_codes
    product_synonyms_map: product_synonyms
    search_variations: search_variations
```

---

## Rules

- ALWAYS read `pipeline.yaml` first before any block execution
- NEVER hardcode project-specific logic in this skill — all specifics live in `pipeline.yaml`
- For blocks with `needs_api: true`, warn user about API costs before running
- For blocks with long `duration`, show estimated time
- When chaining, show the data being passed between blocks explicitly
- If a block fails, show the error and suggest debugging steps
- Keep session state: remember last run's output for "use previous results" requests
- Respect the `cwd` field — change to that directory before running
- Always load `.env` before running any block that needs API keys
