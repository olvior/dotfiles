" no keeping comments
autocmd FileType * setlocal formatoptions-=ro

autocmd BufWinEnter * call CheckBufferCount()
autocmd BufWinEnter * call RestoreCursor()
autocmd BufWinEnter * call IndentLogic()

" only delete trailing spaces in text files
autocmd BufWritePre * if !&binary | call DeleteTrailingSpaces() | endif

