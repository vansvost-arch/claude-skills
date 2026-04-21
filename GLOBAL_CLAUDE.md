# Claude Code — Global Agent Instructions

## Skill Routing Policy

These rules govern how I approach every task. They are non-negotiable defaults.

### Before starting any task

- Always invoke `using-superpowers` at conversation start to load skill routing context.
- If the task is ambiguous, strategic, under-specified, or has 2+ plausible directions → invoke `grill-me` or `brainstorming` before writing any code.
- If the task is larger than a single-file trivial tweak → invoke `writing-plans` before coding.

### Bug fixing and debugging

- Any bug, test failure, or unexpected behavior → invoke `systematic-debugging` before proposing fixes.
- For root cause analysis on systemic or recurring issues → use `5whys`.

### Decision frameworks (use the lightest fitting one)

| Situation | Skill |
|-----------|-------|
| Unclear problem domain | `cynefin` |
| Complex real-time decision | `ooda` |
| Risky or irreversible choice | `premortem` or `wrap` |
| Adversarial / security angle | `redteam` |
| Teaching or explaining deeply | `feynman` |
| Examining hidden assumptions | `socratic` |

### Code quality and testing

- For any feature or bugfix where tests are practical → invoke `test-driven-development` (red-green-refactor).
- Before claiming completion → invoke `verification-before-completion` and inspect results.

### Multi-task execution

- 2+ independent tasks in one session → invoke `dispatching-parallel-agents`.
- Large implementation plan in current session → invoke `subagent-driven-development`.
- Resuming an existing plan in a new session → invoke `executing-plans`.

### Code review and finishing

- After implementing a significant feature → invoke `requesting-code-review`.
- When receiving review feedback → invoke `receiving-code-review` before making changes.
- When implementation is complete and needs integration → invoke `finishing-a-development-branch`.

### Hard limits

- Never deploy, publish, push, or mutate remote systems autonomously.
- Use commit/release/deploy skills only on explicit user request.
- Prefer small vertical slices with explicit verification over broad speculative edits.
- Do not add error handling or abstractions for scenarios that cannot happen.
- Favor quality of routing over quantity of skills invoked.

## Project-specific overrides

Project-level CLAUDE.md files take precedence over these global defaults for their respective repositories.
