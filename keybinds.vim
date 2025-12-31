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

" Use cursor keys to scroll by visual lines (with wrapping). This covers
" normal, insert, visual, and select modes. For insert mode, make sure we do
" not interfere with the autocomplete menu
nnoremap <Down> gj
nnoremap <Up>   gk
vnoremap <Down> gj
vnoremap <Up>   gk
inoremap <expr> <Down> pumvisible() ? "<Down>" :"<C-O>gj"
inoremap <expr> <Up>   pumvisible() ? "<Up>"   :"<C-O>gk"

" Unbind Q from entering 'Ex' mode
nnoremap Q <Nop>

" In insert mode, ctrl-space brings up native autocompetion. Include other
" related commands that may be sent by terminals in lieu of ctrl-space.
inoremap <C-Space> <C-n>
inoremap <C-@> <C-n>
inoremap <NUL> <C-n>

" Modify default 'gf' behavior. Create a new buffer if the target file does
" not exist yet. Then jump to the target whether it is a new buffer or an
" existing file. Normal and visual mode handled slightly differently.
nnoremap gf :e <cfile><CR>
vnoremap gf y :e <C-R>"<CR>

" ***** Markdown bindings *****
" Aside from the custom ones below, here are some useful default ones
" - gf: Open a file (but see above for modification)
" - gx: Open an external link
" - C-o: Jump back to previous buffer in history
" - C-i: Jump forward to next buffer in history 

" Create links in Markdown format: [ref][ref], [link](link), and <url>.
" In normal mode, link title and target is based on the word under cursor.
" In visual mode, link title and target are based on the word under selection.
nnoremap <leader>ml ciw[<C-r>"](<C-r>")<Esc>
nnoremap <leader>mr ciw[<C-r>"][<C-r>"]<Esc>
nnoremap <leader>mu ciw<<C-r>"><Esc>
vnoremap <leader>ml c[<C-r>"](<C-r>")<Esc>
vnoremap <leader>mr c[<C-r>"][<C-r>"]<Esc>
vnoremap <leader>mu c<<C-r>"><Esc>

" Like the modified 'gf' keybinding, but assume the 'md' extension is omitted
" and add it.
nnoremap <leader>mf :e <cfile>.md<CR>
vnoremap <leader>mf y :e <C-R>".md<CR>

