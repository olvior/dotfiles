" config/autocommands.vim

" dont do comment continuation
autocmd FileType * setlocal formatoptions-=ro

autocmd BufWinEnter * call RestoreCursor()
autocmd BufWinEnter * call CheckBufferCount()
autocmd BufWinEnter * call IndentLogic()

autocmd BufWritePre * call DeleteTrailingSpaces()


