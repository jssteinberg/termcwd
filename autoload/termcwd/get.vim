function! termcwd#get#key(term, cwd) abort
	return type(a:term) != v:t_string ? string(a:term) : a:term . "_" . a:cwd
endfunction
