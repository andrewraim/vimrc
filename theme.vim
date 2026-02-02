" Select a color scheme
colorscheme torte

" Turn off blinking cursor in GUI and make it grey
set guicursor+=a:blinkon0
highlight cursor guibg=grey

" The particular colors below fit the torte theme well. The website
" https://www.ditig.com/256-colors-cheat-sheethas a conversion between hex codes
" and terminal color codes.

" Highlight column 81.
set colorcolumn=81
hi ColorColumn guibg=#303030 ctermbg=236

" This will maintain transparent bg in terminal. For the GUI, use the bg from
" the theme.
hi Normal ctermbg=none

" highlight the line with the cursor
set cursorline
hi CursorLine guibg=#303030 term=none cterm=none ctermbg=236
