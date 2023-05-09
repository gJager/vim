" Tabs
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

" Turn off mouse
set mouse=

" Set Leader key to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" Create a terminal
nnoremap <leader>t :term<CR>:keepalt file<space>

" Escape from terminal
tnoremap <esc> <C-\><C-n>

" Quicker buffer changes
nnoremap <leader>b :b<space>

" Window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Prevent quitting when closing windows
cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>

" Make the cwd the current directory
set autochdir

