function! termcwd#get(...) abort
	let s:prev_bufnr = bufnr()
	let s:split = 0
	call s:GetTerm(a:000)
endfunction
" open in splits
function! termcwd#splitGet(...) abort
	let s:prev_bufnr = bufnr()
	let s:split = 1
	wincmd s | call s:GetTerm(a:000)
endfunction
function! termcwd#spGet(...) abort
	let s:prev_bufnr = bufnr()
	let s:split = 1
	wincmd s | call s:GetTerm(a:000)
endfunction
function! termcwd#vsplitGet(...) abort
	let s:prev_bufnr = bufnr()
	let s:split = 1
	wincmd v | call s:GetTerm(a:000)
endfunction
function! termcwd#vspGet(...) abort
	let s:prev_bufnr = bufnr()
	let s:split = 1
	wincmd v | call s:GetTerm(a:000)
endfunction

function! s:GetTerm(args) abort
	let l:term = get(a:args, 0, "main")
	let l:cwd = get(a:args, 1, getcwd(0))
	let l:key = string(l:term) . "_" . l:cwd
	let l:existed = v:false

	try
		" try if terminal exists
		exe "buffer " . g:termcwd_bufnrs[l:key]
		let l:existed = v:true
		" start insert if configured
		if get(g:, "termcwd_insert", v:false) | startinsert | en
	catch
		" or create terminal
		if has("nvim")
			terminal
		else
			terminal ++curwin
		endif

		" For consistency between Vim and Neovim `startinsert` is default
		if get(g:, "termcwd_start_insert", v:true) | startinsert | en
		" Create termcwd store if not exists
		let g:termcwd_bufnrs = get(g:, "termcwd_bufnrs", {})
		" Store link terminal key to buffer number
		let g:termcwd_bufnrs[l:key] = bufnr()
	endtry

	if l:existed && !get(g:, "termcwd_minimalistic", v:false)
		call termcwd#smart#window(s:prev_bufnr, s:split)
	endif

	" reset prev_bufnr
	let s:prev_bufnr = 0
endfunction
