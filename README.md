# termcwd

Termcwd is a tiny package/plugin for Neovim and Vim providing a simple wrapper for the native terminal to quickly toggle/focus your (Neo)vim terminals.

Install Termcwd and define your preferred mappings (see below for Lua).

```vim
nnoremap <silent> <leader><cr> <cmd>call termcwd#splitGet()<cr>
```

Now your leader key + Enter toggles/focuses your main terminal for the window-local current working directory (CWD).

When you open another CWD within (Neo)vim – for instance when opening another session – the same mapping will now toggle/focus the main terminal for **that** CWD. Then you return to your previous CWD and the same mapping will now toggle/focus that CWD's main terminal.

You can also add mappings for any secondary terminals and make it global for the (Neo)vim instance by passing these arguments (the first argument is the terminal name, second is the CWD which defaults to window-local CWD. Here it's empty for a global terminal, though terminal path equals window CWD where first opened):

```vim
nnoremap <silent> <leader>1 <cmd>call termcwd#splitGet("global", "")<cr>
```

*You can also turn off the toggling and auto close feature for full manual control by setting the `termcwd_minimal` to `false`, see Configure below.*

## All functions

- `termcwd#get()` toggles/focuses the main terminal for the window-local CWD.
- `termcwd#splitGet()` (or vimscript alias `termcwd#spGet()`) toggles/focuses the terminal in a split.
- `termcwd#tabGet()` toggles the terminal in a new tab.

*All functions spawns a new terminal if it is doesn't exist for the particular reference.*

Optionally they take two arguments:

1. (number | string) – the terminal to open (`"main"` by default).
2. (string) – the CWD termcwd will open the terminal from (window-local CWD by default – `getcwd(0)`). Use an empty string to be able to open it from any CWD, or configure with `getcwd()`.

*The actual folder path the terminal starts in is (Neo)vim default window-local CWD. Which is usually what you want.*

> [!NOTE]
> Terminal names are connected to their CWDs. Meaning you can use the same terminal name for both your window-local CWD and your global terminal without them interfering.

### Configure

For consistency between Neovim and Vim – and what's generally a nice workflow – when a new terminal is spawned, insert mode is started (like the default of Vim). Then, normal mode when that terminal is opened the next time (like the default of both Neovim and Vim).

To always move a split window to full width and top or bottom:

```vim
" termcwd is split to top and full width
let g:termcwd_split_full_top = v:true
" termcwd is split to bottom and full width
let g:termcwd_split_full_bottom = v:true
```

To only keep a single window per termcwd name and/or working directory:

```vim
let g:termcwd_single = v:true
```

To turn off closing of other windows with same terminal and toggling of terminal window:

```vim
let g:termcwd_minimal = v:true
```

### Neovim only config

To always start termcwd's returned terminal in insert mode (only for Neovim since Vim does not support starting insert mode by command in terminal buffer):

```vim
let g:termcwd_insert = v:true
```

To never start it in insert mode (only for Neovim since Vim's terminal is only redrawn when in terminal/insert mode):

```vim
let g:termcwd_start_insert = v:false
```

*How to configure above options with lua:*

```lua
vim.g.termcwd_split_full_top = true
vim.g.termcwd_split_full_bottom = true
vim.g.termcwd_single = true
vim.g.termcwd_minimal = true
vim.g.termcwd_insert = true
vim.g.termcwd_start_insert = false
```

<details>
<summary>Related convenient keymaps</summary>

Keymap to leave insert mode in terminal – below `jk` gets you to normal mode:

```vim
" For Neovim
tnoremap jk <c-\><c-n>
" For Vim
tnoremap jk <c-w>N
```

`<leader>c` hides current window or quit if last window:

```vim
nnoremap <silent> <leader>c :exe "try\n hide\n catch\n q\n endtry"<cr>
```

`<leader>C` closes tab or quits all if last tab:

```vim
nn <silent> <leader>C <cmd>exe "try\n tabclose\n catch\n qa\n endtry"<cr>
```

</details>

## Install

Install "jssteinberg/termcwd" with any (Neo)vim package/plugin manager, or clone/download it to a "pack/\*/start" `runtimepath` folder (`:h packages`).

Termcwd is already lazy loaded (defined only when used) so you don't have to do any config for lazy loading. By simply using (Neo)vim's "autoload" directory (`:h autoload-functions`) there's no additional startuptime for your (n)vim instance. Ironically it's too light for lazy loading to matter,
but all (Neo)vim packages/plugins should just do it when possible.

*Lazy.nvim example:*

```lua
{
	"jssteinberg/termcwd",
	config = function()
		-- Example key mappings
		vim.keymap.set("n", "<leader><cr>", function()
			vim.fn["termcwd#splitGet"]()
		end, { desc = "Terminal (CWD)" })
		vim.keymap.set("n", "<leader>t<cr>", function()
			vim.fn["termcwd#tabGet"]()
		end, { desc = "Terminal tab (CWD)" })
		vim.keymap.set("n", "<leader>1", function()
			vim.fn["termcwd#splitGet"]("global", "")
		end, { desc = "Terminal" })
	end
}
```

*With Lua you call vim functions with: `vim.fn` or `vim.call`. Vim function aliases are not available. ([More about Neovim Lua](//vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua)).*

## TODO

- [v] split with option for full width
- [v] reuse tab for `termcwd#tagGet()`
- hide terminal buffers from ls list option (so doesnt pollute alt file)?
- rename to "shwd"?
