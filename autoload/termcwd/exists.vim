" returns true if terminal is open and focused
function! termcwd#exists#toggleWindows(t_bufnr, get) abort
	" hide other equal terms
	let l:others_len = a:get.fromTab ? 0 : s:HideOtherWinbufnrs()

	if a:get.fromTab
		" if fromTab has a single window with interacted terminal (bufnr), close both
		" else, loop tabs, if two tabs has single window with terminal bufnr, close the other tab (TODO: reuse tab)
		if winlayout(a:get.fromTab)[0] == "leaf" && a:get.prev == bufnr()
			exe a:get.fromTab . "tabclose"
			try | tabclose | catch | endt
			return v:false
		" else
		" 	for l:t_nr in range(1, tabpagenr("$"))
		" 		if l:t_nr != tabpagenr() && winlayout(l:t_nr)[0] == "leaf" && winbufnr(tabpagewinnr(l:t_nr)) == a:t_bufnr
		" 			exe l:t_nr . "tabclose"
		" 			break
		" 		endif
		" 	endfor
		endif
	else
		let l:toClose = a:get.prev == bufnr()

		if a:get.split && l:others_len && l:toClose
			" if get.prev is equal hide current focused window or open alt
			try | hide
			catch | try | exe "b#" | catch | echo "No alternate file" | endt
			finally | return v:false
			endtry
		elseif l:toClose
			try | exe "b#"
			catch | echo "No alternate file"
			finally | return v:false
			endtry
		endif
	endif

	return v:true
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
