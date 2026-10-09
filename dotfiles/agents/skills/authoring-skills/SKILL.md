---
name: authoring-skills
description: "Create, design, update, review, or debug agent skills and SKILL.md packages through an interactive requirements interview. Use when the user asks to write a skill, make an agent skill, improve a SKILL.md, package a reusable workflow, define skill triggers, or add skill references, scripts, templates, or assets."
argument-hint: "Describe the skill you want to create or improve"
---

# Authoring Skills

Create complete, focused agent skills
by first understanding what the user actually wants
through an adaptive, one-question-at-a-time interview.

## Interaction Contract

- Interview the user before writing or changing skill files.
- Use the available question or ask-user tool whenever one exists.
  Do not ask a question in ordinary chat
  when a dedicated question tool is available.
- Ask exactly one focused question per turn.
- Prefer concise multiple-choice answers when the likely options are known.
- Put the recommended option first and label it `(Recommended)`.
- Use a freeform question when choices would constrain an answer that needs nuance.
- Briefly explain how an answer affects the design before asking the next question.
- Do not ask for information already present in the request, tagged files, existing
  skill package, workspace context, or prior answers.
- Ask follow-up questions only when an answer exposes a meaningful ambiguity.
- Make reasonable defaults for non-critical details
  and report those assumptions in the final response.
- Do not ask for a separate approval to begin drafting.
  Start implementation as soon as the readiness criteria below are satisfied.
- Create and validate the complete result in one pass.
  Revise afterward only when the user requests changes.

## Defaults

- Default to a personal skill at `~/.copilot/skills/<skill-name>/`.
- Use a workspace skill location only when the user explicitly requests a
  project-shared skill or provides a workspace path.
- Create supporting `references/`, `scripts/`, and `assets/` files when they make the
  skill clearer, reusable, or more reliable.
- Keep a simple skill self-contained rather than creating unnecessary files.
- Preserve existing behavior and useful content
  when improving an existing skill.

## Workflow

### 1. Inspect the Starting Context

Before interviewing:

1. Read any tagged `SKILL.md` and directly relevant package files.
2. If updating an existing skill, inspect its current structure and identify what can
   be retained.
3. Determine whether the requested target path or scope is already explicit.
4. Check for local skill conventions or examples when available.

Never make the user repeat facts that can be learned safely from these sources.

### 2. Confirm That a Skill Is the Right Primitive

A skill is appropriate for a repeatable, on-demand, multi-step workflow, especially
one that may bundle references, scripts, or templates.

If the request is clearly better served by an always-on instruction, a single-use
prompt, a deterministic hook, or a restricted custom agent:

1. Explain the mismatch concisely.
2. Ask whether to use the better primitive or continue with a skill.
3. Respect the user's choice.

Do not derail a valid skill request with unnecessary primitive selection.

### 3. Run an Adaptive Interview

Ask only questions that materially affect the skill.
Select from these topics based on what remains unknown;
do not mechanically ask every topic:

- **Outcome:** What should be different when the skill finishes?
- **Invocation:** Which user phrases, tasks, and situations should trigger it?
- **Exclusions:** When should it not run?
- **Audience and context:** Who uses it, and in what repositories or environments?
- **Inputs:** What information, files, arguments, or tools may it receive?
- **Workflow:** Which decisions and steps must it perform, and in what order?
- **Interaction style:** Which decisions require user input versus a safe default?
- **Outputs:** Which files, edits, reports, or side effects should it produce?
- **Boundaries:** What must it preserve, avoid, refuse, or leave unchanged?
- **Failure behavior:** How should missing prerequisites and validation failures be
  surfaced?
- **Resources:** Would references, scripts, templates, or examples improve execution?
- **Completion:** What observable checks prove the skill worked?

Start with the highest-impact unknown.
Each answer should determine the next best question.

### 4. Apply the Readiness Gate

Begin drafting automatically once the available context supports a clear statement
for all of the following:

1. The skill's primary outcome.
2. Its positive trigger conditions.
3. Its important non-trigger conditions or boundaries.
4. Its main workflow and user decision points.
5. Its expected outputs or side effects.
6. Its completion and validation criteria.
7. Its target scope and location.

If a missing detail could significantly change behavior,
continue interviewing.
If it only affects a minor implementation choice,
choose a sensible default and record it as an assumption.

### 5. Design the Skill Package

Use this structure as needed:

```text
<skill-name>/
|-- SKILL.md
|-- references/
|-- scripts/
`-- assets/
```

Follow these rules:

- Use a lowercase hyphenated folder name.
- Make the frontmatter `name` exactly match the folder name.
- Keep the name between 1 and 64 characters using lowercase letters, numbers, and
  hyphens.
- Write a concrete `description`
  that states both what the skill does and when to use it.
  Include realistic trigger terms the user is likely to say.
- Quote YAML values that contain colons or other potentially ambiguous punctuation.
- Keep the description at or below 1024 characters.
- Keep `SKILL.md` focused and below 500 lines.
- Put detailed domain knowledge in `references/`,
  deterministic automation in `scripts/`,
  and reusable starter content in `assets/`.
- Link resources from `SKILL.md` with relative paths such as
  `./references/validation.md`.
- Keep referenced resources one level below `SKILL.md` when practical.
- Do not add empty directories or speculative resources.
- Do not invent unavailable tools.
  Describe capabilities generically when tool names vary by environment.

Use this minimum frontmatter:

```yaml
---
name: example-skill
description: "What the skill does. Use when the user asks for specific relevant tasks."
---
```

Add optional fields only when they serve a clear purpose:

- `argument-hint`: Helps the user provide useful slash-command input.
- `user-invocable: false`: Hides the skill from slash-command discovery.
- `disable-model-invocation: true`: Prevents automatic loading.

### 6. Write Complete Operational Instructions

The body should tell another agent how to execute the workflow,
not merely describe the topic.
Include:

1. A concise purpose.
2. Clear use and non-use guidance where needed.
3. Ordered procedures with decision points.
4. Required interaction behavior.
5. Error and edge-case handling.
6. Validation and completion checks.
7. Links to supporting resources.

Prefer explicit, testable instructions over vague advice.
Avoid redundant prose and generic reminders that do not change execution.

### 7. Validate the Result

Before reporting completion:

- Confirm `SKILL.md` exists in the intended folder.
- Confirm the frontmatter has valid `---` delimiters.
- Confirm `name` matches the containing folder.
- Confirm the description is specific, includes discovery triggers, and is no more
  than 1024 characters.
- Confirm all relative links resolve.
- Confirm referenced files exist and empty support directories were not created.
- Confirm the workflow addresses the user's requested behavior and boundaries.
- Run the narrowest relevant checks for any scripts or generated code.
- Surface validation failures explicitly and fix them when possible.

## Completion Response

Report:

1. The skill location and files created or changed.
2. The main behavior and trigger choices.
3. Any assumptions made for non-critical details.
4. The validation performed and its outcome.

Do not force a review loop after successful creation.
Invite the user to request a revision
if the completed behavior is not what they intended.