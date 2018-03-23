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
set listchars=tab:>>,nbsp:~ " set list to see tabs and non-breakable spaces
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
" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" smart case-sensitive search
set ignorecase
set smartcase
" tab completion for files/bufferss
set wildmode=longest,list
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

" insert date
nnoremap <F2> :read !date -I<CR>kJ<ESC>

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

" ctrlp
nnoremap ; :CtrlPBuffer<CR>
let g:ctrlp_switch_buffer = 0
let g:ctrlp_show_hidden = 1

" ag
let g:ag_mapping_message=0
command! -nargs=+ Gag Gcd | Ag! <args>
nnoremap K :Gag "\b<C-R><C-W>\b"<CR>:cw<CR>
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

"---------------------
" Local customizations
"---------------------

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
