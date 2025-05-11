" config/functions.vim

"""
""" COMMENT
"""
func! Comment(mode)
    " get info
    let char = GetCommentChar()
    let s_range = GetSelectionRange(a:mode)

    " check commented
    let is_commented = 0
    for i in range(s_range[0], s_range[0] + s_range[1] - 1)
        if !(matchstr(getline(i), '^\s*' .. char) == '')
            let is_commented = 1
        endif
    endfor

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
            let s = whitespace .. substitute(s, '^\s*' .. char, '', '')
        else
            let s = whitespace .. char .. ' ' .. s[len(whitespace):]
        endif

        call setline(line, s)
    endfor
endfunction

func! GetSelectionRange(mode)
    if a:mode == 'n'
        let line = line('.')
        return [line, 1]
    elseif a:mode == 'v'
        let line_start = getpos("'<")[1]
        let line_end = getpos("'>")[1]
        return [line_start, line_end - line_start + 1]
    endif

    echo "Unknown filetype"
    echo a:mode
    return [0, 0]
endfunction

func! GetCommentChar()
    if &filetype == 'python'
        return "#"
    elseif &filetype == 'vim'
        return "\""
    elseif &filetype == 'c' || &filetype == 'cpp' || &filetype == 'rust' || &filetype == 'java'
        return "//"
    endif

    echo "Unknown filetype for comment"
    return "#"
endfunction

"""
""" RUNNING
"""

func! Run()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %< && !./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %< && ./%<"
    elseif &filetype == 'python'
        exec "!python3 %"
    elseif &filetype == 'rust'
        exec "!rustc %"
        exec "!./%<"
    endif
endfunc

"""
""" SMALLER UTILS
"""
func! DeleteTrailingSpaces()
	let c = getcurpos()
	substitute/\s\+$//e
	" no snapping
	call setpos(".", c)
endfunction

func! RestoreCursor()
    if line("'\"") <= line("$")
        normal! g`"
    endif
endfunc

func! IndentLogic()
    if &filetype == 'python'
        filetype plugin indent on
    endif
endfunc

