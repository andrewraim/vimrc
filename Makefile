VIM := $(HOME)/.vim

SOURCES := common.vim completion.vim editor.vim fzf.vim keybinds.vim \
	lightline.vim main.vim plugin.vim quarto.vim statusline.vim st.vim \
	theme.vim vimwiki.vim

.PHONY: install

install:
	mkdir -p $(VIM)
	cp dot_vimrc $(HOME)/.vimrc
	cp $(SOURCES) $(VIM)/

