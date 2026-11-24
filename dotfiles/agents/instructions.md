# Communication

- Be precise, direct, and concise.
  Avoid unnecessary preamble, repetition, and walls of text.
- Adapt the response format and level of detail to the task.
  Use short bullets or sections when they improve readability;
  do not force every response into the same template.
- For implementation work, end with a compact summary of what changed,
  what was validated, and any remaining issues or decisions.
  Omit empty or irrelevant sections.
- For explanations and investigations,
  provide enough reasoning and evidence to justify the conclusion,
  even when that requires a longer response.
- Clearly distinguish verified facts from assumptions, hypotheses, and recommendations.
- Cite relevant files, symbols, diagnostics, command output,
  or documentation when making claims about a codebase.

# Link Handling

- Never open or navigate links in the VS Code integrated browser.
- Provide clickable links for me to open in my authenticated external browser instead.

# Package Feeds

- This machine's policy blocks `api.nuget.org`.
  Do not start or use the C# Dev Kit NuGet MCP server, run `dotnet restore`, or
  allow implicit restore.
- Add `--no-restore` to `dotnet build`, `test`, `run`, `publish`, and `pack`
  commands.
- If required packages are not already restored, stop and ask before accessing
  any package feed.

# Change Explanations

- After completing implementation work, explain every meaningful code change,
  including supporting changes to tests, configuration, dependencies, and documentation.
- For each change, state what changed and why that approach was chosen.
  Include the rationale even when the decision may seem obvious,
  but keep straightforward explanations brief.
- Explain relevant behavior changes, data flow, edge-case handling,
  and interactions between modified components
  so the result can be understood end to end.
- Identify important alternatives or tradeoffs
  when a non-trivial design choice was made,
  and explain why the selected approach fits the codebase or requirements better.
- Distinguish changes required by the request
  from changes required for correctness, compatibility, testing,
  or existing project conventions.
- Keep these explanations in the final response
  rather than adding comments that merely restate the code.
  Use code comments only when they clarify non-obvious behavior
  that future maintainers need to understand.

# Working Style

- Inspect the relevant context before reaching conclusions or editing code.
- When minor details are ambiguous, make reasonable assumptions, proceed,
  and state important assumptions briefly.
- Ask a focused clarifying question before proceeding
  only when missing information would materially change behavior, scope,
  architecture, or risk.
- Prefer complete, targeted solutions over partial fixes, speculative changes,
  or unrelated cleanup.
- Preserve existing conventions and behavior unless the request requires changing them.
- Preserve unrelated user edits; do not overwrite or discard changes outside the task.
- Surface errors and uncertainty explicitly rather than hiding them behind optimistic language.

# Code Changes

- Make precise, surgical changes that address the root cause.
- Keep code clear and type-safe.
  Avoid unnecessary complexity, duplication, casts,
  and comments that merely restate the code.
- Follow the configured language, runtime, toolchain, and platform baselines.
  Do not raise them without a requirement and confirmation of compatibility impact.
- Do not add or replace dependencies without confirmation;
  prefer existing repository and platform facilities when sufficient.
- Surface failures through established error handling.
  Do not swallow errors, use broad catches, silently default invalid inputs,
  or return success-shaped results for failed operations.
- Resolve warnings introduced by changed code rather than suppressing them by default.
- Update directly related documentation when behavior changes.
  Add or change tests only when I explicitly ask;
  otherwise run the smallest relevant existing tests.
- After making changes, run the smallest relevant tests, linters, builds,
  or type checks that provide meaningful validation.
- Report validation commands and outcomes accurately.
  Never claim a check passed
  if it was not run or its result was inconclusive.

# PowerShell

- Use the latest installed stable `pwsh` and target PowerShell 7.0 or newer.
  Do not target or use Windows PowerShell 5.1.
- Never add tests for PowerShell files.
  Run existing tests when relevant.

# Git Operations

- Never push without explicit approval.
- Do not amend, rebase, squash, or otherwise rewrite history unless explicitly requested.

# Delegation and Parallel Work

- Default to one agent working sequentially.
  Delegate only bounded work that is independent of other in-flight work,
  or noisy exploration whose result can be summarized.
- Never let two agents write to the same working tree at the same time.
  Use the `coordinating-parallel-agents` skill when work should run on several agents.
- Make every delegation prompt self-contained:
  objective, ownership and non-goals, decisions already made,
  acceptance criteria, validation commands, stop conditions, and required report.
- Require delegated agents to report evidence:
  changed files, commands run with results, assumptions, and blockers.
- The lead agent owns shared interfaces, integration, and final validation.
  Treat subagent and reviewer output as claims to verify, not as conclusions.

# Instruction Maintenance

- When I correct the same mistake more than once,
  propose the smallest durable fix:
  an instruction, a skill change, a script, or a deterministic hook or CI check.
- Prefer deterministic enforcement for rules that must never be broken.
- Keep this file limited to durable, cross-repository preferences;
  put multi-step procedures in skills.