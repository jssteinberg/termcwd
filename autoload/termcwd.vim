" Author: jssteinberg
" License: MIT
" Version: 0.1.0
" Repository: //github.com/jssteinberg/termcwd.vim

" open terminal
function! termcwd#get(...) abort
	let s:set = #{ prev: bufnr(), split: 0, fromTab: 0 }
	call s:GetTerm(a:000)
endfunction
" open terminal in split
function! termcwd#splitGet(...) abort
	let s:set = #{ prev: bufnr(), split: 1, fromTab: 0 }
	wincmd s
	if get(g:, "termcwd_split_full_top", v:false) | wincmd K | en
	if get(g:, "termcwd_split_full_bottom", v:false) | wincmd J | en
	call s:GetTerm(a:000)
endfunction
" open terminal in tab
function! termcwd#tabGet(...) abort
	let s:set = #{ prev: bufnr(), split: 0, fromTab: tabpagenr() }
	try | tabedit % | catch | endtry
	call s:GetTerm(a:000)
endfunction
" aliases
let termcwd#spGet = function("termcwd#splitGet")

function! s:GetTerm(args) abort
	let l:term = get(a:args, 0, "main")
	let l:cwd = get(a:args, 1, getcwd(0))
	let l:key = string(l:term) . "_" . l:cwd
	let l:existed = v:false
	let l:existed_terminal_focused = get(g:, "termcwd_minimal", v:false)

	try
		" try if terminal exists
		exe "buffer " . g:termcwd_bufnrs[l:key]
		let l:existed = v:true
	catch
		" or create terminal
		if !has("nvim") | terminal ++curwin
		else
			terminal

			if get(g:, "termcwd_start_insert", v:true)
				startinsert
			endif
		endif

		" Create termcwd store if not exists
		let g:termcwd_bufnrs = get(g:, "termcwd_bufnrs", {})
		" Store link terminal key to buffer number
		let g:termcwd_bufnrs[l:key] = bufnr()
	endtry

	if l:existed && !get(g:, "termcwd_minimal", v:false)
		let l:existed_terminal_focused = termcwd#exists#toggleTermcwd(g:termcwd_bufnrs[l:key], s:set)
	endif

	if l:existed_terminal_focused && has("nvim") && get(g:, "termcwd_insert", v:false)
		startinsert
	endif
endfunction
