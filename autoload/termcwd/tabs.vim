function! termcwd#tabs#toggle(t_bufnr, get) abort
	" if fromTab has a single window with interacted terminal (bufnr), close both
	" else, loop tabs, if two tabs has single window with terminal bufnr, close the other tab (TODO: reuse tab)
	if winlayout(a:get.fromTab)[0] == "leaf" && a:get.prev == a:t_bufnr
		" win layout of prev tab was single window with terminal
		exe a:get.fromTab . "tabclose"
		try | tabclose | catch | endt
		return v:false
	else
		" check if any other tab has single window layout with terminal
		for l:tab in range(1, tabpagenr("$"))
			if l:tab != tabpagenr() && winlayout(l:tab)[0] == "leaf" && tabpagebuflist(l:tab)[0] == a:t_bufnr
				exe l:tab . "tabclose"
				break
			endif
		endfor
	endif
endfunction
