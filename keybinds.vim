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
" not interfere with the autocomplete menu.
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

" Insert current date and time after the cursor
nnoremap <leader>dd "=strftime("%Y-%m-%d")<CR>p
nnoremap <leader>df "=strftime("%m/%d/%Y")<CR>p
nnoremap <leader>dt "=strftime("%H:%M:%S")<CR>p

" ***** Markdown bindings *****
" Try to replicate some of the most useful behavior of Vimwiki. Aside from the
" custom bindings below, here are some useful default ones
"
" - gf: Open a file (but see above for modification)
" - gx: Open an external link
" - C-o: Jump back to previous buffer in history
" - C-i: Jump forward to next buffer in history 
"
" The following 'leader' binds can be used within any file type. Additionally,
" we add some special (much more obvious) binds when editing markdown-type
" files.

" Encapsulate text with Markdown syntax.
" - ref -> [ref][ref]
" - link -> [link](link)
" - url -> <url>
" - code -> `code`
" - codeblock -> ```codeblock``` (with line breaks)
"
" In normal mode, source the word under cursor.
" In visual mode, source is selection.
nnoremap <leader>ml ciw[<C-r>"](<C-r>")<Esc>
nnoremap <leader>mr ciw[<C-r>"][<C-r>"]<Esc>
nnoremap <leader>mu ciw<<C-r>"><Esc>
nnoremap <leader>m` ciw`<C-r>"`<Esc>
nnoremap <leader>mc caw```<CR><C-r>"<CR>```<CR><Esc>
vnoremap <leader>ml c[<C-r>"](<C-r>")<Esc>
vnoremap <leader>mr c[<C-r>"][<C-r>"]<Esc>
vnoremap <leader>mu c<<C-r>"><Esc>
vnoremap <leader>m` c`<C-r>"`<Esc>
vnoremap <leader>mc c```<CR><C-r>"```<CR><Esc>

" Search for next and previous links; these are instances of strings in the
" form '[name](link)'.
nnoremap <silent> <leader>mn /\[.\{-}\](.\{-})/e-1<CR>:noh<CR>
nnoremap <silent> <leader>mp ?\[.\{-}\](.\{-})<CR>:noh<CR>

" Like the modified 'gf' keybinding from above, but assume the extension is
" omitted and add it. In particular, assume the extension is the same as the
" current file. This is especially useful for markdown-type links.
nnoremap <leader>gf :e <cfile>.%:e<CR>
vnoremap <leader>gf y :e <C-R>".%:e<CR>

" One step further for markdown-type files.
"
" Use Enter to follow links and backspace to jump back to the previous buffer
" position. Avoid mapping these in command mode because we need them to be
" working as usual there.
"
" Use Tab and S-Tab to search for next and previous links; these are instances
" of strings in the form '[name](link)'.
function! MarkdownBinds()
	nmap <CR> <leader>mf
	vmap <CR> <leader>mf
	nmap <BS> <C-o>
	vmap <BS> <C-o>
	nmap <Tab>   <leader>mn
	nmap <S-Tab> <leader>mp
endfunction

augroup MarkdownBindGroup
	autocmd!
	autocmd FileType markdown,quarto,rmd :call MarkdownBinds()
augroup END

