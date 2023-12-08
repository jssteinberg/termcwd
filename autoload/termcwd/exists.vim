function! termcwd#exists#doSmartHide(prev_bufnr, split = 1) abort
	" hide other equal terms
	let l:others_len = s:HideOtherWinbufnrs()

	" if prev_bufnr is equal hide current focused window or open alt
	if l:others_len < (1 + a:split) && a:prev_bufnr == bufnr()
		try
			hide
		catch
			try | exe "b#" | catch | echo "No alternate file" | endt
		endtry
	elseif get(g:, "termcwd_insert", v:false)
		startinsert
	endif
endfunction

function s:HideOtherWinbufnrs() abort
	let l:close_winnrs = []

	" store windows to close
	for l:w_nr in range(1, winnr("$"))
		if l:w_nr != winnr() && winbufnr(l:w_nr) == bufnr()
			call add(l:close_winnrs, l:w_nr)
		endif
		" break if 2 or more windows to close---need recursion
		if len(l:close_winnrs) > 1 | break | en
	endfor

	" hide all windows in close_winnrs recursively since new nrs when hide
	if len(l:close_winnrs) > 0 | exe l:close_winnrs[0] . "hide" | en
	if len(l:close_winnrs) > 1 | call s:HideOtherWinbufnrs() | en

	return len(l:close_winnrs)
endfunction
