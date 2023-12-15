" returns true if terminal is open and focused
function! termcwd#exists#toggleWindows(t_bufnr, get) abort
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

		" TODO: use termcwd#hide#allOtherWinbufnrInTab() instead of if/else below?
		if a:get.split && l:toClose && s:HideOtherWinbufnrs()
			" if get.prev is equal hide current focused window or open alt
			try | hide
			catch | try | exe "b#" | catch | call s:NotifyNoAlt() | endt
			finally | return v:false
			endtry
		elseif l:toClose
			let l:toClose = bufnr()
			try | exe "b#"
			catch | call s:NotifyNoAlt()
			finally
				call termcwd#hide#allOtherBufwinnrInTab(l:toClose)
				return v:false
			endtry
		endif

		" Go to first occurence of terminal in another window and hide
		" current
		for l:w_nr in range(1, winnr("$"))
			if l:w_nr != winnr() && winbufnr(l:w_nr) == a:t_bufnr
				" winnr to close (current window)
				let l:notUse = winnr()
				exe l:w_nr . "wincmd w"
				try | exe l:notUse . "hide" | catch | finally | break | endt
			endif
		endfor

		call termcwd#hide#allOtherBufwinnrInTab()
	endif

	return v:true
endfunction

function s:NotifyNoAlt() abort
	echo "No alternate file"
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
