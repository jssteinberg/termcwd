function! termcwd#set#mode(conditions) abort
	if has("nvim") && get(g:, "termcwd_insert", v:false) && a:conditions
		startinsert
	endif
endfunction
