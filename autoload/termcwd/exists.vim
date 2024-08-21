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

	" Terminal should be open

	if get(g:, "termcwd_split_full_bottom", v:false)
		" Keep terminal open, focus and keep only last window occurrence
		let g:termcwd_new_split = termcwd#use#lastWindowOccurence(a:t_bufnr) ? v:false : v:true
	else
		" Keep terminal open, focus and keep only first window occurrence
		let g:termcwd_new_split = termcwd#use#firstWindowOccurence(a:t_bufnr) ? v:false : v:true
	endif

	if get(g:, "termcwd_single", v:false)
		" Close all other windows with same bufnr in current tab
		call termcwd#hide#allOtherBufwinnrInTab()
	endif

	return v:true
endfunction
