# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# Cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# Python startup file
export PYTHONSTARTUP=$HOME/.pythonrc

### NNN
export NNN_OPTS='edrx'
export NNN_PLUG='o:fzopen;c:fzcd;p:preview-tui;t:preview-tabbed;i:imgview;j:autojump;d:diffs;a:ag;'
export NNN_COLORS='#1ba01cdc;4923'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_BATTHEME='TwoDark'
