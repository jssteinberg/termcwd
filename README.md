# termcwd

Termcwd is a tiny package/plugin for
Neovim and Vim. Use it to quickly
create/open the terminals for the current
working
directory (CWD)—window local, tab
local, or globally. A new terminal
will be spawned if it doesn't exist
for the particular reference.

Workflow with termcwd:

1. you're coding on a project
2. you need to run a command or glance at your terminal
3. use termcwd to quickly open your main terminal (or secondary, or other) for the active CWD in a split window
  - if there's no active terminal for that reference it will be spawned
  - else, it's opened
4. take a glance at your terminal, maybe run some commands
5. hide the terminal buffer (e.g., with `<C-w>q`)
6. repeat

If you switch CWD, e.g, by opening another session, or for a tab, or in your directory viewer, you can use the same keymapping to open another main terminal for that CWD (or use your preference of choice—see below).

## Install

Install it with any Neovim/Vim package/plugin manager, or clone/download it to a "pack/\*/start" folder in `runtimepath` (`:h packages`).

Termcwd is lazy loaded (defined only when used). It's too light for lazy loading to matter,
but all (Neo)vim packages/plugins should just do this.

## Use

Call the function `termcwd#get()` to
open a terminal for the
window-local CWD. E.g., map it like
so:

```vim
nnoremap <silent> <leader><cr> <cmd>wincmd s<cr><cmd>call termcwd#get()<cr>
```

There's also two arguments that can be passed:

1. (number | string)—the terminal to open (`"main"` by default).
2. (string)—directory patopen terminal is scoped to (window-local
CWD by default—`getcwd(0)`).
Use an empty string to be able to toggle it from any CWD, or specify with `getcwd()` or other way.

*The actual folder path the
terminal starts in is (Neo)vim
default window-local CWD. Which
is usually what you want.*

E.g., for an alternative terminal (numbered 1) that can be toggled for the window-local CWD:

```vim
nnoremap <silent> <leader>1 <cmd>wincmd s<cr><cmd>call termcwd#get(1)<cr>
```

Or for a terminal that can be toggled globally in a (Neo)vim instance:

```vim
nnoremap <silent> <leader>1 <cmd>wincmd s<cr><cmd>call termcwd#get(0, "")<cr>
```

*Note: You can use `0` for both your window-local CWD main terminal and your instance global terminal without them interfering.*

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

To always start termcwd's returned terminal in insert mode:

```vim
let g:termcwd_insert = v:true
```

To never start it in insert mode (only for Neovim):

```vim
let g:termcwd_start_insert = v:false
```
