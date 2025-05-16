" config/mappings.vim

let mapleader = ' '
nnoremap 0 ^
nnoremap ^ 0

inoremap jj <esc>
nnoremap ;n :tabn<CR>
nnoremap ;b :tabp<CR>
nnoremap ;t :tabnew<CR>
nnoremap ;x :tabclose<CR>

nnoremap <silent><leader>r :call Run()<CR>
nnoremap <silent><leader>rc :source $MYVIMRC<CR>
nnoremap <silent><space> :noh<CR>

vnoremap <silent><leader>c :<C-u>call Comment('v')<CR>
nnoremap <silent><leader>c :call Comment('n')<CR>
nnoremap <silent><leader>t :call LoadTemplate()<CR>

vnoremap <leader>y "*y
vnoremap <leader>d "*d

nnoremap <silent><tab> :bn<CR>
nnoremap <silent><S-tab> :bp<CR>

nnoremap <expr> ZZ GetBufferCount() == 1 ? "ZZ" : ":update<Bar>bdelete<CR>"
nnoremap <expr> <leader>q GetBufferCount() == 1 ? ":q!<CR>" : ":bdelete!<CR>"

nnoremap U <C-r>

