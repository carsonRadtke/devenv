---
name: writing-cpp
description: "Write, modify, refactor, review, and debug modern C++ application and library code. Use for C++ source and header changes, API design, templates, build fixes, warning cleanup, and C++ code reviews."
argument-hint: "Describe the C++ implementation, fix, refactor, or review"
---

# Writing C++

Produce correct, safe, modern C++ that fits the repository
rather than imposing a foreign style.

## Workflow

1. Inspect the nearest relevant source, headers, tests, build configuration,
   formatting configuration, and CI settings.
2. Determine the newest C++ standard supported by the repository's configured toolchain.
   Do not raise that baseline unless the task requires it.
3. Identify local conventions for naming, layout, API design, errors, ownership,
   testing, and platform support.
4. Search for an existing helper or pattern before introducing a new abstraction.
5. Make the smallest complete change that addresses the root requirement
   and preserves surrounding behavior.
6. Run the smallest relevant formatter or linter, build target,
   and existing test selection.
   Expand validation only when the result warrants it.
7. Treat warnings as errors.
   Resolve every warning encountered during validation
   rather than suppressing it without a documented reason.

## Repository Conventions First

- Follow repository-enforced formatting and nearby code conventions.
- Follow the nearest established error-handling pattern.
  Do not impose exceptions, status types, or another policy
  when the codebase has already chosen one.
- Preserve the repository's supported compilers and platforms.
- Avoid vendor-specific features unless the repository uses them
  or they are properly isolated and gated.
- Use the repository's existing build system, test framework, utilities, and vocabulary types.
- Do not add or update tests unless the user explicitly requests tests.
  Still run the smallest relevant existing tests after a code change.

## Language and Design

- Prefer modern language and library features
  whenever the configured standard and supported toolchains provide them.
- Use concepts and `requires` clauses to constrain generic code when supported.
  Prefer straightforward generic code over clever metaprogramming.
- Use `const` by default for values and member functions that do not mutate observable state.
- Use `constexpr` or `consteval`
  when the semantics justify compile-time evaluation;
  do not apply them mechanically.
- Prefer RAII and deterministic lifetime management.
- Prefer values by default.
- Use references for required non-owning access.
- Use pointers for optional or nullable non-owning access.
- Use smart pointers only when expressing ownership.
- Make ownership transfer explicit.
- Prefer scoped enums, range-based loops, algorithms,
  and standard-library facilities over bespoke equivalents
  when they improve the result.
- Use `nullptr`, never `NULL` or integer null pointer constants.

## `auto`

- Prefer `auto` broadly when the compiler can infer the intended type.
- When the inferred type is a pointer,
  spell the declaration as `auto *` or `const auto *`
  so pointer semantics remain visible.
- Retain an explicit type when it is required for correctness, overload selection,
  conversion control, or an intentionally different public interface.

## Avoid by Default

Unless required by an established local pattern, low-level interoperability,
or a measured constraint, avoid:

- C-style casts; use the narrowest appropriate C++ cast.
- Owning raw pointers.
- Direct `new` and `delete`.
- Non-constant macros
  when a typed language feature can express the same intent.
- Unchecked narrowing conversions.
- Unscoped resource acquisition and cleanup.
- Hidden global mutable state.
- Dense template machinery when concepts, overloads, or ordinary functions are clearer.

## Naming Fallback

Local conventions always win.
If the repository has no discernible convention, use:

- `snake_case` for types, functions, namespaces, variables, parameters, and aliases.
- `PascalCase` for constants.
- An `m_` prefix for private data members,
  followed by `snake_case`.

## Headers and Dependencies

- Keep every header self-contained.
- Include what the file directly uses
  rather than relying on accidental transitive includes.
- Prefer forward declarations only when they meaningfully reduce coupling
  or compile cost without creating fragility.
- Minimize public-header dependencies and implementation leakage.
- Maintain correct declarations for templates and inline or compile-time entities.

## APIs and Documentation

- Make invalid states difficult to represent.
- Express ownership, nullability, lifetime, units, and constraints in types
  where practical.
- Keep interfaces focused and unsurprising.
- Document public APIs and non-obvious invariants, preconditions,
  lifetime constraints, and design rationale.
- Explain why when necessary;
  do not add comments that merely restate what the code does.

## Performance and Safety

Prioritize in this order:

1. Correctness and safety.
2. Clarity and maintainability.
3. Performance in measured or explicitly performance-sensitive paths.

Avoid speculative complexity.
In a hot path, verify the actual constraint
and preserve clear ownership and lifetime semantics while optimizing.

## Completion Checklist

- The implementation follows nearby code and the configured C++ standard.
- Resource ownership and lifetimes are explicit and safe.
- Pointer declarations inferred with `auto` use `auto *`.
- Narrowing, casts, and platform-specific behavior are deliberate.
- Headers are self-contained and dependencies are intentional.
- Public APIs and non-obvious invariants have useful documentation.
- The relevant format or lint, build, and existing tests pass.
- Validation emits no warnings.