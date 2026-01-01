VIM := $(HOME)/.vim

SOURCES := vimrc common.vim completion.vim editor.vim keybinds.vim
	statusline.vim st.vim theme.vim \

.PHONY: install

install:
	mkdir -p $(VIM)
	cp $(SOURCES) $(VIM)/

