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
