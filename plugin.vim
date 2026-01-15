filetype plugin on

let s:plugin_dir = expand('~/.vim/plugged')

" Plugin function from <https://www.tonybtw.com/tutorial/vim>
function! s:ensure(repo)
	let name = split(a:repo, '/')[-1]
	let path = s:plugin_dir . '/' . name

	if !isdirectory(path)
		if !isdirectory(s:plugin_dir)
			call mkdir(s:plugin_dir, 'p')
		endif
	execute '!git clone --depth=1 https://github.com/' . a:repo . ' ' . shellescape(path)
	endif

	execute 'set runtimepath+=' . fnameescape(path)
endfunction

call s:ensure('ubaldot/vim-outline')

" ----- Configuration -----

" export var patterns = {
" ...
"   quarto: [
"     (_, val) => val =~ '^\s*#\+[^|]'
"   ],
" ...
" }

" export var sanitizers = {
" ...
"   quarto: [
"     {'\v^(\s*)(#)': '\2'},
"     {'^#\+': "\\=repeat(' ', 2 * len(submatch(0)))"},
"     {'^\s\{3}': ''},
"     {'{.*}': ''}
"   ],
" ...
" }
