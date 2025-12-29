function! GitInfo(path) abort
	if &modifiable
		try
			execute 'lcd' fnamemodify(a:path, ":h")
		catch
			return ""
		endtry

		let gitrepoparse = system("git rev-parse --show-toplevel | xargs basename")
		if gitrepoparse !~ "fatal: not a git repository"
			let gitrepo = substitute(gitrepoparse, '\n', '', 'g')
		else
			return ""
		endif

		let gitrevparse = system("git rev-parse --abbrev-ref HEAD")
		if gitrevparse !~ "fatal: not a git repository"
			let gitrev = substitute(gitrevparse, '\n', '', 'g')
		else
			return ""
		endif

		lcd -
		return "(".gitrepo.":".gitrev.")"
	endif
endfunction
