" config/autocommands.vim

" dont do comment continuation
autocmd FileType * setlocal formatoptions-=ro

autocmd BufEnter    * call CheckBufferCount()
autocmd BufWinEnter * call RestoreCursor()
autocmd BufWinEnter * call IndentLogic()

autocmd BufWritePre * if !&binary | call DeleteTrailingSpaces() | endif


