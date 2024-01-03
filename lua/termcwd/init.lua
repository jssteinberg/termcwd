local M = {}

M.get = function(terminal, dir)
	return function()
		-- terminal fallbaks to "main"
		local name = terminal or "main"
		local wd = dir or vim.fn.getcwd()

		vim.fn["termcwd#get"](name, wd)
	end
end

M.tab = function(terminal, dir)
	return function()
		-- terminal fallbaks to "main"
		local name = terminal or "main"
		local wd = dir or vim.fn.getcwd()

		vim.fn["termcwd#tabGet"](name, wd)
	end
end

M.split = function(terminal, dir)
	return function()
		-- terminal fallbaks to "main"
		local name = terminal or "main"
		local wd = dir or vim.fn.getcwd()

		vim.fn["termcwd#splitGet"](name, wd)
	end
end

-- alias M.sp to M.split
M.sp = M.split

return M
