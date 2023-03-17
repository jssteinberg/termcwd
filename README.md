# termcwd

Termcwd toggles (Neo)vim terminal buffers based on the window-local current working directory (CWD). A simple package/plugin script for Neovim and Vim.

## Install

Install it with any Neovim/Vim package/plugin manager, or clone/download it to a "pack/\*/start" folder in `runtimepath` (`:h packages`).

Termcwd is too light for lazy loading to matters,
but still it's lazy loaded by default—as all (Neo)vim packages/plugins should aim for.

## Use

Call the function `termcwd#get()` to toggle a terminal for the window-local CWD,  opened in a split window. E.g., map it like so:

```vim
nnoremap <silent> <leader><cr> <cmd>call termcwd#get()<cr>
```

There's also two arguments that can be passed:

1. Number—The number of the terminal to toggle (0 by default).
2. String—The CWD path it can be toggled from (window-local CWD by default—`getcwd(0)`) - pass en empty string to be able to toggle it from any CWD, or specify with `getcwd()` or other way.

E.g., for an alternative terminal (numbered 1) that can be toggled for the window-local CWD:

```vim
nnoremap <silent> <leader>1 <cmd>call termcwd#get(1)<cr>
```

Or for a terminal numbered 1 that can be toggled globally in a (Neo)vim instance:

```vim
nnoremap <silent> <leader>1 <cmd>call termcwd#get(1, "")<cr>
```

(The actual folder path the term starts in is the default `:terminal` window-local CWD.)

## Insert Mode

For consistency between Neovim and Vim—and what's generally a nice workflow—the first time a terminal is opened it starts in insert mode (like the default of Vim), then normal mode when toggled open the next time (like the default of Vim).

To always open terminal and start insert:

```vim
let g:termcwd_insert = v:true
```

To not start in insert mode (only for Neovim):

```vim
let g:termcwd_start_insert = v:false
```
