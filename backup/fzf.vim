" fzf keymaps

" Files
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fo :History<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fq :CList<CR>    " For quickfix list
nnoremap <leader>fh :Helptags<CR>

" Ripgrep
" 1. Current string
" 2. Grep input string (fzf prompt)
" 3. Grep for current file name (without extension)
" 4. Files in your Vim config
nnoremap <leader>fs :Rg <C-r><C-w><CR>
nnoremap <leader>fg :Rg<Space>
nnoremap <leader>fc :execute 'Rg ' . expand('%:t:r')<CR>
nnoremap <leader>fi :Files ~/.vim<CR>

