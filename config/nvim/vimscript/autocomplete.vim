"""
""" TAB / SNIPPETS
"""
inoremap <Tab> <Cmd>call Tab()<CR>
inoremap <S-Tab> <Cmd>call ShiftTab()<CR>

function! MoveCursorToPlaceholder()
    let c = searchpos("|", "c")
    if c != [0, 0]
        call setline(c[0], substitute(getline(c[0]), "|", "", ""))
        call cursor(c)
    endif
endfunction

" load snippets.json
let snippet_path = expand("~/.vim/snippets.json")
if filereadable(snippet_path)
    try
        let snippet_dict = json_decode(join(readfile(snippet_path), "\n"))
    catch
        echoerr "Error parsing snippets.json: " .. v:exception
    endtry
else
    let snippet_dict = {}
endif

function! GetWordBeforeCursor()
    return matchstr(strpart(getline("."), 0, col(".") - 1), '\k\+$')
endfunction

function! ExpandSnippet()
    let trigger = GetWordBeforeCursor()

    let current_dict = g:snippet_dict->get(&filetype)

    if empty(current_dict) || !has_key(current_dict, trigger)
        return v:false
    endif

    " indentation
    let base_indent = matchstr(getline("."), '^\s*')
    let indent_unit = &expandtab ? repeat(" ", &shiftwidth) : "\t" " not used

    " replace
    let content = deepcopy(current_dict[trigger])
    let content[0] = strpart(getline("."), 0, col(".") - 1 - strlen(trigger)) .. content[0]
    " format snippet
    for i in range(len(content))
        let content[i] = substitute(content[i], "\\", "\\\\", "g")
        if i > 0
            let content[i] = base_indent .. content[i]
        endif
    endfor

    " insert snippet
    call setline(".", content[0])
    call append(".", content[1:])
    call MoveCursorToPlaceholder()

    return v:true
endfunction

function! Tab()
    if pumvisible() " autocomplete
        call feedkeys("\<C-n>", "n")
    elseif ExpandSnippet() " snippets
        return
    elseif getline(".")[col(".")-2] =~ '\S'
        call feedkeys("\<C-n>", "n")
    else " normal tab
        call feedkeys("\<Tab>", "n")
    endif
endfunction

function! ShiftTab()
    if pumvisible()
        call feedkeys("\<C-p>", "n")
    elseif matchstr(getline("."), '^\s{1,}') != ''
        call feedkeys("\<C-h>", "n")
    else
        call Tab()
    endif
endfunction

