---
name: writing-csharp
description: "Write, modify, refactor, debug, and review modern C# application and library code. Use for C# source changes, .NET build fixes, async code, nullable reference types, API design, LINQ, diagnostics, and C# code reviews across supported .NET project types."
argument-hint: "Describe the C# implementation, fix, refactor, or review"
---

# Writing C#

Produce correct, maintainable, modern C#
that fits the repository, target frameworks, and configured toolchain.

## Scope

Use this skill for C# application and library work,
including implementation, bug fixes, refactoring, debugging, API design,
build and analyzer fixes, and code review.

Use a more specific framework or domain skill alongside this one when applicable.
Do not apply C# preferences to non-C# code, generated source,
or files owned by an external generator.

## Workflow

1. Inspect the nearest relevant C# files, project and solution files, tests,
   central build configuration, analyzer settings, formatting configuration,
   and repository guidance.
2. Determine the target frameworks, configured C# language version,
   nullable context, implicit-using policy, supported SDKs,
   and platform constraints.
3. Identify local conventions for naming, namespaces, dependency injection,
   errors, logging, async code, APIs, testing, and project layout.
4. Search for an existing helper or pattern before introducing a new abstraction.
5. Trace the affected behavior through callers, public contracts,
   serialization boundaries, cancellation, disposal,
   and error paths as applicable.
6. Ask the user before proceeding only when the work requires:
   - Choosing among materially different observable behaviors.
   - Breaking or substantially changing a public API.
   - Adding or replacing a NuGet package or other dependency.
   - Making a major architectural change.
7. Otherwise, implement the smallest complete change
   that addresses the root requirement and preserves surrounding behavior.
8. Run the narrowest relevant formatter or analyzer, build target,
   and existing test selection.
   Expand validation only when the result warrants it.

## Repository and Toolchain First

- Repository-enforced formatting, analyzers, naming rules,
  and nearby conventions override this skill's fallback preferences.
- Use only language and library features
  supported by the repository's configured SDKs, target frameworks,
  and C# language version.
- Do not raise the language version, target framework, nullable policy,
  or SDK baseline unless the task requires it
  and the user has confirmed any compatibility impact.
- Preserve platform support and trimming, AOT, serialization,
  and deployment constraints when the project declares them.
- Use the repository's existing project structure,
  dependency injection approach, logging abstractions, test framework,
  and vocabulary types.
- Do not add or update tests unless the user explicitly requests test changes.
  Still run the smallest relevant existing tests after a code change.
- Treat compiler and analyzer warnings produced by the changed code
  as issues to resolve, not suppress by default.

## Modern C# Fallback

When the repository has no clear convention and the configured toolchain supports the feature:

- Keep nullable reference types enabled and model nullability accurately.
- Prefer file-scoped namespaces.
- Prefer `var` when the assigned expression makes the type evident;
  use an explicit type when it improves clarity
  or controls conversions and overload resolution.
- Use records for data-centric value semantics
  and classes for identity or behavior-centric objects.
- Use primary constructors when they make initialization clearer
  without obscuring state or validation.
- Prefer pattern matching, switch expressions, target-typed expressions,
  collection expressions, and interpolated strings
  when they improve clarity.
- Prefer expression-bodied members only for concise members that remain easy to read.
- Use `readonly`, `init`, `required`, and immutable collections
  when they accurately express the intended mutation model.
- Prefer framework and standard-library facilities over bespoke equivalents.

Do not modernize unrelated code merely to apply these preferences.

## Nullability and Type Safety

- Treat nullable annotations as part of the contract, not as warning-suppression syntax.
- Validate nullable input at the appropriate public or external boundary.
- Prefer flow analysis, explicit guards, and accurate generic constraints
  over the null-forgiving operator.
- Use the null-forgiving operator only when an invariant is real,
  locally evident, and not expressible more safely.
- Avoid broad warning suppressions.
  Keep any necessary suppression narrow
  and document the non-obvious invariant.
