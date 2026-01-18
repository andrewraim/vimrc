VIM := $(HOME)/.vim

SOURCES := vimrc completion.vim editor.vim keybinds.vim statusline.vim st.vim \
	theme.vim r.vim markdown.vim term.vim plugin.vim vim-outline.vim


.PHONY: install

install:
	mkdir -p $(VIM)
	cp $(SOURCES) $(VIM)/

