" Handles toggling of existing terminal
" @returns boolean – `true` if terminal is open and focused
function! termcwd#exists#toggleTermcwd(t_bufnr, get) abort
	if a:get.fromTab
		" From tab is the previous tab, call terminal tab toggle
		return termcwd#tabs#toggle(a:t_bufnr, a:get)
	elseif a:get.prev == a:t_bufnr
		" Previous bufnr equals terminal bufnr to get, then hide terminal win
		return !termcwd#hide#inCurrentTab(a:get.split)
	endif

	" Terminal should be kept open

	if get(g:, "termcwd_split_full_bottom", v:false)
		" Keep terminal open, focus and keep only last window occurrence
		call termcwd#use#lastWindowOccurence(a:t_bufnr)
	else
		" Keep terminal open, focus and keep only first window occurrence
		call termcwd#use#firstWindowOccurence(a:t_bufnr)
	endif

	if get(g:, "termcwd_single", v:false)
		" Close all other windows with same bufnr in current tab
		call termcwd#hide#allOtherBufwinnrInTab()
	endif

	return v:true
endfunction
