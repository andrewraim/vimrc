" Completion menu for insert mode
"
" - Menu shows up to six choices
" - Menu pops up even if there is one choice
" - First suggestion is not inserted initially
" - No selection is selected initially
" - Fuzzy finding
set complete=.^6,w^6,b^6,u^6
set completeopt=menuone
set completeopt+=noinsert
set completeopt+=noselect
set completeopt+=fuzzy

" Completion menu for command mode
set wildmenu
set wildoptions+=pum
set wildoptions+=fuzzy

