"   _  __(_)_ _  ________
"  | |/ / /  ' \/ __/ __/
"  |___/_/_/_/_/_/  \__/
"TODO personalize"

"essentials"
set nocompatible
set whichwrap+=<,>,h,l,[,]
set ttyfast
set mouse=a

nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>a

"life is better in colors"
colorscheme molokai
set t_Co=256
syntax enable

"interaction"
set ruler
set tabstop=2
set title
set nostartofline

"netrw"
let g:netrw_list_hide=".DS_Store,Desktop,Dropbox," .
    \                 "Public,Applications,Music," .
    \                 "Movies,Pictures,Documents," .
    \                 "Downloads,.Trash,^\.git/$"

" Default to tree listing
let g:netrw_liststyle = 3

"emacs-ish key-bindings"
imap <C-q> <Esc>
imap <C-d> <Del>
imap <C-a> <Home>
imap <C-e> <End>
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-r> <Left>
imap <C-f> <Right>

"ui"
set cursorline
set number
set numberwidth=2
set nowrap
set autoindent
set smartindent
set expandtab
set guioptions-=r " ScrollBar
set guioptions-=T " ToolBar
set shortmess=atI
set showmode
set listchars=tab:^\ ,eol:^,trail:_,nbsp:%
set list

"visual autocomplete for command menu"
set wildmenu

"search and highlight matches as chrs are entered"
set incsearch
set hlsearch
set ignorecase

"misc"
set viminfo+=n~/.vim/viminfo
