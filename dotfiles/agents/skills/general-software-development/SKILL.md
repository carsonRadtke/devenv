---
name: general-software-development
description: "Implement software features and fix bugs across languages and repositories. Use automatically for every coding implementation or defect-resolution task, including when a more specialized language or framework skill also applies. Do not use for standalone code review, architecture-only planning, DevOps-only work, or documentation-only changes."
argument-hint: "Describe the feature to implement or bug to fix"
---

# General Software Development

Implement complete, reliable software changes that fit the repository
and address the root requirement.

## Scope

Use this skill for:

- Implementing new behavior in an existing codebase.
- Fixing defects and adding missing behavior.
- Making refactors that are necessary
  to complete an implementation or bug fix safely.
- Wiring all directly affected surfaces so the requested behavior works end to end.

Do not use this skill by itself for:

- Standalone code reviews or audits.
- Architecture-only analysis without implementation.
- DevOps, infrastructure, or CI-only work.
- Documentation-only requests.
- Broad cleanup or refactoring unrelated to a requested feature or defect.

This skill is a universal baseline.
Apply it alongside any relevant language, framework, testing, security,
or domain-specific skill.

## Workflow

1. Translate the request into observable behavior, constraints, and completion checks.
2. Inspect the nearest relevant implementation, tests, configuration,
   dependency manifests, and repository guidance
   before deciding how to change the code.
3. Trace the behavior through its callers, data flow, error paths,
   and user-facing surfaces far enough
   to identify the root cause or complete integration points.
4. Search for existing helpers, abstractions, and established patterns before adding new ones.
5. Identify compatibility requirements, supported environments,
   and behavior that must remain unchanged.
6. Ask the user before proceeding only when the work requires:
   - Choosing among materially different observable behaviors.
   - Breaking or substantially changing a public API.
   - Adding or replacing a dependency.
   - Making a major architectural change.
7. Otherwise, choose the smallest complete design
   that follows repository conventions and addresses the root requirement.
8. Implement the change across every directly affected surface.
   Include error handling, validation, state transitions,
   and configuration changes required for the behavior to function reliably.
9. Run the narrowest formatter, static analysis, build,
   and existing tests that cover the change.
   Expand validation only when failures, uncertainty,
   or repository policy justify it.
10. Report the result, validation performed, and any remaining limitation or risk.

## Implementation Rules

- Preserve existing behavior except where the request intentionally changes it.
- Prefer a root-cause fix over a localized workaround.
- Keep changes focused.
  Do not include unrelated cleanup.
- Follow repository conventions for naming, structure, error handling, logging,
  configuration, and dependencies.
- Reuse existing helpers and abstractions when they fit;
  do not create parallel mechanisms.
- Keep code clear and type-safe.
  Avoid suppressions, unchecked casts, magic values,
  and cleverness that hide intent.
- Validate inputs at the appropriate boundary
  and surface failures through the repository's established mechanism.
- Do not swallow errors, silently default invalid values,
  or return success-shaped results for failed operations.
- Preserve backward compatibility
  unless the requested behavior requires a break and the user confirms it.
- Update directly affected documentation or examples
  only when the code change would otherwise leave them incorrect.
- Add or update tests only when the user explicitly requests test changes.
  Otherwise, preserve tests and run the smallest relevant existing selection.
- Do not add a dependency without user confirmation.
  Prefer existing platform and repository facilities when they are sufficient.

## Bug-Fix Procedure

1. Establish the expected behavior and the observed failure from available evidence.
2. Reproduce the defect with the smallest reliable existing command or scenario
   when feasible.
3. Trace from the failing surface to the earliest incorrect state or decision.
4. Fix that root cause without masking upstream errors or weakening validation.
5. Check adjacent paths that share the corrected logic for regressions.
6. Re-run the reproduction and the smallest relevant existing test selection.

If the defect cannot be reproduced, do not invent certainty.
State the evidence available, make only evidence-supported changes,
and clearly report what remains unverified.

## Failure Handling

- If required files, tools, services, or credentials are unavailable,
  identify the exact prerequisite
  and continue with all work that can be completed safely.
- If validation exposes a failure caused by the change, fix it before completion.
- If validation exposes an unrelated pre-existing failure,
  do not repair it unless it blocks the requested work;
  report it distinctly.
- If repository instructions conflict,
  follow the most specific applicable instruction
  and surface any unresolved conflict.
- Never claim a check passed unless it was actually run successfully.

## Completion Checklist

- The requested behavior is implemented across all directly affected surfaces.
- The root cause is fixed rather than hidden by a workaround.
- Existing behavior and compatibility are preserved unless intentionally changed.
- Error paths and invalid inputs follow repository conventions.
- No unapproved dependency, public API break,
  or major architecture change was introduced.
- Tests were not changed unless explicitly requested.
- The narrowest relevant formatting, analysis, build, and existing tests pass,
  or each unresolved failure is reported precisely.
- The final response summarizes changed behavior, validation,
  and remaining risks without overstating certainty.