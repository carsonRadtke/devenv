# Handoff Template

Fill in every section.
Write `None` rather than omitting a section,
so the worker knows the omission is intentional.

```markdown
# Task: <unit name>

## Objective
<The behavior or answer this unit must produce, stated observably.>

## Context
- Repository and working directory: <absolute path>
- Base revision: <sha>
- Branch: <branch name, or "current tree, read-only">
- Relevant files and symbols: <paths and names to start from>
- Repository rules the worker must follow: <build or test conventions, policies>

## Decisions Already Made
<Interfaces, names, data formats, and error contracts the worker must not change.>

## Ownership
- May change: <files, directories, or interfaces>
- Must not change: <shared hotspots owned by other units or the lead>

## Non-Goals
<Related work that is out of scope for this unit.>

## Acceptance Criteria
- <Observable check 1>
- <Observable check 2>

## Validation Commands
<Exact commands to run before reporting.>

## Stop Conditions
Stop and report instead of continuing when:
- The objective requires changing something outside your ownership.
- A decision listed above appears wrong.
- The same approach has failed twice without new evidence.

## Required Report
Return:
1. Status: complete, partial, or blocked.
2. Changed files with a one-line purpose for each.
3. Commands run and their results.
4. Assumptions made.
5. Open questions, blockers, and integration risks for other units.
```
