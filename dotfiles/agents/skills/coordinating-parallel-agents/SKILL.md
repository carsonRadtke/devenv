---
name: coordinating-parallel-agents
description: "Plan, dispatch, monitor, and integrate work across multiple concurrent coding agents, including in-session subagents and separate Copilot CLI sessions running in their own git worktrees. Use when the user asks to parallelize work, run agents in parallel, fan out tasks, split work across agents or worktrees, delegate several tasks to subagents, or merge and reconcile results from multiple agents. Do not use for a single sequential task, a single lookup or trace, or a standalone code review."
argument-hint: "Describe the overall goal and the work you want to run in parallel"
---

# Coordinating Parallel Agents

Turn one goal into independent, verifiable units of work,
run them on isolated agents, and integrate the results
without losing coherence or overwhelming the user's review capacity.

The lead agent (the one running this skill) owns shared decisions,
integration, and final validation.
Workers own only their assigned unit.

## When Not to Parallelize

Prefer a single agent, working sequentially, when any of the following is true:

- The work is one continuous trace or a tightly coupled change
  where each step depends on decisions made in the previous one.
- Units would edit the same files, interfaces, schemas, or registries
  and those shared pieces are not yet settled.
- The task is small enough to finish in a few direct tool calls.
- The user cannot realistically review the volume of output produced.

If parallelism is not justified, say so briefly and proceed sequentially.

## Workflow

### 1. Frame the Goal

1. Restate the overall outcome and the observable checks that prove it is done.
2. Inspect enough of the repository to identify build and test commands,
   shared interfaces, and integration hotspots
   such as configuration files, registries, lockfiles, and generated code.
3. Record the base revision with `git rev-parse HEAD`
   and note any uncommitted changes.
   Ask the user how to handle uncommitted changes
   before creating worktrees from the base revision.

### 2. Decompose Into Units

Split by independently testable behavior and stable interfaces, not merely by file.
For each unit, define:

- **Objective:** the behavior or answer the unit must produce.
- **Ownership:** files, directories, or interfaces the unit may change.
- **Non-goals:** related work the unit must not do.
- **Inputs:** shared decisions, specs, and context the worker needs.
- **Acceptance criteria and checks:** commands that prove the unit works.
- **Dependencies:** units that must be integrated first.

Rules:

- Resolve shared decisions such as interfaces, names, data formats, and error contracts
  before dispatch, or assign them to a single owning unit that runs first.
- Give every integration hotspot exactly one owner.
- Prefer read-only research, triage, and prototypes as parallel units;
  they produce findings without competing implementation decisions.
- Use a throwaway scout unit when uncertainty is high;
  its output informs the plan and is not merged.

### 3. Choose an Execution Surface per Unit

| Unit type | Surface |
| --- | --- |
| Read-only research, exploration, or review | In-session subagent; parallel is safe |
| Writing unit that must not overlap others in time | In-session subagent, run sequentially in the current tree |
| Concurrent writing units | Separate Copilot CLI session, one git worktree and branch per unit |

Never let two agents write to the same working tree at the same time.

### 4. Present the Plan and Get Approval

Before creating worktrees or dispatching writers, present:

- The units with objective, ownership, surface, and dependencies.
- Shared decisions already made.
- Integration order and the integration checks to run.
- The concurrency level.
  Default to at most three concurrent writing units;
  read-only units may exceed this when their results are small.

Proceed only after the user approves or adjusts the plan.
Persist the approved plan in the session `plan.md` or session files folder
so a fresh session can resume it.

### 5. Prepare Isolated Worktrees

For each concurrent writing unit:

```powershell
git worktree add "..\<repo>-<unit-slug>" -b "agent/<unit-slug>" <base-sha>
```

Then, in each worktree:

1. Run the repository's setup steps.
   Worktrees share Git history but not untracked dependencies, build outputs,
   or local configuration.
2. Run a baseline build or focused test to confirm the worktree is healthy.
   Report pre-existing failures before dispatch.

Worktrees isolate files, not credentials, network access, processes, ports,
or shared services.
Call out shared resources, such as databases or fixed ports, that units could contend for.

### 6. Write Self-Contained Handoffs

Workers do not see the lead's conversation.
Write each handoff with [the handoff template](./references/handoff-template.md).

- **Subagents:** pass the full handoff as the task prompt.
  Custom agents invoked as subagents in Copilot CLI do not load repository custom
  instructions unless their profile sets `include-custom-instructions: true`;
  include any required repository rules directly in the handoff.
- **Worktree sessions:** save the handoff as a file in the session files folder,
  outside the worktree so it is not committed.
  Give the user the worktree path and handoff file path to start the session.
  Do not launch separate sessions without approval.

### 7. Monitor Without Micromanaging

- Run background subagents only while doing independent lead work;
  otherwise run them synchronously.
- Rely on completion notifications instead of polling.
- Batch feedback to a worker into one message rather than many small corrections.
- Stop or redirect a worker that duplicates another unit,
  leaves its ownership boundary, or repeats a failing approach without new evidence.

### 8. Review Each Result Against Its Handoff

For each completed unit:

1. Read the worker's report, then the actual diff;
   treat the report as claims to verify.
2. Confirm the change stays inside the unit's ownership and non-goals.
3. Re-run the unit's acceptance checks yourself.
4. Treat reviewer-agent findings as input to evaluate, not as authority.
5. Send a single batched follow-up when the result falls short.

### 9. Integrate One Unit at a Time

1. Merge or cherry-pick units onto the integration branch in dependency order.
2. After each unit, run the integration checks,
   not only the unit's own checks.
   A clean textual merge can still be semantically broken.
3. Resolve semantic conflicts in the lead,
   since the lead owns shared decisions.
4. After all units land, run the broadest validation the repository warrants
   for the combined change.

### 10. Clean Up

Ask before removing worktrees or deleting branches.
When approved:

```powershell
git worktree remove "..\<repo>-<unit-slug>"
git branch -d "agent/<unit-slug>"
```

## Failure Handling

- **Worker blocked or failed:** capture its evidence, decide whether to retry
  with a narrower handoff, absorb the unit into the lead, or drop it,
  and tell the user which.
- **Overlapping changes discovered:** pause the affected units,
  settle the shared decision in the lead, and re-dispatch.
- **Integration check fails:** bisect by unit
  to identify which integration introduced the failure before fixing it.
- **Pre-existing failures:** report them separately from failures introduced by the units.
- Never report a unit or the combined change as complete
  unless its checks were actually run successfully.

## Completion Response

Report:

1. Each unit's outcome, branch, and integration status.
2. The integration checks run and their results.
3. Shared decisions made and assumptions taken.
4. Remaining failures, risks, dropped units,
   and worktrees or branches still present.
