" Custom status bar without a plugin.
" This is adapted from <https://tomdaly.dev/post/vanilla-vim-statusline>

runtime common.vim

" Need this for the status line to render initially
set laststatus=2

function! StatuslineActive() abort
	let l:out = ''                " left align
	let l:out .= '%1*'            " switch color schemes
	let l:out .= ShortMode()     " vim mode using 1-2 chars 
	"let l:out .= LongMode()       " vim mode with readable label
	let l:out .= '%2*'            " switch color schemes
	let l:out .= ' '              " blank char
	let l:out .= '%.40f'          " relative path
	let l:out .= ' '              " blank char
	let l:out .= '%h%m%r'         " file flags (help, modified, read-only)
	let l:out .= '%3*'            " switch color schemes
	let l:out .= '%='             " right align
	let l:out .= '%*'
	let l:out .= '%4*'            " switch color schemes
	let l:out .= GitStatusLine()  " include git repo and branch
	let l:out .= '%5*'            " switch color schemes
	let l:out .= ' '              " blank char
	let l:out .= '%{&ff}'         " file format
	let l:out .= ' '              " blank char
	let l:out .= '%y'             " file type
	"let l:out = ' '              " blank char
	let l:out .= '%6*'            " switch color schemes
	let l:out .= '%4p'            " progress through file (%) of cursor
	let l:out .= '%%'             " percent sign
	let l:out .= '%7*'            " switch color schemes
	let l:out .= '%5l'            " cursor position
	let l:out .= ':'              " separator
	let l:out .= '%-5c'           " column position
	let l:out .= GetBuffer()      " buffer number, if more than one buffer
	return l:out
endfunction

" Same as active status line, but use dull colors to signify inactivity.
" We should rewrite this to use the same content and take the colors as
" arguments.
function StatuslineInactive()
	let l:out = ''                " left align
	let l:out .= '%9*'            " switch color schemes
	"let l:out .= NoLongMode()    " *** Suppress mode on inactive window ***
	let l:out .= NoShortMode()    " *** Suppress mode on inactive window ***
	let l:out .= '%9*'            " switch color schemes
	let l:out .= ' '              " blank char
	let l:out .= '%.40f'          " relative path
	let l:out .= ' '              " blank char
	let l:out .= '%h%m%r'         " file flags (help, modified, read-only)
	let l:out .= '%9*'            " switch color schemes
	let l:out .= '%='             " right align
	let l:out .= '%*'
	let l:out .= '%9*'            " switch color schemes
	"let l:out .= GitStatusLine() " *** Suppress mode on inactive window ***
	let l:out .= '%9*'            " switch color schemes
	let l:out .= ' '              " blank char
	let l:out .= '%{&ff}'         " file format
	let l:out .= ' '              " blank char
	let l:out .= '%y'             " file type
	"let l:out = ' '              " blank char
	let l:out .= '%9*'            " switch color schemes
	let l:out .= '%4p'            " progress through file (%) of cursor
	let l:out .= '%%'             " percent sign
	let l:out .= '%5l'            " cursor position
	let l:out .= ':'              " separator
	let l:out .= '%-5c'           " column position
	let l:out .= GetBuffer()      " buffer number, if more than one buffer
	return l:out
endfunction

function! GitStatusLine()
	" Check if the b:gitinfo variable has been set (see autcmd below)
	" If not, return an empty string
	if !exists('b:gitinfo')
		return ""
	endif

	let l:out = get(b:, 'gitinfo')

	" If empty, print empty string without an extra space
	if len(l:out) == 0
		return ""
	endif

	" If not empty, add a leading space
	return printf(" %s", l:out)
endfunction

" This doesn't work the way I want. It returns the currently highlighted
" window.
function! GetWinBuf() abort
	if winnr('$') > 1 || bufnr('$') > 1
		return printf(" %s -> %s", bufnr(), winnr())
	else
		return ""
	endif
endfunction

" This doesn't work the way I want. It returns the currently highlighted
" window.
function! GetWindow()
	if winnr('$') > 1
		return printf( "%s", winnr())
	else
		return ""
	endif
endfunction

function! GetBuffer()
	if bufnr('$') > 1
		return "%n"
	else
		return ""
	endif
endfunction

" Define custom mode abbreviations
function! ShortMode() abort
	let s:modes = {
		\ 'n' : 'N ',
		\ 'i' : 'I ',
		\ 'v' : 'V ',
		\ 'V' : 'VL',
		\ "\<C-v>" : 'VB',
		\ 'c' : 'C ',
		\ 's' : 'S ',
		\ 'S' : 'SL',
		\ "\<C-s>" : 'SB',
		\ 'R' : 'R ',
		\ 'Rv' : 'VR',
		\ 'O' : 'O ',
		\ 't' : 'T ',
		\ }
	return get(s:modes, mode(), mode())
endfunction

