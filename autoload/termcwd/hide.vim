" return number of windows closed
function! termcwd#hide#allOtherBufwinnrInTab(bufnr = bufnr()) abort
	let l:close_winnrs = []

	" store windows to close
	for l:w_nr in range(1, winnr("$"))
		if l:w_nr != winnr() && winbufnr(l:w_nr) == a:bufnr
			call add(l:close_winnrs, l:w_nr)
		endif
		" break if 2 or more windows to close---need recursion
		if len(l:close_winnrs) > 1 | break | en
	endfor

	let l:closed = len(l:close_winnrs) ? 1 : 0

	" hide all windows in close_winnrs recursively since new nrs when hide
	if len(l:close_winnrs) > 0 | exe l:close_winnrs[0] . "hide" | en
	if len(l:close_winnrs) > 1 | let l:closed += termcwd#hide#allOtherBufwinnrInTab() | en

	return l:closed
endfunction
