set nocompatible " not vi compatible

" local customizations in ~/.vimrc_local_before
let $LOCALFILE=expand("~/.vimrc_local_before")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

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
set autoread " when a file has been detected changed, auto read it again
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

" fold brackets
nnoremap zB zfaB
nnoremap zb zfab

"---------------------
" Plugin configuration
"---------------------

" nerdtree
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=3
let NERDTreeMapOpenInTab='<C-T>'
let NERDTreeMapOpenVSplit='<C-V>'
let NERDTreeMapOpenSplit='<C-X>'

" tagbar
nnoremap <Leader>t :TagbarToggle<CR>

" gundo
nnoremap <Leader>u :GundoToggle<CR>
if has('python3')
    let g:gundo_prefer_python3 = 1
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

" jedi-vim
let g:jedi#auto_initialization = 1
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#popup_on_dot = 0
let g:jedi#goto_command = ""
let g:jedi#goto_stubs_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""

" promptline
let promptline_git_branch = {
    \'function_name': 'git_branch',
    \'function_body': [
    \    'function git_branch {',
    \    '  local br',
    \    '  if ! timeout 3 git rev-parse >/dev/null 2>&1; then',
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

" indentLine
let g:indentLine_color_term = 114
let g:indentLine_char = '┆'

" clang-format
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)

" vimtex
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_manual = 1
let g:vimtex_syntax_conceal_disable = 1

" YouCompleteMe
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>jn :YcmCompleter GoToReferences<CR>
nnoremap <leader>js :YcmCompleter GoToSymbol <C-R><C-W><CR>
nnoremap <leader>jf :YcmCompleter FixIt<CR>
nmap <leader>D <plug>(YCMHover)
nmap <leader>yfw <Plug>(YCMFindSymbolInWorkspace)
nmap <leader>yfd <Plug>(YCMFindSymbolInDocument)

" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_clangd_args = ['-log=verbose', '-pretty', '--all-scopes-completion']
let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.'],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \            're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
  \   'python': [ 're!\w{2}', 're!(import\s+|from\s+(\w+\s+(import\s+(\w+,\s+)*)?)?)' ],
  \   'ruby,rust': ['.', '::'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }

" Tagbar
let g:tagbar_file_size_limit = 524288 " 512K
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#searchcount#enabled = 0

" fzf
"   mimic CtrlP
nnoremap <C-P> :GFiles<CR>
nnoremap ; :Buffers<CR>
"   mimic Ag
command! -nargs=+ Grg Gcd | Rg <args>
nnoremap K :Grg <C-R><C-W><CR>
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd --type f --strip-cwd-prefix')

"---------------------
" Local customizations
"---------------------

" local customizations in ~/.vimrc_local_after
let $LOCALFILE=expand("~/.vimrc_local_after")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