- Preserve strong domain types and generic type information.
  Avoid `dynamic`, reflection, and unchecked casts
  unless required by an established boundary.

## Async and Concurrency

- Keep asynchronous operations async end to end.
  Do not block with `.Result`, `.Wait()`, or `.GetAwaiter().GetResult()`
  in ordinary application code.
- Return `Task` or `Task<T>` by default.
  Use `ValueTask` only when its benefit is established
  and its usage constraints are respected.
- Accept and propagate `CancellationToken` for cancellable operations,
  following local parameter and default-value conventions.
- Use `ConfigureAwait(false)`
  only where the repository or library context calls for it;
  do not apply it mechanically.
- Never use `async void` except for event handlers required by a framework contract.
- Make shared-state synchronization explicit.
  Prefer concurrency-safe designs over ad hoc locking.
- Do not start unobserved fire-and-forget work.
  Use the repository's background-work mechanism
  and surface failures appropriately.

## Resources and Lifetime

- Dispose `IDisposable` and `IAsyncDisposable` resources deterministically
  with `using` or `await using`.
- Do not dispose dependencies whose lifetime is owned by a container or caller.
- Avoid returning lazy sequences, tasks, spans, or callbacks
  that outlive resources they capture.
- Use spans, pooling, unsafe code, or stack allocation
  only when compatibility is preserved
  and a measured or explicit need justifies the added constraints.

## Collections, LINQ, and Performance

- Prefer clear collection operations and LINQ
  when they express intent without hiding important cost or control flow.
- Avoid repeated enumeration, accidental quadratic work,
  and deferred execution across mutable state or disposed resources.
- Materialize sequences deliberately at ownership or lifetime boundaries.
- Use comparer-aware overloads for string and key comparisons
  when semantics matter.
- Avoid speculative micro-optimization.
  In measured hot paths, reduce allocations and abstraction overhead
  without weakening correctness or readability.

## APIs, Errors, and Documentation

- Keep public APIs focused and compatible.
  Ask before introducing a breaking change.
- Use exceptions for exceptional failures
  and established result types for expected outcomes
  when that matches the codebase.
- Throw the most specific appropriate exception and preserve useful context;
  do not catch exceptions merely to rethrow
  or return a success-shaped fallback.
- Validate arguments consistently with neighboring public APIs.
- Preserve exception cancellation semantics;
  do not convert `OperationCanceledException` into an ordinary failure.
- Avoid exposing mutable collections or implementation details through public contracts.
- Document public APIs when the repository requires it
  and explain non-obvious invariants, ownership, threading,
  or lifetime constraints.
- Do not add comments that only restate the code.

## Naming Fallback

Local conventions and configured naming rules always win.
If none exist, use standard .NET naming:

- `PascalCase` for namespaces, types, methods, properties, events,
  and public or protected members.
- `camelCase` for parameters and local variables.
- `_camelCase` for private instance fields.
- `I` followed by `PascalCase` for interfaces.
- The `Async` suffix for methods that return awaitable results,
  except where a framework contract dictates the name.

## Failure Handling

- Surface missing SDKs, workloads, packages, services, or credentials
  as exact prerequisites rather than hiding the failure.
- If restore is required, use the repository's declared package sources and lock-file policy.
- If validation fails because of the change, fix the failure before completion.
- Distinguish unrelated pre-existing failures from failures introduced by the change.
- Never claim a formatter, analyzer, build, or test passed
  unless it was actually run successfully.

## Completion Checklist

- The change follows repository conventions
  and the configured C# language version and target frameworks.
- Nullability, ownership, disposal, cancellation, and async behavior
  are correct at affected boundaries.
- Public API and serialization compatibility are preserved
  unless a confirmed change requires otherwise.
- No unapproved dependency, framework upgrade, or major architecture change was introduced.
- Tests were not changed unless explicitly requested.
- Relevant formatting and analyzers pass without new warnings.
- The narrowest relevant build and existing tests pass,
  or each unresolved failure is reported precisely.
- The final response summarizes behavior, validation, and remaining risks
  without overstating certainty.