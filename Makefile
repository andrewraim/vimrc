VIM := $(HOME)/.vim

SOURCES := vimrc common.vim completion.vim editor.vim fzf.vim keybinds.vim \
	lightline.vim plugin.vim quarto.vim statusline.vim st.vim theme.vim \
	vimwiki.vim 

.PHONY: install

install:
	mkdir -p $(VIM)
	cp $(SOURCES) $(VIM)/

