" Turn off "conceal' in markdown so text just renders normally
" Search for "quarto-vim conceallevel in vimrc"
augroup QuartoConceal
	autocmd!
	" Apply conceallevel for Quarto files (*.qmd)
	autocmd FileType quarto setlocal conceallevel=0
augroup END

