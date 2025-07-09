let mapleader = ' '
nnoremap 0 ^
nnoremap ^ 0

inoremap jj <esc>

nnoremap <silent><leader>r :call Run()<CR>
nnoremap <silent><leader>rc :source $MYVIMRC<CR>
nnoremap <silent><space> :noh<CR>

vnoremap <silent><leader>c :<C-u>call Comment('v')<CR>
nnoremap <silent><leader>c :call Comment('n')<CR>
nnoremap <silent><leader>t :call LoadTemplate()<CR>

vnoremap <leader>y "+y
vnoremap <leader>d "*d

nnoremap <silent><tab> :bn<CR>zz
nnoremap <silent><S-tab> :bp<CR>zz

nnoremap <expr> <leader>q GetBufferCount() == 1 ? ":q!<CR>" : ":bdelete!<CR>:call CheckBufferCount()<CR>"


nnoremap <silent><leader>1 :b1<CR>
nnoremap <silent><leader>2 :b2<CR>
nnoremap <silent><leader>3 :b3<CR>
nnoremap <silent><leader>4 :b4<CR>
nnoremap <silent><leader>5 :b5<CR>
nnoremap <silent><leader>6 :b6<CR>
nnoremap <silent><leader>7 :b7<CR>
