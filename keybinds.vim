" Set leader key to be space
let mapleader = " "

" Open netrw (default file browser) with <leader>cd
nnoremap <leader>cd :Ex<cr>

" Unbind Q from entering 'Ex' mode
nnoremap Q <nop>

" Insert current date and time after the cursor
nnoremap <leader>dd "=strftime("%Y-%m-%d")<cr>p
nnoremap <leader>df "=strftime("%m/%d/%Y")<cr>p
nnoremap <leader>dt "=strftime("%H:%M:%S")<cr>p

" Toggle numbering
nnoremap <leader>nn :set number!<cr>
nnoremap <leader>nr :set relativenumber!<cr>

" ***** Navigation *****
" Navigate between windows and tabs with preferred cursor binds. Includes
" special consideration for terminal commands to take precedence over
" terminal binds.
" 
" I attempted to repeat for the nav keys, but they are not working correctly
" for some reason. But I don't use them that much, so I consider them low
" priority and have comment them out for now.

" Move focus between windows
"nmap <c-j>    <c-w>w
"nmap <c-k>    <c-w>W
nmap <c-down> <c-w>w
nmap <c-up>   <c-w>W
tmap <c-down> <c-w>w
tmap <c-up>   <c-w>W

" Arrange windows
"nmap <c-s-j>    <c-w>r
"nmap <c-s-k>    <c-w>R
nmap <c-s-down> <c-w>r
nmap <c-s-up>   <c-w>R
tmap <c-s-down> <c-w>r
tmap <c-s-up>   <c-w>R

" Move focus between tabs
"nnoremap <silent> <c-h>     :tabprevious<cr>
"nnoremap <silent> <c-l>     :tabnext<cr>
nnoremap <silent> <c-left>  :tabprevious<cr>
nnoremap <silent> <c-right> :tabnext<cr>

" Arrange tabs
"nnoremap <silent> <c-s-l>     :tabmove +<cr>
"nnoremap <silent> <c-s-h>     :tabmove -<cr>
nnoremap <silent> <c-s-left>  :tabmove +<cr>
nnoremap <silent> <c-s-right> :tabmove -<cr>

" Use cursor keys to scroll by visual lines (with wrapping). This covers
" normal, insert, visual, and select modes. For insert mode, make sure we do
" not interfere with the completion menu.
nnoremap <down> gj
nnoremap <up>   gk
vnoremap <down> gj
vnoremap <up>   gk
inoremap <expr> <down> pumvisible() ? "<down>" :"<c-o>gj"
inoremap <expr> <up>   pumvisible() ? "<up>"   :"<c-o>gk"

" Modify default 'gf' behavior. Create a new buffer if the target file does
" not exist yet. Then jump to the target whether it is a new buffer or an
" existing file. Normal and visual mode handled slightly differently.
nnoremap gf :e <cfile><cr>
vnoremap gf y :e <c-r>"<cr>

" ***** Completion *****
" In insert mode, ctrl-space brings up native competion. Include other
" related commands that may be sent by terminals in lieu of ctrl-space.
inoremap <c-space> <c-n>
inoremap <c-@> <c-n>
inoremap <NUL> <c-n>


