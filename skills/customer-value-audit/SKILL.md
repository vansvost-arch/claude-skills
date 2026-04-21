---
name: customer-value-audit
description: Use when evaluating whether a product delivers real value to customers, before releases, after major changes, or when questioning product quality — triggered by "audit", "customer test", "value check", "протестируй с точки зрения клиента", "test from customer perspective", "does this actually work". Runs live tests against running services and produces PASS/FAIL verdict with hard truths. NOT for unit testing (use TDD), code review (use requesting-code-review), or bug hunting (use systematic-debugging).
---

# Customer Value Audit

## Overview

Evaluate whether a product delivers real value to customers. Interview first, test second, score honestly.

**Core principle:** The customer defines what matters, not the code. Scores reflect observed behavior, not intent.

**Announce at start:** "I'm using the customer-value-audit skill to evaluate this product from the customer's perspective."

## The Iron Law

```
NO PASS VERDICT WITHOUT LIVE TEST EVIDENCE
```

If you haven't run the test and seen the output, you cannot score it. Opinions are not evidence. "Should work" is not a score.

## Checklist

IMPORTANT: Use TodoWrite to create todos for EACH item below.

1. Load or create Customer Value Model
2. Confirm test scenarios with user
3. Spawn Functionality Agent
4. Spawn UX/Friction Agent
5. Spawn Reliability Agent
6. Spawn Code Quality Agent
7. Spawn Verdict Agent (after all 4 return)
8. Present final report

## Phase 1: Customer Value Model

### First invocation (no `docs/customer-value-model.md` exists)

Ask these questions ONE AT A TIME using AskUserQuestion. Multiple choice preferred.

1. **What does this product do?** (open-ended, one sentence)
2. **Who is the customer?** (technical user / business user / consumer / developer / ops engineer / other)
3. **What is the #1 thing the customer pays for?** (the outcome, not features — open-ended)
4. **What are the customer's top 3 expectations?** (open-ended, with measurable thresholds if possible)
5. **What would make a customer say "this is broken"?** (open-ended — failure modes from their perspective)
6. **How does the customer interact with the product?** (API / Web UI / CLI / mobile / SDK / other)
7. **What are the live test endpoints or entry points?** (open-ended — URLs, commands, inputs)
8. **Provide 3 test scenarios** (happy path, edge case, adversarial — or say "generate them" and you will propose based on answers above)

Save answers to `docs/customer-value-model.md` using this structure:

```
# Customer Value Model
Created: YYYY-MM-DD | Last validated: YYYY-MM-DD

## Product
[one sentence]

## Customer
[persona]

## Core Value
[what customer pays for — the outcome, not features]

## Expectations
1. [expectation + measurable threshold]
2. [expectation + measurable threshold]
3. [expectation + measurable threshold]

## Failure Modes
- [what "broken" means from customer perspective]

## Interface
[API / Web UI / CLI / etc.]

## Test Endpoints
- [endpoint or entry point + how to hit it]

## Test Scenarios
### Happy Path
[input -> expected outcome]
### Edge Case
[input -> expected outcome]
### Adversarial
[input -> expected outcome]
```

### Subsequent invocations (`docs/customer-value-model.md` exists)

1. Read the file
2. Present summary: "Your Customer Value Model: [product] for [customer]. Core value: [core value]. Last validated: [date]."
3. Ask: "Still accurate, or needs updates?" (Still accurate / Update expectations / Update test scenarios / Full re-interview)
4. If updates: ask only the changed sections, re-save with updated `Last validated` date
5. If accurate: proceed to Phase 2

## Phase 2: Evaluation Agents

Spawn 4 agents in parallel using the Task tool. Each agent receives the FULL Customer Value Model as context.

### Agent 1: Functionality

```
You are the Functionality Evaluator for a customer value audit.

CUSTOMER VALUE MODEL:
[paste full model]

YOUR TASK:
Run each test scenario against the live service. For each:
1. Execute the test (curl, browser, CLI — whatever the interface requires)
2. Record the EXACT output
3. Judge: Does this output meet the customer's expectations from the model?
4. Score: Would the customer be satisfied with this result?

TEST SCENARIOS:
[paste scenarios from model]

SCORING (1-10):
- 9-10: Customer would recommend to a peer. No caveats.
- 7-8: Works well. Minor friction but customer gets value.
- 5-6: Works sometimes. Customer would tolerate but look for alternatives.
- 3-4: Unreliable. Customer loses trust.
- 1-2: Broken. Customer leaves immediately.

RULES:
- If a test produces wrong output, score reflects that. No partial credit.
- Edge case failures count. Real customers hit edge cases.
- "Close enough" is not passing. Either the output meets expectations or it doesn't.
- Record exact commands run and exact output received.

RETURN: Score (1-10), evidence for each test (command + output + judgment), list of issues found.
```

### Agent 2: UX/Friction

```
You are the UX/Friction Evaluator for a customer value audit.

CUSTOMER VALUE MODEL:
[paste full model]

YOUR TASK:
Test the product's usability from the customer's perspective:
1. Response time: Hit each endpoint 3 times, record latency. Is it tolerable for this customer?
2. Error messages: Send malformed input (empty, wrong type, Unicode, very long). Are errors helpful or cryptic?
3. Input validation: What happens with edge inputs? Does it fail gracefully or crash?
4. Response format: Is output consistent? Easy to parse/read? Missing fields?
5. Discoverability: Could the customer figure out how to use this without reading source code?

SCORING (1-10):
[same scale as Functionality]

RULES:
- Slow is broken. If response exceeds what this customer type would tolerate, it's a defect.
- Cryptic errors are friction. "500 Internal Server Error" is a 1-2 for error quality.
- Record exact commands, exact response times, exact error messages.
- Judge from the CUSTOMER's perspective, not a developer's.

RETURN: Score (1-10), evidence for each test, list of friction points ordered by severity.
```

