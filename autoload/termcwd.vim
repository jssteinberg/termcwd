" Author: jssteinberg
" License: MIT
" Version: 0.1.0
" Repository: //github.com/jssteinberg/termcwd.vim

" open terminal
function! termcwd#get(...) abort
	let s:set = #{ prev: bufnr(), split: 0, tab: 0 }
	call s:GetTerm(a:000)
endfunction
" open terminal in split
function! termcwd#splitGet(...) abort
	let s:set = #{ prev: bufnr(), split: 1, tab: 0 }
	wincmd s | call s:GetTerm(a:000)
endfunction
" open terminal in vsplit
function! termcwd#vsplitGet(...) abort
	let s:set = #{ prev: bufnr(), split: 1, tab: 0 }
	wincmd v | call s:GetTerm(a:000)
endfunction
" open terminal in tab
function! termcwd#tabGet(...) abort
	let s:set = #{ prev: bufnr(), split: 0, tab: tabpagenr() }
	tabnew | call s:GetTerm(a:000)
endfunction
" alias some functions
let termcwd#spGet = function("termcwd#splitGet")
let termcwd#vsGet = function("termcwd#vsplitGet")

function! s:GetTerm(args) abort
	let l:term = get(a:args, 0, "main")
	let l:cwd = get(a:args, 1, getcwd(0))
	let l:key = string(l:term) . "_" . l:cwd
	let l:existed = v:false

	try
		" try if terminal exists
		exe "buffer " . g:termcwd_bufnrs[l:key]
		let l:existed = v:true
	catch
		" or create terminal
		if has("nvim")
			terminal
		else
			terminal ++curwin
		endif
		" For consistency between Vim and Neovim `startinsert` is default
		if get(g:, "termcwd_start_insert", v:true)
			startinsert
		en
		" Create termcwd store if not exists
		let g:termcwd_bufnrs = get(g:, "termcwd_bufnrs", {})
		" Store link terminal key to buffer number
		let g:termcwd_bufnrs[l:key] = bufnr()
	endtry

	if l:existed && !get(g:, "termcwd_minimalistic", v:false)
		call termcwd#exists#doSmartHide(s:set)
	elseif l:existed
		" start insert if configured
		if get(g:, "termcwd_insert", v:false)
			startinsert
		en
	endif
endfunction
