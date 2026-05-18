# Agentic Management of Dotfiles

This document provides instructions and guidelines for AI agents managing this dotfiles repository.

## Repository Overview

This repository uses [Dotbot](https://github.com/anishathalye/dotbot) to manage symlinks for dotfiles.

### Key Files and Directories

*   [`install`](file:///usr/local/google/home/codycswong/dotfiles/install): The installation script. It initializes the Dotbot submodule and runs Dotbot. It is **idempotent** and safe to run multiple times.
*   [`.install.conf.yaml`](file:///usr/local/google/home/codycswong/dotfiles/.install.conf.yaml): Dotbot configuration file defining symlinks and post-install shell commands.
*   [`gemini/`](file:///usr/local/google/home/codycswong/dotfiles/gemini): Configuration directory for Gemini agents.
    *   [`gemini/GEMINI.md`](file:///usr/local/google/home/codycswong/dotfiles/gemini/GEMINI.md): Global rules for Gemini agents (e.g., coding style, git commit guidelines).
    *   [`gemini/settings.json`](file:///usr/local/google/home/codycswong/dotfiles/gemini/settings.json): Gemini settings.
    *   [`gemini/commands/`](file:///usr/local/google/home/codycswong/dotfiles/gemini/commands): Custom Gemini commands (in TOML format).

## Workflows for Agents

### 1. Adding a New Dotfile

To add a new configuration file to be managed by this repo:

1.  Place the new file in the appropriate location within the repository (e.g., under `config/` or in the root if it's a standard dotfile).
2.  Update [`.install.conf.yaml`](file:///usr/local/google/home/codycswong/dotfiles/.install.conf.yaml) to add the mapping from the home directory to the repository file.
    *   Ensure the target path in the home directory is correct.
    *   Use relative paths from the repository root for the source file.
3.  Run the [`install`](file:///usr/local/google/home/codycswong/dotfiles/install) script to verify the link is created correctly.

### 2. Modifying Existing Configurations

When modifying existing configurations (e.g., `vimrc`, `bashrc`):

1.  Edit the file in the repository.
2.  Test the changes if possible (e.g., start a new shell to test `bashrc` changes, open vim to test `vimrc` changes).
3.  If the change requires new plugins or submodules, update the configuration and run the install script.

### 3. Handling Local Customizations

The user's environment supports local customizations that are *not* tracked in this repository. These files are typically named `*_local` (e.g., `~/.vimrc_local`, `~/.gitconfig_local`).

*   **Do not** attempt to commit or manage `*_local` files in this repository.
*   When troubleshooting issues, be aware that these local files might override configurations defined in this repository.

### 4. Managing Gemini Configurations

You can customize Gemini agent behavior by modifying files in the `gemini/` directory.

*   **Rules**: Update [`gemini/GEMINI.md`](file:///usr/local/google/home/codycswong/dotfiles/gemini/GEMINI.md) to add or modify rules that all Gemini agents should follow in this workspace.
*   **Custom Commands**: Add or modify TOML files in [`gemini/commands/`](file:///usr/local/google/home/codycswong/dotfiles/gemini/commands) to define custom shortcuts or workflows. Refer to existing files in [gemini/commands/git/](file:///usr/local/google/home/codycswong/dotfiles/gemini/commands/git) for examples.

## Guidelines for Agents

*   **Idempotency**: Ensure any scripts or commands you introduce or modify are idempotent. Running `./install` should always be safe and yield the same result.
*   **Minimal Intrusion**: Avoid making changes that drastically alter the user's environment without explicit approval.
*   **Documentation**: Keep `README.md` and this `AGENTS.md` updated as the repository structure evolves.
