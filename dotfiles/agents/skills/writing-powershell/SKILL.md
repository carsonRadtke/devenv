---
name: writing-powershell
description: "Write, update, refactor, and debug PowerShell scripts and modules. Use for .ps1, .psm1, and .psd1 changes, PowerShell automation, parameter and pipeline design, error handling, compatibility fixes, PSScriptAnalyzer diagnostics, and Pester tests."
argument-hint: "Describe the PowerShell script, update, fix, or refactor"
---

# Writing PowerShell

Produce reliable, maintainable PowerShell scripts and modules
that preserve the repository's contracts and supported environments.

## Scope and Defaults

- Use this skill for creating and updating PowerShell scripts, functions, modules,
  related manifests, and existing tests.
- Never add tests or test cases for PowerShell files.
  Existing tests may be modified without adding test cases and run when relevant.
- Use the latest installed stable PowerShell (`pwsh`) and target PowerShell 7.0 or newer.
  Add or update `#requires -Version 7.0` for maintained PowerShell scripts and modules.
  Do not target or use Windows PowerShell 5.1.
  Confirm the minimum version supports any version-specific features.
- Do not apply these preferences to Bash, batch files, generated files,
  or interactive one-liners unrelated to maintained scripts.
- Use a relevant domain skill alongside this one when applicable.
  This skill does not authorize infrastructure changes or script execution.

## Workflow

1. Read repository guidance, nearby scripts, callers, tests, module manifests,
   analyzer settings, formatting rules, and relevant CI configuration.
2. Identify the supported PowerShell versions, operating systems, execution hosts,
   module versions, external tools, and authentication requirements.
3. Trace inputs, parameter binding, pipeline behavior, output objects and streams,
   filesystem changes, external commands, and failure paths.
4. Reuse existing helpers and conventions before adding new abstractions.
5. Ask only when a missing decision materially changes behavior, compatibility,
   dependencies, public contracts, destructive scope, or deployment risk.
   Otherwise, make a reasonable minor assumption and state it at completion.
6. Make the smallest complete change that addresses the requirement.
   Preserve unrelated behavior and existing user edits.
7. Update directly related help and usage examples when behavior changes.
   Modify existing tests when necessary without adding test cases.
8. Validate safely using the narrowest relevant checks below.
   Fix failures introduced by the change and report unresolved blockers precisely.

## Repository and Toolchain First

- Follow repository naming, indentation, brace placement, parameter ordering,
  encoding, line endings, logging, and error conventions.
- Respect `.psd1` manifests, `#Requires`, analyzer compatibility rules,
  and CI runtime matrices.
  Except for the PowerShell 7.0 minimum above, do not add new runtime or module requirements
  merely to simplify implementation.
- Confirm commands and parameters exist on the supported runtime and platforms.
  Do not assume all PowerShell 7 minor versions offer identical features.
- Use existing module management, test, and formatting workflows.
  Do not install or upgrade modules, package providers, or external tools
  without authorization under the applicable environment policy.
- Do not change execution policy, trust settings, signing checks,
  certificate validation, or privilege boundaries to make a script run.

## Parameters and Function Design

- Use approved `Verb-Noun` names for new reusable functions.
  Preserve existing public names unless a breaking change is requested.
- Prefer explicit, typed parameters and named arguments at call sites.
  Use `[switch]` for Boolean flags and parameter sets for mutually exclusive modes.
- Use validation attributes for real input constraints,
  while preserving valid values such as `0`, `$false`, or an intentional empty collection.
- Use `[CmdletBinding()]` when common parameters or advanced-function behavior are needed.
  Do not add attributes or scaffolding mechanically to tiny internal helpers.
- Mark parameters mandatory only when callers must supply them.
  Account for unattended execution rather than relying on interactive prompts.
- Use splatting to clarify long calls.
  Avoid backtick line continuations when expressions or splatting suffice.
- Use full cmdlet names and parameter names in maintained scripts rather than aliases.
- Keep functions focused without creating one-use abstractions that obscure control flow.
- Add or update comment-based help for public entry points when appropriate,
  including meaningful examples and non-obvious prerequisites or side effects.

## Objects, Pipelines, and Streams

- Return structured objects for reusable data and keep output shape stable.
  Use `[pscustomobject]` when it expresses the intended data contract clearly.
- Keep progress and diagnostics out of the success stream.
  Use the repository's logging conventions or appropriate verbose, warning,
  information, progress, and error streams.
- Do not put `Format-Table`, `Format-List`, or display-only strings
  in a pipeline whose consumers expect data objects.
- Treat all uncaptured success-stream expressions as potential function output,
  not only expressions following `return`.
  Suppress incidental method or command output deliberately.
- Handle `$null`, empty input, singleton results, and multiple results explicitly.
  Use `@(...)` when downstream code requires an array.
