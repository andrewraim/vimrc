" Menu shows up to six choices
set complete=.^6,w^6,b^6,u^6

" Options
"
" - Menu pops up even if there is one choice
" - First suggestion is not inserted initially
" - No selection is selected initially
" - Fuzzy finding
set completeopt=menuone
set completeopt+=noinsert
set completeopt+=noselect
set completeopt+=fuzzy

