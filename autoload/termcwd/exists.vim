" returns true if terminal is open and focused
function! termcwd#exists#toggleTermcwd(t_bufnr, get) abort
	if a:get.fromTab
		return termcwd#tabs#toggle(a:t_bufnr, a:get)
	elseif a:get.prev == a:t_bufnr
		" Prev equal current, so toggle close.
		" close all others
		call termcwd#hide#allOtherBufwinnrInTab()
		" handle closing current terminal window
		try
			if a:get.split
				hide
			endif
		catch | try | exe "b#" | catch | call s:NotifyNoAlt() | endt
		finally | return v:false
		endtry
	else
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
