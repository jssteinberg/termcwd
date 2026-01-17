# termcwd

*A tiny package/plugin for Neovim's and Vim's terminal to quickly toggle/focus the terminal for the current working directory (CWD), plus some customization.*

Do you sometimes browse your buffers for the (right) terminal? Termcwd provides functions to toggle/focus your current terminal relative to the working directory:

- Open in current window, split, or tab (and you can map them to different keymaps).
	- Set static height of termcwd split window.
- Start in insert mode (Neovim only).
- Toggle or not – terminal toggling and auto closing of windows with equal terminal buffer (can be turned off).

It's only a thin layer of functions that keeps terminals as regular terminal buffers by using the default terminal command.

## Window-local CWD terminal

Define your preferred mappings:

```lua
-- Lua
vim.keymap.set("n", "<leader><cr>", require("termcwd").split(), { desc = "Terminal (CWD)" })
```

```vim
" Vimscript
nnoremap <silent> <leader><cr> <cmd>call termcwd#splitGet()<cr>
```

Now your leader key + Enter toggles/focuses your main terminal for the window-local CWD.
When you open another CWD within (Neo)vim – for instance when opening another session – the same mapping will now toggle/focus the main terminal for **that** CWD. Then you return to your previous CWD and the same mapping will now toggle/focus that CWD's main terminal.

You can also add mappings for any secondary terminals and make it global for the (Neo)vim instance by passing these arguments (the first argument is the terminal name, second is the CWD which defaults to window-local CWD. Here it's empty for a global terminal, though terminal path equals window CWD where first opened):

```vim
nnoremap <silent> <leader>1 <cmd>call termcwd#splitGet("global", "")<cr>
```

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
		vim.keymap.set("n", "<leader><cr>", require("termcwd").split(), { desc = "Terminal (CWD)" })
		vim.keymap.set("n", "<leader>t<cr>", require("termcwd").tab(), { desc = "Terminal tab (CWD)" })
		vim.keymap.set("n", "<leader>1", require("termcwd").split(1, ""), { desc = "Terminal" })
	end
}
```

## Functions

Vimscript (see equal Lua functions below):

- `termcwd#get()` toggles/focuses the main terminal for the window-local CWD.
- `termcwd#splitGet()` (or alias `termcwd#spGet()`) toggles/focuses the terminal in a split.
- `termcwd#tabGet()` toggles/focuses the terminal in a tab.

*With Lua you can call vimscript functions with: `vim.fn` or `vim.call` – vimscript function aliases are not available ([more about Lua usage](//vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua)) – but termcwd provides Lua wrapper functions.*

Lua:

- `require("termcwd").get()` toggles/focuses the main terminal for the window-local CWD.
- `require("termcwd").split()` (or Lua alias `require("termcwd").sp()`) toggles/focuses the terminal in a split.
- `require("termcwd").tab()` toggles/focuses the terminal in a tab.

All functions:

- Spawns a new terminal if it is doesn't exist for the particular reference.
- Optionally they take two arguments:
	1. (number | string) – the terminal to open (`"main"` by default).
	2. (string) – the CWD termcwd will open the terminal from (window-local CWD by default – `getcwd(0)`). Use an empty string to be able to open it from any CWD, or configure with `getcwd()`.

*The actual folder path the terminal starts in is (Neo)vim default window-local CWD. Which is usually what you want.*

> [!NOTE]
> Terminal names are connected to their CWDs. Meaning you can use the same terminal name for both your window-local CWD and your global terminal without them interfering.

## Configuration

*These options can also be configured in Neovim with [Lua's syntax, see below](#lua-example).*

**Callback function when creating a new termcwd terminal to set options:**

```vim
function! TermcwdCallback() abort
	setlocal nonumber
endfunction
```

**Always move a split termcwd window to full width top/bottom:**

```vim
" termcwd is split to top and full width
let g:termcwd_split_full_top = v:true
" termcwd is split to bottom and full width
let g:termcwd_split_full_bottom = v:true
```

**Set static height for split termcwd windows** (does not work with `g:termcwd_minimal` – see below):

```vim
let g:termcwd_height = 20
```

**Turn off toggling and auto closing** of other windows with equal terminal buffer:

```vim
let g:termcwd_minimal = v:true
```

<details>
<summary>Less relevant config</summary>

**Ensure single window of each termcwd in tab:**

```vim
let g:termcwd_single = v:true
```

</details>

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

### Neovim only config

For consistency between Neovim and Vim – and what's generally a nice workflow – when a new terminal is spawned, insert mode is started (like the default of Vim). Then, normal mode after the first time that terminal is opened.

**Always start in insert mode** – for termcwd's returned terminal (only for Neovim since Vim does not support starting insert mode by command in terminal buffer):

```vim
let g:termcwd_insert = v:true
```

**Never start in insert mode** (only for Neovim since Vim's terminal is only redrawn when in terminal/insert mode):

```vim
let g:termcwd_start_insert = v:false
```

### Lua example

```lua
vim.g.termcwd_split_full_top = true
vim.g.termcwd_split_full_bottom = true
vim.g.termcwd_single = true
vim.g.termcwd_minimal = true
vim.g.termcwd_insert = true
vim.g.termcwd_start_insert = false
```

## TODO

- update fixed height on window resize
- option to use terminal toggle keymap to exit terminal insert mode as well
- option to hide terminal buffers from ls list option (so doesnt pollute alt file)?