" Define custom mode names
function! LongMode() abort
	let s:modes = {
		\ 'n' :      'NORMAL  ',
		\ 'i' :      'INSERT  ',
		\ 'v' :      'VISUAL  ',
		\ 'V' :      'V-LINE  ',
		\ "\<C-v>" : 'V-BLOCK ',
		\ 'c' :      'COMMAND ',
		\ 's' :      'SELECT  ',
		\ 'S' :      'S-LINE  ',
		\ "\<C-s>" : 'S-BLOCK ',
		\ 'R' :      'REPLACE ',
		\ 'Rv' :     'VREPLACE',
		\ 'O' :      'OPERATOR',
		\ 't' :      'TERMINAL',
		\ }
	return get(s:modes, mode(), mode())
endfunction

function! NoLongMode() abort
	return '        '
endfunction

function! NoShortMode() abort
	return '  '
endfunction



" Here are a few themes I made from picking some colors.
" A nice color picker app is <https://michurin.github.io/xterm256-color-picker>

" Light text on shades of blue 
"hi User1 ctermbg=025 ctermfg=254 guibg=green guifg=white  " Info 1
"hi User2 ctermbg=024 ctermfg=254 guibg=blue  guifg=white  " Info 2
"hi User3 ctermbg=023 ctermfg=254 guibg=blue  guifg=white  " Info 3
"hi User4 ctermbg=023 ctermfg=254 guibg=gray  guifg=white  " Spacer
"hi User5 ctermbg=000 ctermfg=244 guibg=black guifg=grey   " Dimmed out

" Dark text on autumn colors
"hi User1 ctermbg=214 ctermfg=000 guibg=white guifg=black  " Info 1
"hi User2 ctermbg=220 ctermfg=000 guibg=white guifg=black  " Info 2
"hi User3 ctermbg=142 ctermfg=000 guibg=white guifg=black  " Info 3
"hi User4 ctermbg=142 ctermfg=000 guibg=white guifg=black  " Spacer
"hi User5 ctermbg=000 ctermfg=244 guibg=black guifg=grey   " Dimmed out

" Dark text on shades of lighter gray with just a hint of contrast
"hi User1 ctermbg=250 ctermfg=000 guibg=white guifg=black  " Info 1
"hi User2 ctermbg=248 ctermfg=000 guibg=white guifg=black  " Info 2
"hi User3 ctermbg=245 ctermfg=000 guibg=white guifg=black  " Info 3
"hi User4 ctermbg=245 ctermfg=000 guibg=white guifg=black  " Spacer
"hi User5 ctermbg=000 ctermfg=244 guibg=black guifg=grey   " Dimmed out

" Transition from blue to green
"hi User1 ctermbg=027 ctermfg=254 guibg=green guifg=white  " Info 1
"hi User2 ctermbg=026 ctermfg=254 guibg=blue  guifg=white  " Info 2
"hi User3 ctermbg=025 ctermfg=254 guibg=blue  guifg=white  " Info 3
"hi User4 ctermbg=024 ctermfg=254 guibg=gray  guifg=white  " Info 4
"hi User5 ctermbg=032 ctermfg=254 guibg=gray  guifg=white  " Info 5
"hi User6 ctermbg=031 ctermfg=254 guibg=gray  guifg=white  " Info 6
"hi User7 ctermbg=030 ctermfg=254 guibg=gray  guifg=white  " Info 7
"hi User9 ctermbg=000 ctermfg=244 guibg=black guifg=grey   " Dimmed out

" Blue with subtle contrast
hi User1 ctermbg=033 ctermfg=254 guibg=green guifg=white  " Info 1
hi User2 ctermbg=027 ctermfg=254 guibg=blue  guifg=white  " Info 2
hi User3 ctermbg=026 ctermfg=254 guibg=blue  guifg=white  " Info 3
hi User4 ctermbg=026 ctermfg=254 guibg=gray  guifg=white  " Info 4
hi User5 ctermbg=026 ctermfg=254 guibg=gray  guifg=white  " Info 5
hi User6 ctermbg=025 ctermfg=254 guibg=gray  guifg=white  " Info 6
hi User7 ctermbg=024 ctermfg=254 guibg=gray  guifg=white  " Info 7
hi User9 ctermbg=000 ctermfg=244 guibg=black guifg=grey   " Dimmed out


" Use different status lines for active and inactive windows.
" From Reddit comment:
" <https://www.reddit.com/r/vim/comments/nyrv7c/comment/h1ly6pt/>
augroup Statusline
	autocmd!
	autocmd BufEnter,WinEnter,TabEnter * setlocal statusline=%!StatuslineActive()
	autocmd BufLeave,WinLeave,TabLeave * setlocal statusline=%!StatuslineInactive()
	autocmd BufRead,BufWrite * let b:gitinfo = GitInfo(expand('%:f'))
augroup END

