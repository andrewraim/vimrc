" Select a color scheme
colorscheme torte

" Highlight column 81. These particular colors are for torte theme.
" Note that guibg settings are for gvim, and cterm is for terminal.
set colorcolumn=81
hi ColorColumn guibg=#005577 ctermbg=4

" This will maintain transparent bg in terminal. For the GUI, use the bg from
" the theme.
hi Normal ctermbg=NONE

" highlight the line with the cursor
set cursorline
hi CursorLine term=none cterm=none ctermbg=236
