" The st terminal sends a certain set of Ctrl-arrow sequences which
" seem to work as expected with other applications, but not Vim. The following
" helps to fix it here. See: <https://unix.stackexchange.com/q/1709>.
map <ESC>[1;5A <C-Up>
map <ESC>[1;5B <C-Down>
map <ESC>[1;5D <C-Left>
map <ESC>[1;5C <C-Right>
map! <ESC>[1;5A <C-Up>
map! <ESC>[1;5B <C-Down>
map! <ESC>[1;5D <C-Left>
map! <ESC>[1;5C <C-Right>

