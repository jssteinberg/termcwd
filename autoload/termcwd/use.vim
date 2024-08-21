function! termcwd#use#firstWindowOccurence(bufnr) abort
	" Go to first occurrence of terminal in another window
	for l:w_nr in range(1, winnr("$"))
		if l:w_nr != winnr() && winbufnr(l:w_nr) == a:bufnr
			" winnr to close (current window)
			let l:notUse = winnr()

			exe l:w_nr . "wincmd w"

			try
				exe l:notUse . "hide"
			catch | finally
				return v:true
			endt
		endif
	endfor
endfunction

function! termcwd#use#lastWindowOccurence(bufnr) abort
	" Go to last occurrence of terminal in another window
	for l:w_nr in range(winnr("$"), 1, -1)
		if l:w_nr != winnr() && winbufnr(l:w_nr) == a:bufnr
			" winnr to close (current window)
			let l:notUse = winnr()

			exe l:w_nr . "wincmd w"

			try
				exe l:notUse . "hide"
			catch | finally
				return v:true
			endt
		endif
	endfor
endfunction
