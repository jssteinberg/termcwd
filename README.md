# termcwd

Termcwd is a tiny package/plugin for Neovim and Vim.
Use it to open your terminal buffer based on the current working directory (CWD)—window local, tab local, or globally.
A new terminal will be spawned for the particular reference if it hasn't already.

Termcwd is for the workflow of quickly opening your main terminal (or secondary, or other) based on the CWD; take a glance, write a command and hide the buffer (e.g., by `<c-w>q` when you have `set hidden`)—knowing you have you terminal buffer quickly available without any thought. If you switch CWD, e.g, by opening another session, or for a tab, or in your directory viewer, you can you the same keymapping to open another main terminal for that CWD.

## Install

Install it with any Neovim/Vim package/plugin manager, or clone/download it to a "pack/\*/start" folder in `runtimepath` (`:h packages`).

Termcwd is too light for lazy loading to matter,
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
