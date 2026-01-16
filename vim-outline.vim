vim9script

filetype plugin on

# Quarto
# Similar to the markdown patterns, but ignore lines with `#|`, which are
# configuration items for R chunks. Also, do not show section materials
# between curly brackets.

g:outline_patterns = {
	'quarto': [
		(_, val) => val =~ '^\s*#\+[^|]'
	]
}
g:outline_sanitizers = {
	'quarto': [
		{'\v^(\s*)(#)': '\2'},
		{'^#\+': "\\=repeat(' ', 2 * len(submatch(0)))"},
		{'^\s\{3}': ''},
		{'{.*}': ''}
	]
}

