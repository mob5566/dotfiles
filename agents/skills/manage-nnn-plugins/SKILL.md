---
name: manage-nnn-plugins
description: Helps manage customized nnn plugins in the dotfiles repository, including adding new plugins, configuring symlinks, and setting up shell shortcuts.
---

# Managing Customized nnn Plugins

This skill guides you through adding, modifying, or removing customized `nnn` plugins in this dotfiles repository.

## When to use this skill
- Use this when the user requests to add a new custom `nnn` plugin.
- Use this when modifying an existing custom `nnn` plugin.
- Use this when configuring shortcuts for `nnn` plugins.

## Steps to Implement a Customized nnn Plugin

### 1. Create or Modify the Plugin Script
Place your custom plugin script in the `config/nnn/plugins/` directory.
- Ensure the script is executable.
- The script should follow `nnn` plugin guidelines (e.g. it can be written in any language, and it receives the hovered file as the first argument, or a list of selected files, etc.).
- Refer to official `nnn` plugins for examples.

### 2. Configure Symlinking in Dotbot
Update `.install.conf.yaml` to ensure the plugin is symlinked to `~/.config/nnn/plugins/`.
Add an entry under the `link:` section:
```yaml
~/.config/nnn/plugins/<plugin_name>: config/nnn/plugins/<plugin_name>
```
If the plugin needs to overwrite an existing file (e.g. if it was previously installed by other means), use:
```yaml
~/.config/nnn/plugins/<plugin_name>:
  path: config/nnn/plugins/<plugin_name>
  force: true
```

### 3. Register the Plugin Shortcut
If the plugin should be accessible via a shortcut key, update `shell/external.sh`.
Locate the `NNN_PLUG` environment variable definition:
```bash
export NNN_PLUG='key1:plugin1;key2:plugin2;...'
```
Add your plugin shortcut to this list, using a unique key. For example, to bind `my-plugin` to `m`:
```bash
export NNN_PLUG='...;m:my-plugin;...'
```

### 4. Apply and Verify Changes
1. Run the install script from the repository root:
   ```bash
   ./install
   ```
2. Verify that the symlink was created correctly in `~/.config/nnn/plugins/`.
3. Verify that the plugin works as expected.
