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
		"return s:get_split_term(l:key)
	endif
endfunction

function! s:current_is_term(key) abort
	try
		return bufnr() == g:termcwd_bufnrs[a:key]
	catch
		return v:false
	endtry
endfunction

function! s:get_split_term(key) abort
	wincmd s

	if get(g:, "termcwd_split_full_top", v:false)
		wincmd K
	elseif get(g:, "termcwd_split_full_bottom", v:false)
		wincmd J
	endif

	if get(g:, "termcwd_height", 0)
		exe "resize " . g:termcwd_height
	endif

	try
		" try if terminal exists
		exe "buffer " . g:termcwd_bufnrs[a:key]

	catch
		" Create terminal
		if !has("nvim")
			terminal ++curwin
		else
			terminal
			if get(g:, "termcwd_start_insert", v:true)
				startinsert
			endif
		endif

		" Create termcwd store if not exists
		let g:termcwd_bufnrs = get(g:, "termcwd_bufnrs", {})
		" Store link terminal key to buffer number
		let g:termcwd_bufnrs[a:key] = bufnr()
	endtry

	if has("nvim") && get(g:, "termcwd_insert", v:false)
		startinsert
	endif

	return v:true
endfunction
