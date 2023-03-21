function! termcwd#get(term = "main", cwd = getcwd(0)) abort
	let l:key = string(a:term) . "_" . a:cwd

	try
		exe "buffer " . g:termcwd_bufnrs[l:key]
		if get(g:, "termcwd_insert", v:false) | startinsert | en
	catch
		if has("nvim")
			terminal
		else
			terminal ++curwin
		endif

		" For consistency between Vim and Neovim `startinsert` is default
		if get(g:, "termcwd_start_insert", v:true) | startinsert | en

		" Store buffer term with cwd and term term as key
		if !exists("g:termcwd_bufnrs") | let g:termcwd_bufnrs = {} | en
		let g:termcwd_bufnrs[l:key] = bufnr()
	endtry
endfunction

" open in splits
function! termcwd#splitGet(...) abort
	wincmd s | call s:GetTerm(a:000)
endfunction
function! termcwd#spGet(...) abort
	wincmd s | call s:GetTerm(a:000)
endfunction
function! termcwd#vsplitGet(...) abort
	wincmd v | call s:GetTerm(a:000)
endfunction
function! termcwd#vspGet(...) abort
	wincmd v | call s:GetTerm(a:000)
endfunction

function! s:GetTerm(args) abort
	let l:term = get(a:args, 0, "main")
	let l:cwd = get(a:args, 1, getcwd(0))
	call termcwd#get(l:term, l:cwd)
endfunction
