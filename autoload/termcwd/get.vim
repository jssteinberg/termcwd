" get split terminal
function! termcwd#get#split(args) abort
	let l:term = get(a:args, 0, "main")
	let l:cwd = get(a:args, 1, getcwd(0))
	let l:key = type(l:term) != v:t_string ? string(l:term) : l:term . "_" . l:cwd

	" - check if current buffer is term to open, then close win or open prev
	"   buffer
	if (s:current_is_term(l:key))
		" then close or get alt
		try
			hide
		catch
			termcwd#hide#buffer()
		finally
			return v:true
		endtry
	else
		try
			let l:term_winid = bufwinid(g:termcwd_bufnrs[l:key])
			" - check if is open in another window, go to it
			if l:term_winid
				return win_gotoid(l:term_winid)
			endif
		catch | endtry

		" - create win of dimensions, tryopen buffer
		" - create win of dimensions, open buffer
		return v:false
	endif
endfunction

function! s:current_is_term(key) abort
	try
		return bufnr() == g:termcwd_bufnrs[a:key]
	catch
		return v:false
	endtry
endfunction