### Agent 3: Reliability

```
You are the Reliability Evaluator for a customer value audit.

CUSTOMER VALUE MODEL:
[paste full model]

YOUR TASK:
Stress-test the product's reliability:
1. Concurrent requests: Send 3-5 simultaneous requests. Do they all succeed?
2. Missing optional fields: Omit optional params. Does it degrade gracefully?
3. Large inputs: Send oversized data. Does it handle or crash?
4. Repeated calls: Same request 5 times. Are results consistent?
5. Rate limiting: If present, is the error message clear? Does the customer understand what happened?
6. Timeout behavior: Send a request that might be slow. Does it timeout gracefully?

SCORING (1-10):
[same scale as Functionality]

RULES:
- One crash in five requests is unreliable. Score accordingly.
- Inconsistent results between identical requests is a serious defect.
- "Works 80% of the time" is a 5, not a 7.
- Record exact commands and exact outputs for every test.

RETURN: Score (1-10), evidence for each test, list of reliability issues.
```

### Agent 4: Code Quality (for sustained value)

```
You are the Code Quality Evaluator for a customer value audit.

CUSTOMER VALUE MODEL:
[paste full model]

YOUR TASK:
Evaluate whether the codebase can sustain customer value long-term.
Use the requesting-code-review skill pattern on the critical paths identified by the model.

Focus on:
1. Silent failures: Are errors swallowed? Would the customer see wrong results without knowing?
2. Hardcoded values: Are there magic numbers, hardcoded URLs, or config that should be configurable?
3. Missing validation at system boundaries: Is user input validated before processing?
4. Error propagation: Do errors from dependencies bubble up as helpful messages or as crashes?
5. Logging: Would you be able to debug a customer-reported issue from the logs?

SCORING (1-10):
- 9-10: Code actively protects customer experience. Errors are caught, reported, recovered.
- 7-8: Solid. Minor gaps but nothing that would surprise customers.
- 5-6: Some silent failures or missing validation. Customer might see weird behavior occasionally.
- 3-4: Significant gaps. Customer will encounter bugs regularly.
- 1-2: Fragile. Any change risks breaking customer experience.

RULES:
- This is NOT a style review. Only score things that affect customer experience.
- A beautiful codebase that swallows errors is a 3.
- An ugly codebase that never crashes is a 7.
- Focus on the critical path from the Customer Value Model, not the whole codebase.

RETURN: Score (1-10), specific findings with file:line references, list of risks to customer value.
```

## Phase 3: Verdict

After all 4 agents return, spawn a Verdict Agent:

```
You are the Verdict Agent for a customer value audit.

CUSTOMER VALUE MODEL:
[paste full model]

AGENT RESULTS:
- Functionality: [score] — [summary]
- UX/Friction: [score] — [summary]
- Reliability: [score] — [summary]
- Code Quality: [score] — [summary]

YOUR TASK:
1. Cross-validate: Do agent findings contradict each other? Resolve conflicts.
2. Identify the SINGLE most critical issue from the customer's perspective.
3. Determine verdict:
   - PASS: All 4 dimensions >= 7 AND core value happy path succeeds
   - CONCERNS: All >= 5, at least one < 7
   - REWORK: Any dimension 3-4 OR happy path partially fails
   - FAIL: Any dimension <= 2 OR happy path completely fails

PRODUCE THIS EXACT REPORT FORMAT:

---

## Customer Value Audit Report
Date: YYYY-MM-DD

### Verdict: [PASS/CONCERNS/REWORK/FAIL]

### Scores
| Dimension | Score | One-line summary |
|-----------|-------|------------------|
| Functionality | X/10 | ... |
| UX/Friction | X/10 | ... |
| Reliability | X/10 | ... |
| Code Quality | X/10 | ... |

### Critical Issues (by customer impact)
1. [highest impact issue + evidence]
2. ...
3. ...

### What The Customer Actually Experiences
[Narrative walkthrough of each test scenario from the customer's POV.
Not what the code does — what the customer sees, feels, and concludes.]

### Recommendations
[Ordered list of what to fix first for maximum customer value improvement]

---

RULES:
- No grade inflation. A 7 means "genuinely good." Most V1 products score 4-6. That's honest.
- The verdict is based on EVIDENCE from the agents, not your opinion.
- If agents disagree, investigate why and state the conflict.
- The customer experience narrative must be brutally honest. If the product is slow, say "the customer waits 15 seconds staring at nothing." If results are wrong, say "the customer sees irrelevant results and loses confidence."
```

## Phase 4: Present Report

Present the Verdict Agent's report to the user. Add:

"This audit evaluated [product] against [N] test scenarios across 4 dimensions. Verdict: **[VERDICT]**."

If CONCERNS or worse, ask: "Want me to create a plan to address the critical issues?"

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "It's just V1" | Customers don't care about version numbers. Score what exists. |
| "That's an edge case" | Customers hit edge cases. Score it. |
| "We'll fix that later" | Score reflects NOW, not intentions. |
| "The test was unfair" | Was it something a customer could do? Then it's fair. |
| "It's a known issue" | Known issues are still issues. |
| "It works most of the time" | "Most of the time" is not reliable. |
| "The infrastructure was slow" | The customer doesn't know about your infrastructure. |
| "Score should be higher because..." | Evidence determines score. Not arguments. |

## Red Flags — STOP

- About to give a score without running a live test
- About to say "PASS" when any dimension is below 7
- About to soften language because the user might not like it
- About to skip a test scenario because "it probably works"
- About to score Code Quality without reading actual code
- About to produce a report without the Verdict Agent cross-validating
