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

vnoremap <leader>y "*y
vnoremap <leader>d "*d

