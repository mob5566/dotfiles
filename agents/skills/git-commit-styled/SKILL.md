---
name: git-commit-styled
description: Creates a git commit with a message styled after the user's recent commits, signing off the changes. Use when you have staged changes and want to commit them matching the user's style.
---

# Styled Git Commit Skill

This skill helps the agent create a git commit for staged changes, ensuring the commit message matches the user's personal style and includes a sign-off.

## When to use this skill

- Use this skill when you have staged changes (after running `git add`) and are ready to commit them.
- Use this when you want to maintain consistency with the user's previous commit messages in the repository.

## How to use it

Follow these steps to create the commit:

1.  **Review Staged Changes**:
    Run `git diff --cached` to review the changes that will be included in the commit. Analyze what files were changed and what the changes do.

2.  **Study User Commit Style**:
    Run the following command to see the last 5 commits by the user:
    ```bash
    git log --author=$USER -5
    ```
    *Note: If `$USER` does not match the git author name, try using `git log --author="$(git config user.name)" -5` or `git log --author="$(git config user.email)" -5`.*

    Analyze the retrieved commits for:
    - **Subject Line**: Length, capitalization, imperative vs. past tense, prefixes (e.g., `feat:`, `fix:`, `[component]`).
    - **Body**: Is there a body? Is it detailed? Does it use bullet points?
    - **Footer/Tags**: Are there specific tags like `BUG=`, `TAG=`, `TEST=`, `Reviewed-on:`?
    - **Tone**: Formal, informal, concise, detailed.

3.  **Draft the Commit Message**:
    Draft a commit message that accurately describes the staged changes (from Step 1) while matching the style patterns observed (in Step 2).

4.  **Commit the Changes**:
    To avoid interactive editors (like vim or nano) which can cause the agent to hang, you must pass the message directly.
    Run the commit command with sign-off (`-s`) and the drafted message (`-m` or `-F`):

    ```bash
    git commit -s -m "Your drafted commit message"
    ```

    *Warning: Do not run `git commit -s` without `-m` or `-F` as it will open an interactive editor and hang the execution.*
