filetype plugin on

let s:plugin_dir = expand('~/.vim/plugged')

" Plugin function from <https://www.tonybtw.com/tutorial/vim>
function! s:ensure(repo)
	let name = split(a:repo, '/')[-1]
	let path = s:plugin_dir . '/' . name

	if !isdirectory(path)
		if !isdirectory(s:plugin_dir)
			call mkdir(s:plugin_dir, 'p')
		endif
	execute '!git clone --depth=1 https://github.com/' . a:repo . ' ' . shellescape(path)
	endif

	execute 'set runtimepath+=' . fnameescape(path)
endfunction

"call s:ensure('tpope/vim-fugitive')            " Git integration
"call s:ensure('itchyny/lightline.vim')         " Status bar
"call s:ensure('jpalardy/vim-slime')            " Interact with REPL in Vim
"call s:ensure('ervandew/supertab')             " Tab completion

call s:ensure('vimwiki/vimwiki')               " Wiki in Vim
call s:ensure('rust-lang/rust.vim')            " Rust language support
call s:ensure('JuliaEditorSupport/julia-vim')  " Julia language support

" For Quarto language support
" call s:ensure('vim-pandoc/vim-pandoc')
call s:ensure('vim-pandoc/vim-pandoc-syntax')
call s:ensure('quarto-dev/quarto-vim')

" Fuzzy finding
call s:ensure('junegunn/fzf')
call s:ensure('junegunn/fzf.vim')

" Tree to browse files
" call s:ensure('scrooloose/nerdtree')

" Nvim-R for R console within Vim
" call s:ensure('roxma/nvim-yarp')
" call s:ensure('jalvesaq/Nvim-R')
" call s:ensure('gaalcaras/ncm-r')

" ----- Configuration -----

" runtime lightline.vim
runtime quarto.vim
runtime fzf.vim

" Map F2 to toggling NERDTree on and off
" map <F2> :NERDTreeToggle<CR>

" Set up vim-slime for tmux.
" let g:slime_target = "tmux"

