" returns true if terminal is open and focused
function! termcwd#exists#toggleTermcwd(t_bufnr, get) abort
	if a:get.fromTab
		return termcwd#tabs#toggle(a:t_bufnr, a:get)
	elseif a:get.prev == a:t_bufnr
		" Prev bufnr == current bufnr, so hide this termcwd
		return !termcwd#hide#inCurrentTab(a:get.split)
	else
		call termcwd#use#firstWindowOccurence(a:t_bufnr)
	endif

	return v:true
endfunction
