---
name: writing-markdown
description: "Writes and edits clear, diff-friendly Markdown with one sentence per line, a 100-character soft limit, and consistent structure. Use when creating or revising Markdown files such as READMEs, documentation, guides, changelogs, issue templates, and pull request text."
---

# Writing Markdown

Write Markdown that is readable in rendered form and easy to review in source diffs.

## Use This Skill

Use this skill when creating, editing, or restructuring human-authored Markdown.
Apply it to files such as `README.md`, documentation pages, guides, changelogs,
issue templates, and pull request descriptions.

Do not reformat generated, vendored, or tool-managed Markdown
unless the user explicitly requests it.
Do not change prose that is unrelated to the requested edit merely to enforce this style.

## Write Diff-Friendly Prose

1. Put one complete sentence on each source line.
2. Treat 100 characters as a soft maximum for prose lines.
3. When a sentence exceeds 100 characters,
   wrap it at a natural clause or phrase boundary.
4. Prefer breaks after punctuation or before a phrase that can stand as a clear continuation.
5. Do not hard-wrap mechanically at a fixed column or split a word.
6. Keep each paragraph contiguous,
   with no blank lines between its wrapped source lines.
7. Separate paragraphs with one blank line.
8. Preserve intentional Markdown hard breaks,
   including trailing spaces and `<br>` elements.

For example:

```markdown
Each sentence starts on its own source line.
This longer sentence explains the main idea,
while this continuation keeps the source comfortably readable.
```

The soft limit does not justify damaging Markdown syntax or readability.
Allow an overlong line when its indivisible content includes a URL, link destination,
code span, reference definition, or another construct that cannot be wrapped safely.

## Preserve Markdown Structure

- Keep headings concise and use a logical hierarchy
  without skipping levels unnecessarily.
- Usually use one level-one heading for a standalone document.
- Surround headings, lists, block quotes, tables, and fenced code blocks
  with blank lines.
- Use consistent list markers and indentation within each list.
- Indent wrapped list content to align with the item's text.
- Prefix every continued block-quote line with `>`.
- Add a language identifier to fenced code blocks when the language is known.
- Use descriptive link text instead of vague text such as "click here."
- Add meaningful image alt text,
  or an empty alt attribute for a purely decorative image.
- Prefer ordinary Markdown over raw HTML
  when Markdown expresses the same structure clearly.
- Keep table rows on single source lines; do not wrap prose by splitting a table row.
- Do not reflow code fences, inline code, HTML blocks, YAML frontmatter,
  or link destinations.

For list items containing multiple sentences,
put later sentences on aligned continuation lines:

```markdown
- The first sentence introduces the item.
  The second sentence adds a related detail.
  A long sentence may wrap at a natural phrase boundary,
  with every continuation aligned to the item text.
```

## Edit Existing Files Surgically

1. Read enough surrounding content
   to preserve the document's organization and local syntax.
2. Follow established terminology, heading style, link style, and list conventions
   unless they conflict with the user's request.
3. Apply the line-formatting rules
   to paragraphs that are created or substantively edited.
4. Leave untouched paragraphs in their existing layout.
5. Avoid unrelated wording changes, whitespace churn, heading renumbering,
   or link-style conversions.
6. Preserve reference labels, anchors, and heading text
   when changing them could break links.

Ask the user before making a document-wide reformat when that work is not already explicit.

## Review Before Finishing

Check the changed Markdown in source form and, when practical, rendered form.
Confirm all of the following:

- Each sentence in changed prose begins on a new source line.
- Prose lines longer than 100 characters are wrapped at semantic boundaries
  or have a justified syntax exception.
- Paragraphs render as paragraphs rather than accidental hard breaks.
- Lists, block quotes, links, tables, code fences, and frontmatter
  remain syntactically valid.
- Heading hierarchy and blank-line spacing are consistent.
- No unrelated paragraphs were reformatted.
- Existing links, anchors, examples, and code content retain their meaning.

If a formatter, linter, or documentation build exists in the repository,
run the narrowest relevant check.
Report validation failures explicitly rather than claiming the document is complete.