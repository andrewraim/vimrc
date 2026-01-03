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
" Repeat for nav and cursor keys. Also need special consideration for terminal
" commands to take precedence over terminal binds.

" Move focus between windows
nnoremap <c-j>    <c-w>w<esc>
nnoremap <c-k>    <c-w>W<esc>
nnoremap <c-down> <c-w>w<esc>
nnoremap <c-up>   <c-w>W<esc>
tnoremap <c-down> <c-w>w<esc>
tnoremap <c-up>   <c-w>W<esc>

" Arrange windows
nnoremap <c-s-j>    <c-w>r<esc>
nnoremap <c-s-k>    <c-w>R<esc>
nnoremap <c-s-down> <c-w>r<esc>
nnoremap <c-s-up>   <c-w>R<esc>
tnoremap <c-s-down> <c-w>r<esc>
tnoremap <c-s-up>   <c-w>R<esc>

" Move focus between tabs
nnoremap <silent> <c-h>     :tabprevious<cr>
nnoremap <silent> <c-l>     :tabnext<cr>
nnoremap <silent> <c-left>  :tabprevious<cr>
nnoremap <silent> <c-right> :tabnext<cr>

" Arrange tabs
nnoremap <silent> <c-s-l>     :tabmove +<cr>
nnoremap <silent> <c-s-h>     :tabmove -<cr>
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

" ***** Interaction with Terminal *****

" Send line or selection to an open terminal. Send current line in normal mode
" and selection in select mode. For normal mode, move cursor to the end of the
" line, then to the next non-whitespace character. For select mode, move the
" cursor to the end of the selection. Note that `> is a special mark that
" represents the end of the last selection.
nnoremap <silent> <leader><leader> :call SendToTerm(getline('.')."\n")<cr>g$/\S<cr>:nohl<cr>
vnoremap <silent> <leader><leader> y :<c-u>call SendToTerm(@")<cr>`>

" Start a terminal in a split with some command associated with the current
" buffer. This is especially intended for programming with an interactive
" interpreter.
function! FileTypeToTerm(vert)
	" Get the filetype of the current buffer and determine a corresponding
	" to issue in the terminal that we are about to spawn.
    if &filetype == 'r'
		let cmd = "R\n"
    elseif &filetype == 'julia'
		let cmd = "julia\n"
    elseif &filetype == 'python'
		let cmd = "python\n"
    else
		" For everything else, just launch the terminal itself
		let cmd = ""
    endif

	" Start terminal either with a vertical or horizontal split and run the
	" command from last step. Note that, if a nontrivial command is given, the
	" terminal will halt when the command exists.
	if a:vert
		execute "vertical terminal! " . cmd
	else
		execute "terminal! " . cmd
	endif

	" Move focus back to the previous buffer
	execute "normal! \<c-w>x"
endfunction

nnoremap <silent> <leader>th :call FileTypeToTerm(v:false)<cr>
nnoremap <silent> <leader>tv :call FileTypeToTerm(v:true)<cr>

" ***** Completion *****
" In insert mode, ctrl-space brings up native competion. Include other
" related commands that may be sent by terminals in lieu of ctrl-space.
inoremap <c-space> <c-n>
inoremap <c-@> <c-n>
inoremap <NUL> <c-n>

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

" Like the modified 'gf' keybinding from above, but assume the extension is
" omitted and add it. In particular, assume the extension is the same as the
" current file. This is especially useful for markdown-type links.
nnoremap <leader>gf :e <cfile>.%:e<cr>
vnoremap <leader>gf y :e <c-r>".%:e<cr>

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

