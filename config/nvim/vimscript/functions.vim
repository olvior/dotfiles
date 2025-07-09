" vimscript/functions.vim

""""""""""""""
" COMMENTING "
""""""""""""""

func! Comment(mode)
    " get info
    let char = GetCommentChar()
    let s_range = GetSelectionRange(a:mode)

    " check commented
    let commented = 0
    for i in range(s_range[0], s_range[0] + s_range[1] - 1)
        if !(matchstr(getline(i), '^\s*' .. char) == '')
            let commented += 1
        endif
    endfor

    let is_commented = 0
    if commented > s_range[1] / 2
        let is_commented = 1
    endif

    let line = s_range[0]

    " store initial whitespace
    let s = getline(line)
    let whitespace = matchstr(s, '^\s*')

    " set everything
    for line in range(s_range[0], s_range[0] + s_range[1] - 1)
        let s = getline(line)

        if is_commented
            " each one might just have their own size of whitespace
            let whitespace = matchstr(s, '^\s*')
            let s = substitute(s, '^\s*' .. char .. ' ', '', '')
            let s = whitespace .. s " substitute(s, '^\s*' .. char, '', '')
        else
            let s = whitespace .. char .. ' ' .. s[len(whitespace):]
        endif

        call setline(line, s)
    endfor
endfunc

func! GetCommentChar()
    let f = &filetype

    let f_to_c = { 'python': '#', 'gdscript': '#', 'vim': '"', 'lua': '--',
                \ 'c': '//', 'cpp': '//', 'java': '//',}

    let char = get(f_to_c, f, -1)

    if char == -1
        echo "Unknown filetype " .. f .. " for comment"
        return "#"
    else
        return char
    endif
endfunc

func! GetSelectionRange(mode)
    if a:mode == 'n'
        let line = line('.')
        return [line, 1]
    elseif a:mode == 'v'
        let line_start = getpos("'<")[1]
        let line_end = getpos("'>")[1]
        return [line_start, line_end - line_start + 1]
    endif

    echo "Unknown mode"
    echo a:mode
    return [0, 0]
endfunc

"""""""""""
" RUNNING "
"""""""""""

func! Run()
    update
    if &filetype == 'c'
        execute "!gcc % -o %< && ./%<"
    elseif &filetype == 'cpp'
        execute "!g++ % -o %< && ./%<"
    elseif &filetype == 'python'
        execute "!python3.11 %"
    elseif &filetype == 'java'
        execute "!java %"
    elseif &filetype == 'markdown'
        execute "!pandoc % -o %<.pdf && open %<.pdf"
    elseif &filetype == 'rust'
        execute "!rustc %"
        execute "!./%<"
    else
    echo "Filetype " .. &filetype .. " not recognised"
    endif
endfunc


"""""""""""""""
" OTHER UTILS "
"""""""""""""""

func! CheckBufferCount()
    if GetBufferCount() > 1
        set showtabline=2
    else
        set showtabline=0
    endif
endfunc

func! GetBufferCount()
    return len(getbufinfo({'buflisted':1}))
endfunc

func! RestoreCursor()
    if line("'\"") <= line("$")
        normal! g`"
    endif
endfunc

func! SetCursorPlaceholder()
    let c = searchpos("|", "c")
    if c != [0, 0]
        call setline(c[0], substitute(getline(c[0]), "|", "", ""))
        call cursor(c)
    endif
endfunc

func! LoadTemplate()
    call deletebufline("", 1, line("$"))
    let path = expand("~/.config/nvim/templates/template." .. fnamemodify(bufname(), ":e"))
    let s = readfile(path)
    call append("$", s)

    call deletebufline("", 1, 1)

    %s/<file>/\=expand("%<")/ge

    startinsert
    call SetCursorPlaceholder()
endfunc

func! IndentLogic()
    " default to spaces
    set expandtab

    let saved_pos = getcurpos()

    call cursor(1, 1)
    " if we start with a tab
    let t = search('^\t', 'n')
    " if we start with 4 spaces
    let s = search('^ \{4,\}', 'n')

    if ((t < s) && t != 0) || (t != 0 && s == 0)
        set noexpandtab
    elseif t != 0
        echo "Warning: potential mix of tabs & spaces"
    endif

    call setpos('.', saved_pos)
endfunc

func! DeleteTrailingSpaces()
    let c = getcurpos()
    %substitute/\s\+$//e
    " no snapping
    call setpos('.', c)
endfunc

