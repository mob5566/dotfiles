let $google_pystyle=fnamemodify(resolve(expand('<sfile>:p')), ':h') . "/google_python_style.vim"
if filereadable($google_pystyle)
    source $google_pystyle
endif
