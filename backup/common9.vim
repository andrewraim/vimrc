vim9script

# These functions are not quite working. How to execute the commands with the
# copied text selection?

# def g:MarkdownBlockType(x: string)
#	def MenuHandler(sel: string, id: number, idx: number)
#		var value = ""
#		if idx < 0
#			return
#		elseif idx == 1
#			value = ""
#		else 
#			value = getbufline(winbufnr(id), idx)[0]
#		endif
#		execute printf("normal! o ``` %s", value)
#		execute printf("normal! o %s", sel)
#		execute "normal! o ```"
#	enddef
#
#	var opts = ['<None>', '{}', '{r}', '{python}', '{julia}', '{latex}']
#
#	call popup_menu(opts, {
#		title: 'Code Block Type',
#		callback: (id, idx) => MenuHandler(x, id, idx)
#	})
#enddef


def g:MarkdownBlockType()
	def MenuHandler(id: number, idx: number)
		if idx < 0
			return
		endif

		var value = ""
		if idx > 1
			value = getbufline(winbufnr(id), idx)[0]
		endif

		#execute printf("c ```%s\<CR><C-r>\"\<CR>```\<CR>", value)
		#execute printf("c %s%s", '```', '<ESC>')
		#execute printf("command! echom 'Good Job %s", '<CR>')
		# command "echom 'Good Job'"
		echom 'Good Job<CR>'
	enddef

	var opts = ['<None>', '{}', '{r}', '{python}', '{julia}', '{latex}']

	call popup_menu(opts, {
		title: 'Code Block Type',
		callback: (id, idx) => MenuHandler(id, idx)
	})
enddef

