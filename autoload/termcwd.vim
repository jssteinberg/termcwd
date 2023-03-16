function! termcwd#get(number = 0, cwd = getcwd(0)) abort
	try
		wincmd s
		exe "buffer " . g:termcwd_bufnrs[a:cwd .. string(a:number)]
		if get(g:, "termcwd_insert", v:false) | startinsert | en
	catch
		if has("nvim")
			terminal
		else
			terminal ++curwin
		endif

		" For consistency between Vim and Neovim `startinsert` is default
		if get(g:, "termcwd_start_insert", v:true) | startinsert | en
		" Store buffer number with cwd and term number as key
		if !exists("g:termcwd_bufnrs") | let g:termcwd_bufnrs = {} | en
		let g:termcwd_bufnrs[a:cwd .. string(a:number)] = bufnr()
	endtry
endfunction
