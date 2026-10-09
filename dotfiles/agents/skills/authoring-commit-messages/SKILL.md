---
name: authoring-commit-messages
description: "Authors Conventional Commit messages and creates atomic Git commits for changes made during the current editing session. Use when completed work is ready to checkpoint, the user asks to commit changes, commit-message wording needs improvement, or session changes should be organized into clear commits."
argument-hint: "[optional intent, scope, or grouping guidance]"
---

# Authoring Commit Messages

Create clear Conventional Commit messages and commit completed, session-owned work.
The skill may commit proactively when doing so is useful, but it must never push
without asking the user first.

## Use This Skill When

- The user asks to commit, checkpoint, or organize changes.
- Work completed during the current editing session is ready to record.
- A commit message needs to be written or improved.
- Several session changes need to be separated into atomic commits.

Do not create a commit when the user explicitly requests message text only,
the work is incomplete, required validation is failing,
or the repository is in a conflicted or unclear state.
Do not amend, rebase, squash, or otherwise rewrite history
unless the user explicitly requests it.

## Workflow

### 1. Confirm the Work Is Ready

1. Verify that the current directory is in a Git worktree.
2. Check the repository status, including staged, unstaged, and untracked changes.
3. Check for unresolved conflicts and in-progress merge, rebase, cherry-pick,
   or revert operations.
   Stop and explain the state unless the current task explicitly
   requires completing that operation.
4. Confirm that the requested work is complete
   and its relevant validation has passed.
   Do not create a success-shaped commit for incomplete or failing work
   unless the user explicitly requests a checkpoint commit.

If there is no eligible change,
report that there is nothing to commit.

### 2. Identify Session-Owned Changes

Use the current conversation, editing/tool history,
and repository diff together to identify files and hunks
changed as part of this editing session.

- Include only changes attributable to the current session.
- Never assume every dirty or staged change belongs to the session.
- Treat pre-existing changes, user edits, and changes from other agents as unrelated.
- Inspect staged changes as carefully as unstaged changes;
  a staged file is not proof of session ownership.
- If ownership of a file or hunk is unclear, ask one focused question before staging
  or committing it.
- If a file mixes session-owned and unrelated edits,
  stage only the owned hunks when they can be separated confidently.
  Otherwise ask the user how to proceed.
- Do not discard, overwrite, unstage, or otherwise alter unrelated changes.

### 3. Plan Atomic Commits

Group eligible changes by one coherent purpose.
Create multiple commits when changes can be separated safely.

- Keep implementation with its directly related tests and documentation.
- Separate unrelated fixes, refactors, generated updates, and configuration changes.
- Order commits so foundational changes precede changes that depend on them.
- Do not split changes that would leave an intermediate commit
  misleading, invalid, or unbuildable.
- If several reasonable groupings exist and intent cannot be inferred, ask the user
  how to group them.

Before committing, summarize the planned groups internally
and map every eligible hunk to exactly one group.

### 4. Stage One Group Safely

Stage only the current commit group
using explicit paths or interactive hunk selection.
Never use broad staging commands such as `git add .` or `git add -A`.

Before each commit:

1. Inspect the complete staged diff.
2. Confirm every staged hunk belongs to the current session and current group.
3. Confirm no intended hunk is missing.
4. Confirm secrets, credentials, temporary files, and unrelated generated artifacts
   are not included.

If unrelated staged changes prevent a safe commit,
do not manipulate them silently.
Ask the user how to proceed.

### 5. Write the Conventional Commit Message

Use this structure:

```text
<type>[optional scope][!]: <description>

[optional body]

[optional footer(s)]
```

Choose the narrowest accurate type:

- `feat`: adds or materially extends user-facing behavior
- `fix`: corrects faulty behavior
- `docs`: changes documentation only
- `style`: changes formatting without changing behavior
- `refactor`: restructures code without changing behavior or fixing a bug
- `perf`: improves performance
- `test`: adds or corrects tests only
- `build`: changes build tooling or dependencies
- `ci`: changes continuous-integration configuration
- `chore`: performs maintenance not covered by another type
- `revert`: reverts an earlier commit

Use a scope only when a concise, stable component name is clear and useful.
Write a specific imperative description, keep it concise,
and omit the terminal period.
Prefer a subject no longer than 72 characters.

Add a body when the reason, behavior change, tradeoff,
or migration impact is not clear from the subject.
Explain what changed and why rather than narrating the diff.
Wrap body text for readability.

For a breaking change, add `!` before the colon
and a `BREAKING CHANGE: <description>` footer.
Add issue references or other trailers only when supported by known context;
never invent identifiers.
Preserve trailers required by repository or user instructions.

### 6. Commit and Handle Hooks

Create the commit without asking for routine confirmation.
Do not bypass hooks unless the user explicitly instructs it.

If a hook fails:

1. Surface the failure clearly.
2. Determine whether the failure is caused by the session changes.
3. Fix it only when doing so is within the current task.
4. Re-run the narrow relevant validation and retry the commit.

If a hook modifies files, inspect those modifications before restaging.
Include them only when they are expected, session-related,
and belong to the current commit.

Repeat the staging, message, and commit steps for each planned group.

### 7. Verify Completion

After committing:

1. Inspect the new commit or commits and record their short hashes and subjects.
2. Verify each commit contains only its intended changes.
3. Check the final repository status.
4. Confirm unrelated changes remain untouched.
5. Report the commits created and any remaining changes or validation concerns.

Never push automatically.
If pushing would be useful,
ask the user for explicit approval before running any push command.

## Interaction and Failure Rules

- Do not ask for confirmation before ordinary eligible commits.
- Ask exactly one focused question when change ownership, safe grouping, or user
  intent is materially ambiguous.
- An explicit request to draft or revise message text without committing overrides
  proactive commit behavior.
- Stop rather than guess when repository state could include another person's work.
- Report Git, hook, and validation failures directly; never claim a commit succeeded
  unless the resulting commit is verified.
- Preserve the user's working tree, index, branch, and history
  except for the session-owned commits this workflow intentionally creates.