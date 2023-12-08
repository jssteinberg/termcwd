# termcwd

Termcwd is a tiny package/plugin for Neovim and Vim to quickly toggle open your (Neo)vim terminals.

Install Termcwd and define your preferred mappings (in vimscript).

```vim
nnoremap <silent> <leader><cr> <cmd>call termcwd#splitGet()<cr>
```

*With lua you can call the function like this: `vim.fn["termcwd#splitGet"]()`.*

Now your leader key + Enter spawns/toggles your main terminal for the window-local current working directory (CWD).

When you open another CWD within (Neo)vim – for instance when opening another session – the same mapping will now spawn/toggle the main terminal for **that** CWD. Then you return to your previous CWD and the same mapping will now toggle that CWD's main terminal.

You can also add mappings for any secondary terminals and make it global for the (Neo)vim instance by passing these arguments (the first argument is the terminal name, second is the CWD which defaults to window-local CWD. Here it's empty for a global terminal):

```vim
nnoremap <silent> <leader>1 <cmd>call termcwd#splitGet('global', '')<cr>
```

## All functions

`termcwd#get()` spawns/toggles the main terminal for the window-local CWD.

`termcwd#splitGet()` or `termcwd#spGet()` spanws/toggles the terminal in a split.

`termcwd#vsplitGet()` or `termcwd#vspGet()` spanws/toggles the terminal in a vertical split.

*They all create the terminal if it is doesn't exist for the particular reference.*

Optionally they take two arguments:

1. (number | string) – the terminal to open (`"main"` by default).
2. (string) – the CWD termcwd will open the terminal from (window-local CWD by default – `getcwd(0)`). Use an empty string to be able to open it from any CWD, or configure with `getcwd()`.

*The actual folder path the terminal starts in is (Neo)vim default window-local CWD. Which is usually what you want.*

*Note: Terminal names are connected to CWDs. Meaning you can use the same terminal name for both your window-local CWD and your global terminal without them interfering.*

### Configure Insert Mode

For consistency between Neovim and Vim – and what's generally a nice workflow – when a new terminal is spawned insert mode is started (like the default of Vim), then normal mode when that terminal is opened the next time (like the default of both Neovim and Vim).

To always start termcwd's returned terminal in insert mode:

```vim
let g:termcwd_insert = v:true
```

To never start it in insert mode (only for Neovim):

```vim
let g:termcwd_start_insert = v:false
```

To turn off closing of windows with same terminal and toggling of terminal window:

```vim
let g:termcwd_minimalistic = v:true
```

*How to configure above options with lua:*

```lua
vim.g.termcwd_insert = true
vim.g.termcwd_start_insert = false
vim.g.termcwd_minimalistic = true
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
