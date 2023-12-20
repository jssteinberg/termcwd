function! termcwd#use#firstWindowOccurence(bufnr) abort
	" Go to first occurence of terminal in another window and hide
	" current
	for l:w_nr in range(1, winnr("$"))
		if l:w_nr != winnr() && winbufnr(l:w_nr) == a:bufnr
			" winnr to close (current window)
			let l:notUse = winnr()
			exe l:w_nr . "wincmd w"
			try | exe l:notUse . "hide" | catch | finally | break | endt
		endif
	endfor

	call termcwd#hide#allOtherBufwinnrInTab()
endfunction
