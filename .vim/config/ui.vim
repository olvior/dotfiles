" config/ui.vim

" set laststatus=2
" set statusline=\ %#Cursor#\ %f\ %*
" set statusline+=%#DiffText#%h%*
" set statusline+=%#DiffDelete#%r%*
" set statusline+=%#DiffAdd#%m%*
" set statusline+=%=
" set statusline+=\ \ \ %-15.(%l,%c%V%)\ %P\

set showtabline=0

func! CheckBufferCount()
    if bufnr('$') > 1
    set showtabline=2
    endif
endfunc

func! TabLine()
    let s = "    "

    " alignment
    let l = line('$')
    if line('$') >= 1000
        let s .= ' '
    endif

    let spaces = '  '

    " attempt to fit more files in if need be
    if GetBufferCount() > 5
    let spaces = ''
    for i in range(1, 6 - GetBufferCount())
        let spaces .= ' '
    endfor
    endif

    for i in range(1, bufnr('$'))
        if buflisted(i) && bufloaded(i) && !empty(expand("%"))
            if i == bufnr("%")
                " let s .= "%#TabLineSel#"
                let s .= "%#Cursor#"
            else
                " let s .= "%#Cursor#"
                let s .= "%#TabLine#"
            endif
            let s .= " " .. fnamemodify(bufname(i), ':t')

            let s .= ' %*'
            if getbufinfo(i)[0].changed
                let s .= " %#DiffAdd#"
                let s .= "[+]"
                let s .= '%*'
            else
                let s .= "    "
            endif
            let s .= spaces
        endif
    endfor
    return s
endfunc

set tabline=%!TabLine()

" initial check
call CheckBufferCount()
