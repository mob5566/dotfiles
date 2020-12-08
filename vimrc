set nocompatible " not vi compatible

"--------------
" Load pathogen
"--------------
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

"------------------
" Syntax and indent
"------------------
syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them

" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" vim can autodetect this based on $TERM (e.g. 'xterm-256color')
" but it can be set to force 256 colors
" set t_Co=256
if has('gui_running')
    colorscheme bubblegum
elseif &t_Co < 256
    colorscheme default
    set nocursorline " looks bad in this mode
else
    set background=dark
    "let g:solarized_termcolors=256 " instead of 16 color with mapping in terminal
    colorscheme bubblegum

    let g:airline_powerline_fonts = 1
endif

filetype plugin indent on " enable file type detection
set autoindent

"---------------------
" Basic editing config
"---------------------
set nu " number lines
set rnu " relative line numbering
set incsearch " incremental search (as string is being typed)
set hls " highlight search
set list " show <Tab> and <EOL>
set listchars=tab:›\ ,nbsp:~ " set list to see tabs and non-breakable spaces
set lbr " line break
set ruler " show current position in file
set scrolloff=5 " show lines above and below cursor (when possible)
set noshowmode " hide mode
set laststatus=2
set showcmd " show current command
set backspace=indent,eol,start " allow backspacing over everything
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow O inserts
set lazyredraw " skip redrawing screen in some cases
set autochdir " automatically set current directory to directory of last opened file
set hidden " allow auto-hiding of edited buffers
set history=8192 " more history
set nojoinspaces " suppress inserting two spaces between sentences
set colorcolumn=80 " colored column at 80
" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" smart case-sensitive search
set ignorecase
set smartcase
" tab completion for files/bufferss
set wildmode=list:longest,full
set wildmenu
set mouse+=a " enable mouse mode (scrolling, selection, etc)
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

"--------------------
" Misc configurations
"--------------------

" unbind keys
map <C-a> <Nop>
map <C-x> <Nop>

" disable audible bell
set noerrorbells visualbell t_vb=

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" toggle relative numbering
nnoremap <C-n> :set rnu!<CR>

" save read-only files
command! -nargs=0 Sudow w !sudo tee % >/dev/null

" open quickfix window after grep
autocmd QuickFixCmdPost *grep* cwindow

" centering the cursor with \zz
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" copy to clipboard
nnoremap <F3> "+y
vnoremap <F3> "+y

"---------------------
" Plugin configuration
"---------------------

" nerdtree
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

" tagbar
nnoremap <Leader>t :TagbarToggle<CR>

" gundo
nnoremap <Leader>u :GundoToggle<CR>
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

" ctrlp
nnoremap ; :CtrlPBuffer<CR>
let g:ctrlp_switch_buffer = 0
let g:ctrlp_show_hidden = 1

" ag
let g:ag_mapping_message=0
command! -nargs=+ Gag Gcd | Ag! <args>
nnoremap K :Gag "\b""<C-R><C-W>""\b"<CR>:cw<CR>
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': []
\}
nnoremap <Leader>s :SyntasticCheck<CR>
nnoremap <Leader>r :SyntasticReset<CR>
nnoremap <Leader>i :SyntasticInfo<CR>
nnoremap <Leader>m :SyntasticToggleMode<CR>

" syntastic python checker
let g:syntastic_python_checkers = ['pylint', 'python']

" easymotion
map <Space> <Plug>(easymotion-prefix)

" incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" hightlight the word on cursor
nmap <Leader>h g/<C-R>_<C-W><CR>
vmap <Leader>h yg/<C-R>_"<CR>

" incsearch-easymotion
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

" argwrap
nnoremap <Leader>w :ArgWrap<CR>

" markdown
let g:markdown_fenced_languages = [
    \ 'bash=sh',
    \ 'c',
    \ 'coffee',
    \ 'erb=eruby',
    \ 'javascript',
    \ 'json',
    \ 'perl',
    \ 'python',
    \ 'ruby',
    \ 'yaml',
    \ 'go',
\]

" fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR>

" git vsplit diff
nnoremap <leader>gdi :Gvsplit! di<CR>
nnoremap <leader>gdis :Gvsplit! dis<CR>
nnoremap <leader>gdiw :Gvsplit! diw<CR> :AnsiEsc<CR>
nnoremap <leader>gdc :Gvsplit! dc<CR>
nnoremap <leader>gdcs :Gvsplit! dcs<CR>
nnoremap <leader>gdcw :Gvsplit! dcw<CR> :AnsiEsc<CR>
nnoremap <leader>gdh :Gvsplit! dh<CR>
nnoremap <leader>gdhs :Gvsplit! dhs<CR>
nnoremap <leader>gdhw :Gvsplit! dhw<CR> :AnsiEsc<CR>

" git vsplit log
nnoremap <leader>ggr :Gvsplit! gr<CR> :AnsiEsc<CR>
nnoremap <leader>ggrd :Gvsplit! grd<CR> :AnsiEsc<CR>
nnoremap <leader>ggrl :Gvsplit! grl<CR> :AnsiEsc<CR>
nnoremap <leader>ggra :Gvsplit! gra<CR> :AnsiEsc<CR>
nnoremap <leader>ggrad :Gvsplit! grad<CR> :AnsiEsc<CR>
nnoremap <leader>ggrdl :Gvsplit! gral<CR> :AnsiEsc<CR>

" promptline
let promptline_git_branch = {
    \'function_name': 'git_branch',
    \'function_body': [
    \    'function git_branch {',
    \    '  local br',
    \    '  if ! git rev-parse >/dev/null 2>&1; then',
    \    '    return 1',
    \    '  fi',
    \    '  if git symbolic-ref --quiet HEAD >/dev/null 2>&1; then',
    \    '    br=$(git rev-parse --abbrev-ref HEAD) 2>/dev/null',
    \    '  else',
    \    '    br=$(git rev-parse --short HEAD) 2>/dev/null',
    \    '  fi',
    \    '  printf "%s" "'.promptline#symbols#get().vcs_branch.'$br"',
    \    '}']}

let g:promptline_preset = {
    \'a' : [ promptline#slices#host() ],
    \'b' : [ promptline#slices#user() ],
    \'c' : [ promptline#slices#cwd() ],
    \'y' : [
    \    promptline#slices#python_virtualenv(),
    \    promptline#slices#git_status(),
    \    promptline_git_branch
    \],
    \'warn' : [ promptline#slices#last_exit_code() ]}

" cscope
if has("cscope")
    set csto=0
    set cst
    set nocsverb
    set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb

    " mappings
    nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>a :cs find a <C-R>=expand("<cword>")<CR><CR>

    " Using 'CTRL-\' then a search type makes the vim window
    " split horizontally, with search result displayed in
    " the new window.

    nmap <C-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>a :scs find a <C-R>=expand("<cword>")<CR><CR>

    " Hitting CTRL-\ *twice* before the search type does a vertical
    " split instead of a horizontal one

    nmap <C-\><C-\>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\><C-\>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>a :vert scs find a <C-R>=expand("<cword>")<CR><CR>
endif

" indentLine
let g:indentLine_color_term = 114
let g:indentLine_char = '┆'

"---------------------
" Local customizations
"---------------------

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
