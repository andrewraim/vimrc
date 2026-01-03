function! GitInfo(path) abort
	if &modifiable
		try
			execute 'lcd' fnamemodify(a:path, ":h")
		catch
			return ""
		endtry

		let gitrepoparse = system("git rev-parse --show-toplevel | xargs basename")
		if v:shell_error != 0
			return ""
		endif
		let gitrepo = substitute(gitrepoparse, '\n', '', 'g')

		let gitrevparse = system("git rev-parse --abbrev-ref HEAD")
		if v:shell_error != 0
			return ""
		endif
		let gitrev = substitute(gitrevparse, '\n', '', 'g')

		lcd -
		return "(".gitrepo.":".gitrev.")"
	endif
endfunction

" Send text to the first terminal in the terminal list
function! SendToTerm(content)
	let tl = term_list()
	if len(tl) == 0
		echom "No terminal buffer found"
		return
	endif

	let term_buf_nr = tl[0]
	if bufexists(term_buf_nr) && getbufvar(term_buf_nr, '&buftype') ==# 'terminal'
		call term_sendkeys(term_buf_nr, a:content)
	else
		echom "No terminal buffer found"
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

