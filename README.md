# termcwd

Termcwd toggles (Neo)vim terminal buffers based on the window local current working directory (CWD). A simple package/plugin script for Neovim and Vim.

## Install

This script is lazy loaded by default. Install it with any Neovim/Vim package/plugin manager, or clone/download it to a "pack/\*/start" folder in `runtimepath` (`:h packages`).

## Use

Call the function `termcwd#get()` to toggle a terminal for the window local CWD,  opened in a split window. E.g., map it like so:

```vim
nnoremap <silent> <leader><cr> <cmd>call termcwd#get()<cr>
```

There's also two arguments that can be passed:

1. the number of the terminal to toggle (0 by default)
2. the CWD path it can be toggled from (window local CWD by default) - pass en empty string to be able to toggle it from any CWD.

E.g., for a terminal numbered 1 that can be toggled globally in a (Neo)vim instance:

```vim
nnoremap <silent> <leader>1 <cmd>call termcwd#get(1, "")<cr>
```

(The actual folder path the term starts in is the default `:terminal` window local CWD.)

## Insert

For consistency between Neovim and Vim—and what's generally a nice workflow—the first time a terminal is opened it starts in insert mode (like the default of Vim), then normal mode when toggled open the next time (like the default of Vim).

To always open terminal and start insert:

```vim
let g:termcwd_insert = v:true
```

To not start in insert mode (only for Neovim):

```vim
let g:termcwd_start_insert = v:false
```
