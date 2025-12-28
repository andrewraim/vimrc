" Set leader key to be space
let mapleader = " "

" Open netrw (default file browser) with <leader>cd
nnoremap <leader>cd :Ex<CR>

" Ctrl + nav keys to move between windows
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-l> :wincmd l<CR>

" In insert mode, ctrl-space brings up native autocompetion. Include other
" related commands that may be sent by terminals in lieu of ctrl-space.
inoremap <C-Space> <C-n>
inoremap <C-@> <C-n>
inoremap <NUL> <C-n>
