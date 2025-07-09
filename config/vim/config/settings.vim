" config/settings.vim

if $COLORTERM =~? '\v(truecolor|24bit)'
    set termguicolors
else
    echo "why does your terminal not have true color"
    set notermguicolors
endif

" colours
" let g:tokyonight_style = 'storm'
" let g:tokyonight_enable_italic = 1
colorscheme tokyonight

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

set showcmd
set wildmenu
set wildoptions=pum
" set history=100

set undodir=~/.vim/.undo
set undofile
set viminfo='10,\"100,:20,%,n~/.vim/.viminfo

" tab stuff
" might expand the tabs depending on the detected
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
filetype plugin indent on

set nowrap
" set foldcolumn=1
" set showtabline=1

set hidden

" sus directory netrw stuff
" disable banner
let g:netrw_banner=0
" tree view
let g:netrw_liststyle=3
