" ***** Interaction with Terminal *****
" Send text to the first terminal in the terminal list
function! SendToTerm(content)
	let tl = term_list()

	if len(tl) == 0
		echom "No terminal buffer found"
	else
		call term_sendkeys(tl[0], a:content)
	endif
endfunction

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

" Send line or selection to an open terminal.
" 
" - Normal mode: send current line and move cursor to the next non-whitespace
"   character after the line.
" - Line selection mode: send the selection, without an extra newline, and
"   place the cursor at the end of the selection.
" - Selection mode: send the selection and an extra newline, then place the 
"   cursor at the end of the selection.
"
" Note that `> is a special mark that represents the end of the last selection.
" There should be a more readable way to write the visual mode command. Maybe
" as a function?
nnoremap <silent> <leader><leader> :call SendToTerm(getline('.')."\n")<cr>g$
\:call search('\S', 'W')<cr>:nohl<cr>
xnoremap <expr> <silent> <leader><leader> mode() ==# 'V' ?
\ 'y :<c-u>call SendToTerm(@")<cr>`>' :
\ 'y :<c-u>call SendToTerm(@" . "\n")<cr>`>'

nnoremap <silent> <leader>th :call FileTypeToTerm(v:false)<cr>
nnoremap <silent> <leader>tv :call FileTypeToTerm(v:true)<cr>

