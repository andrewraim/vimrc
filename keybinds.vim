" Set leader key to be space
let mapleader = " "

" Open netrw (default file browser) with <leader>cd
nnoremap <leader>cd :Ex<CR>

" Ctrl + nav keys to move between windows and tabs
nnoremap <C-j> :wincmd w<CR>
nnoremap <C-k> :wincmd W<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Ctrl + cursor keys to move between windows and tabs
nnoremap <C-Down>  :wincmd w<CR>
nnoremap <C-Up>    :wincmd W<CR>
nnoremap <C-Left>  :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Use cursor keys to scroll by visual lines (with wrapping). This covers normal,
" insert, visual, and select modes.
nnoremap <Down> gj
nnoremap <Up>   gk
inoremap <Down> <C-O>gj
inoremap <Up>   <C-O>gk
vnoremap <Down> gj
vnoremap <Up>   gk

" Unbind Q from entering 'Ex' mode
nnoremap Q <Nop>

" In insert mode, ctrl-space brings up native autocompetion. Include other
" related commands that may be sent by terminals in lieu of ctrl-space.
inoremap <C-Space> <C-n>
inoremap <C-@> <C-n>
inoremap <NUL> <C-n>
