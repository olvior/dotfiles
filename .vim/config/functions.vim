" config/functions.vim

"""
""" COMMENT
"""
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
endfunc

func! GetCommentChar()
	let f = &filetype

    if f == 'python' || f == 'gdscript'
        return "#"
    elseif f == 'vim'
        return "\""
	elseif f == 'lua'
		return "--"
    elseif f == 'c' || f == 'cpp' || f == 'rust' || f == 'java'
        return "//"
    endif

    echo "Unknown filetype " .. f .. " for comment"
    return "#"
endfunc

"""
""" RUNNING
"""

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

"""
""" SMALLER UTILS
"""
func! DeleteTrailingSpaces()
    let c = getcurpos()
    substitute/\s\+$//e
    " no snapping
    call setpos(".", c)
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
    let path = expand("~/.vim/templates/template." .. fnamemodify(bufname(), ":e"))
    let s = readfile(path)
    call append("$", s)

    call deletebufline("", 1, 1)

    %s/<file>/\=expand("%<")/ge

    startinsert
    call SetCursorPlaceholder()
endfunc

func! GetBufferCount()
    return len(getbufinfo({'buflisted':1}))
endfunc

func! IndentLogic()
	" default to spaces
    set expandtab

    " if we start with a tab
    let t = searchpos('^\t', 'n')[0]
    " if we start with 4 spaces
    let s = searchpos('^ {4,}', 'n')[0]

    if (t < s) || (t != 0 && s == 0)
        set noexpandtab
    endif
endfunc

