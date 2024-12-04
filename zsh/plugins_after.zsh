# External plugins (initialized after)

# Syntax highlighting

source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

if [[ "$(tput colors)" == "256" ]]; then
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=160
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=037,bold #,standout
    ZSH_HIGHLIGHT_STYLES[alias]=fg=064,bold
    ZSH_HIGHLIGHT_STYLES[builtin]=fg=064,bold
    ZSH_HIGHLIGHT_STYLES[function]=fg=064,bold
    ZSH_HIGHLIGHT_STYLES[command]=fg=064,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=064,underline
    ZSH_HIGHLIGHT_STYLES[commandseparator]=none
    ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=037
    ZSH_HIGHLIGHT_STYLES[path]=fg=166,underline
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=033
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=125,bold
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=125,bold
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=136
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=136
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=136
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=136
    ZSH_HIGHLIGHT_STYLES[assign]=fg=037
fi

# dircolors

if [[ "$OSTYPE" == linux-gnu* ]] && [[ "$(tput colors)" == "256" ]]; then
    eval $(dircolors =(cat ~/.shell/plugins/dircolors-solarized/dircolors.256dark ~/.shell/dircolors.extra))
fi

# setup fzf completion
if fzf --zsh > /dev/null ; then
    source <(fzf --zsh)
fi

# zsh-interactive-cd
source ~/.zsh/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh

# enable autojump
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u

# fzf: autojump integration
j() {
    local preview_cmd="ls {2..}"
    if command -v exa &> /dev/null; then
        preview_cmd="exa -l {2}"
    fi

    if [[ $# -eq 0 ]]; then
                 cd "$(autojump -s | sort -k1gr | awk -F : '$1 ~ /[0-9]/ && $2 ~ /^\s*\// {print $1 $2}' | fzf --height 40% --reverse --inline-info --preview "$preview_cmd" --preview-window down:50% | cut -d$'\t' -f2- | sed 's/^\s*//')"
    else
        cd $(autojump $@)
    fi
}