- Use pipeline binding and `begin`, `process`, and `end` blocks
  only when the function's contract calls for pipeline input.
  Avoid unintentionally buffering an entire pipeline.
- Use `$null -eq $value` or `$null -ne $value` for explicit null checks.
  Do not confuse false-like values with missing values.
- Preserve intended case sensitivity and collection comparison semantics.
  Use explicit case-sensitive operators when required by the contract.

## Errors, Native Commands, and Cleanup

- Distinguish non-terminating PowerShell errors, terminating errors,
  and native process exit codes.
- Use `-ErrorAction Stop` at boundaries where a cmdlet failure must enter `catch`.
  Set `$ErrorActionPreference = 'Stop'` only when appropriate for the owning scope,
  not as an unexplained global policy change.
- Do not assume `try`/`catch` or `$ErrorActionPreference`
  makes every native command failure terminating.
  Check `$LASTEXITCODE` immediately after native invocations
  and interpret it according to that tool's documented success codes.
- If using `$PSNativeCommandUseErrorActionPreference`,
  confirm runtime support and scope its effect intentionally.
  Do not depend on it as a cross-version default.
- Invoke executables with the call operator and an argument array where appropriate.
  Account for runtime-specific native argument passing and paths containing spaces.
  Never construct an executable command string with untrusted input
  and pass it to `Invoke-Expression`.
- Catch only when adding useful context, performing deliberate recovery,
  or translating a failure at an entry-point boundary.
  Preserve the original error when rethrowing.
- Do not use empty catches, blanket error suppression,
  or success-shaped fallback values to hide failures.
- Keep process exit behavior at executable script boundaries.
  Reusable functions and modules should report errors without terminating the host.
- Use `finally` to dispose owned resources and restore temporary location
  or state changes.
  Do not dispose resources owned by callers.
- Apply strict mode only after checking its effect on existing code and supported versions.
  Do not inject it globally or modernize unrelated scripts to accommodate it.

## Paths, State Changes, and Safety

- Resolve script-owned resources relative to `$PSScriptRoot`,
  not an assumed current working directory.
  Use `Join-Path` rather than concatenating separators.
- Prefer `-LiteralPath` for exact filesystem paths supplied by users or other systems.
  Use wildcard-aware parameters only when wildcard expansion is intentional.
- Preserve required operating-system support.
  Do not assume Windows drive letters, registry providers, or case-insensitive filesystems
  unless the script is explicitly Windows-only.
- Preserve existing file encodings and select output encodings intentionally.
- Validate and bound destructive targets before changing them.
  Avoid broad recursive deletion, implicit overwrites, and unrequested machine-wide changes.
- For appropriate state-changing entry points, use `SupportsShouldProcess`
  and guard actual mutations with `$PSCmdlet.ShouldProcess(...)`.
  Keep mutation helpers and external commands inside the guarded path
  so `-WhatIf` does not perform hidden writes.
- Make reruns safe where the automation contract requires idempotency.
  Distinguish an already-satisfied state from a failed operation.
- Never embed secrets or print credentials, tokens, or sensitive command arguments.
  Use the environment's established secret mechanism.
- Do not execute downloaded code or elevate privileges implicitly.

## Validation

1. Parse changed `.ps1`, `.psm1`, and `.psd1` files without executing them,
   using `System.Management.Automation.Language.Parser.ParseFile`
   or the repository's equivalent syntax check.
   Treat parser diagnostics as failures.
2. Run the configured PSScriptAnalyzer checks when the module is available.
   Use the repository's settings and compatibility targets;
   resolve new diagnostics rather than broadly suppressing rules.
3. Run the smallest relevant existing Pester test selection
   using the installed version and repository test entry point.
4. Cover relevant edge cases: invalid input, missing prerequisites, empty and singleton output,
   paths with spaces or wildcard characters, cmdlet and native failures,
   cleanup, repeat execution, and `-WhatIf` without side effects.
5. Use temporary fixtures, mocks, or an isolated environment for behavioral checks.
   Inspect test setup and module initialization before running them.
   Do not dot-source, import, or execute untrusted or state-changing code merely to validate syntax.
6. Validate on required PowerShell 7 runtime and platform targets when available.
   Testing a newer minor version alone does not prove compatibility with the minimum version.
7. If a runtime, analyzer, module, service, credential, or safe fixture is missing,
   report the exact validation gap.
   Do not silently install dependencies or claim unperformed checks passed.

## Completion

- Confirm the requested behavior is implemented and public contracts remain compatible,
  unless an intentional change was agreed.
- Ensure data and diagnostic streams, native exit handling, cleanup,
  path handling, and mutation guards are correct for the affected flow.
- Summarize meaningful code, test, help, and configuration changes with brief rationale.
- Report validation commands and outcomes accurately,
  along with any assumptions, missing prerequisites, or remaining risks.
