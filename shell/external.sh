# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# Cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# Python startup file
export PYTHONSTARTUP=$HOME/.pythonrc

### NNN
export NNN_OPTS='edrxAH'
export NNN_PLUG='o:fzopen;c:fzcd;p:preview-tui;t:preview-tabbed;i:imgview;j:autojump;d:diffs_;a:ag;g:gitroot;'
export NNN_COLORS='#1ba01cdc;4923'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_BATTHEME='TwoDark'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height=~90% --layout=reverse --border --info=inline --preview-window="right,50%,border-left" --preview "bat --color=always {}"'

# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# fzf-git
source ~/.shell/plugins/fzf-git/fzf-git.sh

## set fzf-git layout
_fzf_git_fzf() {
  fzf --height=40% \
    --layout=reverse --multi --min-height=20 --border \
    --border-label-pos=2 \
    --color='header:italic:underline,label:blue' \
    --preview-window='right,50%,border-left' \
    --bind='ctrl-/:change-preview-window(down,50%,border-top|hidden|)' "$@"
}

# leetcode-cli
if which leetcode 2>&1 > /dev/null ; then
  eval "$(leetcode completions)"
fi
