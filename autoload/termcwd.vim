" Author: jssteinberg
" License: MIT
" Version: 0.1.5
" Repository: //github.com/jssteinberg/termcwd.vim

" open terminal
function! termcwd#get(...) abort
	let s:set = #{ prev: bufnr(), split: 0, fromTab: 0 }
	call termcwd#insert#determineStart(s:GetTerm(a:000))
endfunction

" open terminal in split
function! termcwd#splitGet(...) abort
	let s:set = #{ prev: bufnr(), split: 1, fromTab: 0 }

	" Check toggle first, regardless of height setting
	if !get(g:, "termcwd_minimal", v:false) && termcwd#toggle#split(a:000)
		return
	else
		let l:one_off_minimal = v:true
	endif

	wincmd s

	if get(g:, "termcwd_split_full_top", v:false)
		wincmd K
	elseif get(g:, "termcwd_split_full_bottom", v:false)
		wincmd J
	endif

	let l:focused = s:GetTerm(a:000, l:one_off_minimal)

	if get(g:, "termcwd_height", 0) && !get(g:, "termcwd_minimal", v:false) && l:focused
		setlocal winfixheight
		exe "resize " . g:termcwd_height
	endif

	call termcwd#insert#determineStart(l:focused)
endfunction

" open terminal in tab
function! termcwd#tabGet(...) abort
	let s:set = #{ prev: bufnr(), split: 0, fromTab: tabpagenr() }

	try | tabedit % | catch | endtry
	call termcwd#insert#determineStart(s:GetTerm(a:000))
endfunction

" aliases
let termcwd#spGet = function("termcwd#splitGet")

" get terminal
" returns true if terminal is open and focused
function! s:GetTerm(args, minimal = get(g:, "termcwd_minimal", v:false)) abort
	let l:term = get(a:args, 0, "main")
	let l:cwd = get(a:args, 1, getcwd(0))
	let l:key = termcwd#get#key(l:term, l:cwd)

	try
		" try if terminal exists
		exe "buffer " . g:termcwd_bufnrs[l:key]

		return !a:minimal
					\ ? termcwd#exists#toggleTermcwd(g:termcwd_bufnrs[l:key], s:set)
					\ : v:true
	catch
		" Create terminal
		if !has("nvim")
			" For Vim, creating terminal in current window must be specified
			terminal ++curwin
		else
			terminal

			if get(g:, "termcwd_start_insert", v:true)
				startinsert
			endif
		endif

		if exists("*TermcwdCallback")
			call TermcwdCallback()
		endif

		" Create termcwd store if not exists
		let g:termcwd_bufnrs = get(g:, "termcwd_bufnrs", {})
		" Store link terminal key to buffer number
		let g:termcwd_bufnrs[l:key] = bufnr()

		return v:true
	endtry
endfunction
