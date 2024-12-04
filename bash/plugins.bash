# dircolors
if [[ "$(tput colors)" == "256" ]]; then
    eval "$(dircolors ~/.shell/plugins/dircolors-solarized/dircolors.256dark)"
fi

# fzf
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
