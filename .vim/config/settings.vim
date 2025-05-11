" config/settings.vim

" colours
colorscheme onedark

if $COLORTERM =~? '\v(truecolor|24bit)'
    set termguicolors
else
    echo "why does your terminal not have true color"
    set notermguicolors
endif

" sus only syntax once
if !exists("g:syntax_on")
    syntax enable
endif

" set the cursors
let &t_SI = "\e[6 q"
let &t_SR = "\e[2 q"
let &t_EI = "\e[2 q"

" timings
set timeoutlen=1000
set ttimeoutlen=0

set cursorline

set number
set relativenumber
set showmatch
" set scrolloff=5
" set lazyredraw

set ruler

set ignorecase
set smartcase
set incsearch
set hlsearch

set backspace=eol,start,indent
" set whichwrap+=<,>,h,l

" set hidden

set showcmd
set wildmenu
set wildoptions=pum
" set history=100

set undodir=~/.vim/.undo
set undofile
set viminfo='10,\"100,:20,%,n~/.vim/.viminfo

set shiftwidth=4
set softtabstop=4
set smarttab
set autoindent
set smartindent

set nowrap
set foldcolumn=1
set showtabline=1

set hidden
