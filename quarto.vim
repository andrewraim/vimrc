" Turn off 'conceal' in markdown so text just renders normally
" Search web for 'quarto-vim conceallevel in vimrc'
augroup QuartoConceal
	autocmd!
	autocmd FileType quarto setlocal conceallevel=0
augroup END

