if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
	set fileencodings=utf-8,latin1
endif

set nocompatible        " Use Vim defaults (much better!)
set bs=2                " allow backspacing over everything in insert mode
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time

if has("autocmd")
	" In text files, always limit the width of text to 78 characters
	autocmd BufRead *.txt set tw=78

	" When editing a file, always jump to the last cursor position
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\ 	exe "normal! g'\"" |
	\ endif
endif

" Search path to include subfolders
set path+=**

" Switch syntax highlighting on, when the terminal has colors.
" Also switch on highlighting the last used search pattern.
" Also incremental search and highlight. This is nice to have, but can slow
" down over a slow network connection <https://vi.stackexchange.com/a/22065>
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
	set is hls
endif

" Turn off auto indenting
set nocindent
set nosmartindent
set noautoindent
set indentexpr=
filetype indent off
filetype plugin indent off

" Turn off mouse
set mouse=
set ttymouse=

" Tabs
" Display existing tabs as 4 spaces.
" When indenting with '>', use 4 spaces width.
set tabstop=4
set shiftwidth=4
set noexpandtab

" Case insensitive searching, unless capital letter(s) are used.
set ignorecase
set smartcase

" Use this to set either line numbers or relative line numbers in the gutter.
" Usually I like to have these off and use the gutter display.
" set number
" set relativenumber

" Use the system clipboard, which is "XA_SECONDARY" in X11.
set clipboard=unnamedplus

" c: Auto-wraps comments.
" r: Inserts the comment leader automatically when you press Enter.
" o: Inserts the comment leader when you use the o or O normal-mode commands to open a new line. 
set formatoptions-=c
set formatoptions+=r
set formatoptions-=o


