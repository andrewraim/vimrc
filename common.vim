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

