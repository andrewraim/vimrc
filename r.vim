function! RProjectRoot(path) abort
	let path = a:path
	let done = v:false

	while done == v:false
		let ff = expand(path) . "/" . 'DESCRIPTION'

		if filereadable(ff)
			return path
		endif

		let newpath = fnamemodify(path, ':h') 
		let done = (newpath == path)
		let path = newpath
	endwhile

	throw "Not within an R project: " . a:path
endfunction

function! RProjectMenu() abort
	function! MenuHandler(id, idx)
		" Get the selection from the menu
		if a:idx < 0
			return
		endif

		let sel = getbufline(winbufnr(a:id), a:idx)[0]

		" Recursively check the path to see if we are in an R project. If so,
		" Return the project root. If not, alert the user and return.
		try
			let projroot = RProjectRoot(getcwd())
		catch /.*/
			echom v:exception
			return
		endtry

		" Process the selection menu option
		if sel == 'Load'
			let cmd = printf('devtools::load_all("%s")', projroot)
		elseif sel == 'Install'
			let cmd = printf('devtools::install_local("%s", force = TRUE)', projroot)
		elseif sel == 'Document'
			let cmd = printf('devtools::document("%s")', projroot)
		elseif sel == 'Test'
			let cmd = printf('devtools::test("%s")', projroot)
		elseif sel == 'Clean'
			let cmd = printf('devtools::clean_dll("%s")', projroot)
		elseif sel == 'Manual'
			let cmd = printf('devtools::build_manual("%s")', projroot)
		elseif sel == 'Vignettes'
			let cmd = printf('devtools::build_vignettes("%s")', projroot)
		elseif sel == 'Build Source'
			let cmd = printf('devtools::build("%s")', projroot)
		elseif sel == 'Build Binary'
			let cmd = printf('devtools::build("%s", binary = TRUE)', projroot)
		elseif sel == 'Check'
			let cmd = printf('devtools::check("%s")', projroot)
		endif

		" Look for a terminal which is dedicated to running R. It should have
		" buffer name 'R' and be in the 'running' state. If we find one of
		" those use it. Otherwise, alert the user to intervene.
		"
		" If an R terminal is running but doesn't have the 'R' buffer name, it
		" can be renamed as follows.
		" 1. Enter terminal normal mode with <c-\><c-n>\n"
		" 2. Run command ':file R'\n"
		" 3. Type 'i' to return to insert mode"
		"
		" A new one can be launched with ':term R' or ':vert term R'
		"
		" There may be a more robust way to do this...
		if term_getstatus(bufnr('R')) ==# 'finished'
			" If one is found in the 'finished' state, print an alert and
			" return.
			echom "Found an R terminal but it finished"
			return
		elseif term_getstatus(bufnr('R')) ==# '' && len(term_list()) > 0
			echom printf("Found %d terminals but none with buffer name 'R'",
			\ len(term_list()))
			return
		elseif term_getstatus(bufnr('R')) ==# ''
			echom "No R terminal found. Start one with ':term R' or ':vert term R'"
			return
		endif

		if term_getstatus(bufnr('R')) !=# 'running'
			echom "Expected a running R terminal, something went wrong"
		endif

		" Get the terminal and issue the command (and a newline) to it.
		call term_sendkeys(bufnr('R'), cmd)
		call term_sendkeys(bufnr('R'), "\n")
	endfunction

	" Get the project root again to display in the menu. Is there a way we
	" call once and use the variable in both places?
	try
		let projroot = RProjectRoot(getcwd())
	catch /.*/
		echom v:exception
		return
	endtry

	let items = [
	\ 'Load',
	\ 'Install',
	\ 'Document',
	\ 'Test',
	\ 'Clean',
	\ 'Manual',
	\ 'Vignettes',
	\ 'Build Source',
	\ 'Build Binary',
	\ 'Check'
	\ ]

	let args = #{
	\ title: 'R Project: ' . pathshorten(expand(projroot)),
	\ callback: 'MenuHandler'
	\ }

	call popup_menu(items, args)
endfunction

nnoremap <silent> <leader>r :call RProjectMenu()<cr>

