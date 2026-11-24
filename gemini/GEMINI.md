# Global GEMINI.md

## Python Rules

- Please follow Google's Python coding style.
    - Maximum line length is 80 characters.
    - Indent your code blocks with 2 spaces.
    - Two blank lines between top-level definitions, be they function or class
      definitions. One blank line between method definitions and between the
      docstring of a class and the first method. No blank line following a def
      line. Use single blank lines as you judge appropriate within functions or
      methods.
- Please provide docstring as required.
- Use single-quote ' for string literals.
- Files should start with a docstring describing the contents and usage of the
  module. Here is the guideline and example:
    """A one-line summary of the module or program, terminated by a period.

    Leave one blank line.  The rest of this docstring should contain an
    overall description of the module or program.  Optionally, it may also
    contain a brief description of exported classes and functions and/or usage
    examples.

    Typical usage example:

      foo = ClassFoo()
      bar = foo.function_bar()
    """

## Git Commit Message

- Limit the subject <=50 characters; use shorter first paragraph.

## Git Execution Rules

- When executing `git` commands in a specific directory or sub-repository,
  do not use `git -C <path> ...`. Instead, use `cd <path> && git ...` so
  that command permission allowlists can properly match `git <command>`.

## Shell Command Hygiene Rules

- Keep terminal commands compatible with token-prefix allowlist matching:
    - Do not use command or process substitutions (`$(...)`, backticks,
      `<(...)`), brace expansions (`{a,b}`), arithmetic expressions or tests
      (`((...))`, `$((...))`, `[ $n -eq 0 ]`), or inline code heredocs (`python3
      - <<'EOF'`, `bash <<'EOF'`), which force whole-command exact matching and
        trigger manual permission prompts.
    - Do not redirect output to files (`> file`, `>> file`); use file tools to
      write files (standard stream redirects such as `2>&1` and `2>/dev/null`
      are fine).
    - Invoke binaries by literal name (never `$PY ...` or quoted command names),
      split dependent lookups into separate steps, and prefer allowlisted skill
      helper scripts over ad-hoc inline Python/shell snippets.

## Technical Writing Rules

- Follow ASD-STE100 Simplified Technical English for documentation, plans,
  docstrings, and technical prose:
    - Use active voice.
    - Use imperative verbs for procedural steps and simple present tense for
      descriptions.
    - Write one topic per sentence.
    - Keep procedural sentences <= 20 words and descriptive sentences <= 25
      words.
    - Avoid semicolon chains, nested parentheticals, and ambiguous modal verbs.
    - Keep exact CLI commands, flags, targets, paths, and code identifiers
      unchanged.

