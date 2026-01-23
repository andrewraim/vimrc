" ***** Markdown bindings *****
" Try to replicate some of the most useful behavior of Vimwiki. Aside from the
" custom bindings below, here are some useful default ones
"
" - gf: Open a file (but see above for modification)
" - gx: Open an external link
" - c-o: Jump back to previous buffer in history
" - c-i: Jump forward to next buffer in history 
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
" differently. We add an extra <cr> before the second fence in character mode
" to make sure the end marker is on it own line.
nnoremap <leader>m[ ciw[<c-r>"]<esc>
nnoremap <leader>ml ciw[<c-r>"](<c-r>")<esc>
nnoremap <leader>mr ciw[<c-r>"][<c-r>"]<esc>
nnoremap <leader>mu ciW<<c-r>"><esc>
nnoremap <leader>m` ciw`<c-r>"`<esc>
nnoremap <leader>mc caw```<cr><c-r>"<cr>```<cr><esc>
vnoremap <leader>m[ c[<c-r>"]<esc>
vnoremap <leader>ml c[<c-r>"](<c-r>")<esc>
vnoremap <leader>mr c[<c-r>"][<c-r>"]<esc>
vnoremap <leader>mu c<<c-r>"><esc>
vnoremap <leader>m` c`<c-r>"`<esc>
xnoremap <expr> <leader>mc mode() ==# 'V' ?
\ 'c```<cr><c-r>"```<cr><esc>' :
\ 'c```<cr><c-r>"<cr>```<cr><esc>'


" Turn text into list items: unordered, ordered, and todo (checkbox)
" TBD: what would we want to do in visual mode (line and char selections)?
nnoremap <leader>miu 0 I-<space><esc>
nnoremap <leader>mio 0 I1.<space><esc>
nnoremap <leader>mit 0 I-<space>[<space>]<space><esc>

" These make current word or selection into a code block, and also prompt for a
" string label to be placed after the first fence.
nnoremap <leader>mv caw```.input("Block type: ").<cr><c-r>"<cr>```<cr><esc>
xnoremap <expr> <leader>mv mode() ==# 'V' ?
\ 'c```'.input("Block type: ").'<cr><c-r>"```<cr><esc>' :
\ 'c```'.input("Block type: ").'<cr><c-r>"<cr>```<cr><esc>'

" Search for next and previous links; these are instances of strings in the
" form '[name](link)'.
nnoremap <silent> <leader>mn /\[.\{-}\](.\{-})/e-1<cr>:noh<cr>
nnoremap <silent> <leader>mp ?\[.\{-}\](.\{-})<cr>:noh<cr>

" Like the modified 'gf' keybinding, create the buffer if it does not exist.
" Here we also assume the extension is omitted and that the path is relative to
" the buffer (rather than the current working directory). In particular, assume
" the extension is the same as the current file.  This is especially for
" markdown-type links, but could be useful elsewhere.
nnoremap <leader>gf :e %:h/<cfile>.%:e<cr>
vnoremap <leader>gf y :e %:h/<c-r>".%:e<cr>

" One step further for markdown-type files.
"
" Use Enter to follow links and backspace to jump back to the previous buffer
" position. Avoid mapping these in command mode because we need them to be
" working as usual there.
"
" Use Tab and S-Tab to search for next and previous links; these are instances
" of strings in the form '[name](link)'.
function! MarkdownBinds()
	nmap <cr> <leader>gf
	vmap <cr> <leader>gf
	nmap <bs> <c-o>
	vmap <bs> <c-o>
	nmap <tab>   <leader>mn
	nmap <s-tab> <leader>mp
endfunction

augroup MarkdownBindGroup
	autocmd!
	autocmd FileType markdown,quarto,rmd :call MarkdownBinds()
augroup END

" This doesn't quite work yet, but it should make a popup menu to select the
" type of code block to make
"vnoremap <leader>mc :call MarkdownBlockType()<cr>
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
		"execute printf("c ```%s\<cr><c-r>\"\<cr>```\<cr>", value)
		"execute printf("c %s%s", '```', '<esc>')
		"execute printf("command! echom 'Good Job %s", '<cr>')
		"echom 'Good Job'
		"execute 'c```\<cr>\<c-r>\"```\<cr>\<esc>'

		"echom getreg('""')
		"execute '<esc>'
		"execute "normal! c " . '```'. expand('<cr>').getreg('""').expand('<cr>').'```'.expand('<cr>')
	endfunction

	let items = ['<None>', '{}', '{r}', '{python}', '{julia}', '{latex}']

	let args = #{
	\ title: 'Code Block Type',
	\ callback: 'MenuHandler'
	\}

	call popup_menu(items, args)
	return "abcdef"
endfunction

