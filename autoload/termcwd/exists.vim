" returns true if terminal is open and focused
function! termcwd#exists#toggleTermcwd(t_bufnr, get) abort
	if a:get.fromTab
		" Toggle tab
		return termcwd#tabs#toggle(a:t_bufnr, a:get)
	elseif a:get.prev == a:t_bufnr
		" Toggle window close
		" Prev bufnr == current bufnr, so hide this termcwd
		return !termcwd#hide#inCurrentTab(a:get.split)
	endif

	" Keep terminal open
	if get(g:, "termcwd_split_full_bottom", v:false)
		" Keep terminal open, focus and keep only last window occurrence
		call termcwd#use#lastWindowOccurence(a:t_bufnr)
	else
		" Keep terminal open, focus and keep only first window occurrence
		call termcwd#use#firstWindowOccurence(a:t_bufnr)
	endif

	return v:true
endfunction
