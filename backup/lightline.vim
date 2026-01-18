" Needed to make sure the updated status bar displays.
set laststatus=2

runtime common.vim

" Add Git repo and branch to the lightline display
let g:lightline = {
\ 'active': {
\   'left': [ [ 'modeshort', 'paste' ],
\             [ 'readonly', 'filename', 'modified' ] ],
\   'right': [['lineinfo'], ['fileformat', 'filetype', 'git']]
\ },
\ 'component_function': {
\   'git': 'GitLightline',
\   'modeshort': 'Modes'
\ },
\ }

function! GitLightline()
	if exists("b:gitinfo")
		return b:gitinfo
	else
		return ""
	endif
endfunction

" Define custom mode names
function! Modes() abort
	let s:modes = {
		\ 'n' : 'N',
		\ 'i' : 'I',
		\ 'v' : 'V',
		\ 'V' : 'VL',
		\ "\<C-v>" : 'VB',
		\ 'c' : 'C',
		\ 's' : 'S',
		\ 'S' : 'SL',
		\ "\<C-s>" : 'SB',
		\ 'R' : 'R',
		\ 'Rv' : 'VR',
		\ 'O' : 'O',
		\ 't' : 'T',
		\ }
	return get(s:modes, mode(), mode())
endfunction

