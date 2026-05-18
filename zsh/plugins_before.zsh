# External plugins (initialized before)

# zsh-completions
fpath=(~/.zsh/plugins/zsh-completions/src $fpath)

# customized completions
fpath=(~/.zsh-complete $fpath)

# autojump completions (added early so compinit sees them)
setup_autojump() {
  if [[ -d ~/.autojump/functions ]]; then
      fpath=(~/.autojump/functions ${fpath})
  fi
  if command -v brew &>/dev/null; then
    local brew_prefix=${BREW_PREFIX:-$(brew --prefix)}
    if [[ -d "${brew_prefix}/share/zsh/site-functions" ]]; then
      fpath=("${brew_prefix}/share/zsh/site-functions" ${fpath})
    fi
  fi
}
setup_autojump
unfunction setup_autojump

