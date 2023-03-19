# termcwd

Termcwd is a tiny package/plugin for Neovim and Vim.
Use it to open your terminal buffer based on the current working directory (CWD)—window local, tab local, or globally.
A new terminal will be spawned for the particular reference if it hasn't already.

Workflow with termcwd:

- quickly open your main terminal (or secondary, or other) based on the CWD;
- take a glance at your terminal, maybe write a command and
- hide the terminal buffer (e.g., by `<c-w>q` when you have `set hidden`)—knowing you have you terminal buffer quickly available without any thought.

If you switch CWD, e.g, by opening another session, or for a tab, or in your directory viewer, you can use the same keymapping to open another main terminal for that CWD (or use your preference of choice—see below).

## Install

Install it with any Neovim/Vim package/plugin manager, or clone/download it to a "pack/\*/start" folder in `runtimepath` (`:h packages`).

Termcwd is too light for lazy loading to matter,
but still it's lazy loaded by default—as all (Neo)vim packages/plugins should aim for.

## Use

Call the function `termcwd#get()` to
open a terminal for the
window-local CWD in a
split window. E.g., map it like
so:

```vim
nnoremap <silent> <leader><cr> <cmd>call termcwd#get()<cr>
```

There's also two arguments that can be passed:

1. `number`, a number—number of the terminal to toggle (`0` by default).
2. `cwd`, a string—directory path
the terminal is scoped to (window-local
CWD by default—`getcwd(0)`).
Use an empty string to be able to toggle it from any CWD, or specify with `getcwd()` or other way.

*The actual folder path the
terminal starts in is (Neo)vim
default window-local CWD. Which
is usually what you want.*

E.g., for an alternative terminal (numbered 1) that can be toggled for the window-local CWD:

```vim
nnoremap <silent> <leader>1 <cmd>call termcwd#get(1)<cr>
```

Or for a terminal numbered 1 that can be toggled globally in a (Neo)vim instance:

```vim
nnoremap <silent> <leader>1 <cmd>call termcwd#get(1, "")<cr>
```

## Configure Insert Mode

For consistency between Neovim and
Vim—and what's generally a nice
workflow—when a new terminal is
spawned insert mode is
started (like the default of Vim),
then normal mode when that terminal
is opened the next time
(like the default of both Neovim
and Vim).

To always start in insert mode:

```vim
let g:termcwd_insert = v:true
```

To never start in insert mode (only for Neovim):

```vim
let g:termcwd_start_insert = v:false
```
