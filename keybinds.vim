" Set leader key to be space
let mapleader = " "

" Open netrw (default file browser) with <leader>cd
nnoremap <leader>cd :Ex<CR>

" Unbind Q from entering 'Ex' mode
nnoremap Q <Nop>

" Insert current date and time after the cursor
nnoremap <leader>dd "=strftime("%Y-%m-%d")<CR>p
nnoremap <leader>df "=strftime("%m/%d/%Y")<CR>p
nnoremap <leader>dt "=strftime("%H:%M:%S")<CR>p

" Toggle numbering
nnoremap <leader>nn :set number!<CR>
nnoremap <leader>nr :set relativenumber!<CR>

" ***** Navigation *****
" Repeat for nav and cursor keys

" Move focus between windows
nnoremap <C-j>    :wincmd w<CR>
nnoremap <C-k>    :wincmd W<CR>
nnoremap <C-Down> :wincmd w<CR>
nnoremap <C-Up>   :wincmd W<CR>

" Arrange windows
nmap <C-S-j>    <C-w>r<ESC>
nmap <C-S-k>    <C-w>R<ESC>
nmap <C-S-Down> <C-w>r<ESC>:wincmd w<CR>
nmap <C-S-Up>   <C-w>R<ESC>:wincmd w<CR>

" Move focus between tabs
nnoremap <C-h>     :tabprevious<CR>
nnoremap <C-l>     :tabnext<CR>
nnoremap <C-Left>  :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Arrange tabs
nnoremap <C-S-l>     :tabmove +<CR>
nnoremap <C-S-h>     :tabmove -<CR>
nnoremap <C-S-Left>  :tabmove +<CR>
nnoremap <C-S-Right> :tabmove -<CR>

" Use cursor keys to scroll by visual lines (with wrapping). This covers
" normal, insert, visual, and select modes. For insert mode, make sure we do
" not interfere with the completion menu.
nnoremap <Down> gj
nnoremap <Up>   gk
vnoremap <Down> gj
vnoremap <Up>   gk
inoremap <expr> <Down> pumvisible() ? "<Down>" :"<C-O>gj"
inoremap <expr> <Up>   pumvisible() ? "<Up>"   :"<C-O>gk"

" Modify default 'gf' behavior. Create a new buffer if the target file does
" not exist yet. Then jump to the target whether it is a new buffer or an
" existing file. Normal and visual mode handled slightly differently.
nnoremap gf :e <cfile><CR>
vnoremap gf y :e <C-r>"<CR>

" ***** Completion *****
" In insert mode, ctrl-space brings up native competion. Include other
" related commands that may be sent by terminals in lieu of ctrl-space.
inoremap <C-Space> <C-n>
inoremap <C-@> <C-n>
inoremap <NUL> <C-n>

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
" - shortcut -> [shortcut]
" - ref -> [ref][ref]
" - link -> [link](link)
" - url -> <url>
" - code -> `code`
" - codeblock -> ```codeblock``` (with line breaks)
"
" For normal mode, source is word under cursor.
" For visual mode, source is selection.
"
" For code blocks, treat visual line and visual character mode slightly
" differently. We add an extra <CR> before the second fence in character mode
" to make sure the end marker is on it own line.
nnoremap <leader>m[ ciw[<C-r>"]<Esc>
nnoremap <leader>ml ciw[<C-r>"](<C-r>")<Esc>
nnoremap <leader>mr ciw[<C-r>"][<C-r>"]<Esc>
nnoremap <leader>mu ciW<<C-r>"><Esc>
nnoremap <leader>m` ciw`<C-r>"`<Esc>
nnoremap <leader>mc caw```<CR><C-r>"<CR>```<CR><Esc>
vnoremap <leader>m[ c[<C-r>"]<Esc>
vnoremap <leader>ml c[<C-r>"](<C-r>")<Esc>
vnoremap <leader>mr c[<C-r>"][<C-r>"]<Esc>
vnoremap <leader>mu c<<C-r>"><Esc>
vnoremap <leader>m` c`<C-r>"`<Esc>
xnoremap <expr> <leader>mc mode() ==# 'V' ?
\ 'c```<CR><C-r>"```<CR><Esc>' :
\ 'c```<CR><C-r>"<CR>```<CR><Esc>'

" These make current word or selection into a code block, and also prompt for a
" string label to be placed after the first fence.
nnoremap <leader>mv caw```.input("Block type: ").<CR><C-r>"<CR>```<CR><Esc>
xnoremap <expr> <leader>mv mode() ==# 'V' ?
\ 'c```'.input("Block type: ").'<CR><C-r>"```<CR><Esc>' :
\ 'c```'.input("Block type: ").'<CR><C-r>"<CR>```<CR><Esc>'

" Search for next and previous links; these are instances of strings in the
" form '[name](link)'.
nnoremap <silent> <leader>mn /\[.\{-}\](.\{-})/e-1<CR>:noh<CR>
nnoremap <silent> <leader>mp ?\[.\{-}\](.\{-})<CR>:noh<CR>

" Like the modified 'gf' keybinding from above, but assume the extension is
" omitted and add it. In particular, assume the extension is the same as the
" current file. This is especially useful for markdown-type links.
nnoremap <leader>gf :e <cfile>.%:e<CR>
vnoremap <leader>gf y :e <C-r>".%:e<CR>

" One step further for markdown-type files.
"
" Use Enter to follow links and backspace to jump back to the previous buffer
" position. Avoid mapping these in command mode because we need them to be
" working as usual there.
"
" Use Tab and S-Tab to search for next and previous links; these are instances
" of strings in the form '[name](link)'.
function! MarkdownBinds()
	nmap <CR> <leader>gf
	vmap <CR> <leader>gf
	nmap <BS> <C-o>
	vmap <BS> <C-o>
	nmap <Tab>   <leader>mn
	nmap <S-Tab> <leader>mp
endfunction

augroup MarkdownBindGroup
	autocmd!
	autocmd FileType markdown,quarto,rmd :call MarkdownBinds()
augroup END

" This doesn't quite work yet, but it should make a popup menu to select the
" type of code block to make
"vnoremap <leader>mc :call MarkdownBlockType()<CR>
function! MarkdownBlockType() abort
	function! MenuHandler(id, idx)
		if a:idx < 0
			return
		endif

		let value = ""
		if a:idx > 1
			let value = getbufline(winbufnr(a:id), a:idx)[0]
		endif

		"echom 'idx is '.a:idx
		"execute printf("c ```%s\<CR><C-r>\"\<CR>```\<CR>", value)
		"execute printf("c %s%s", '```', '<ESC>')
		"execute printf("command! echom 'Good Job %s", '<CR>')
		"echom 'Good Job'
		"execute 'c```\<CR>\<C-r>\"```\<CR>\<Esc>'

		"echom getreg('""')
		"execute '<ESC>'
		"execute "normal! c " . '```'. expand('<CR>').getreg('""').expand('<CR>').'```'.expand('<CR>')
	endfunction

	let items = ['<None>', '{}', '{r}', '{python}', '{julia}', '{latex}']

	let args = #{
    \ title: 'Code Block Type',
    \ callback: 'MenuHandler'
    \}

	call popup_menu(items, args)
	return "abcdef"
endfunction

