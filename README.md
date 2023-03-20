# termcwd

Termcwd is a tiny package/plugin for Neovim and Vim to
quickly toggle open your (Neo)vim terminals.

Basic usage is to call the function `termcwd#get()` to
spawn the main terminal, or open it if it's already spawned, for the
window-local CWD inside Neovim or Vim. E.g., map it to spilt like so:

```vim
nnoremap <silent> <leader><cr> <cmd>call termcwd#split_get()<cr>
```

You can open up another session
with another CWD and the same
mapping will open another main
terminal for this session. Go
back to your previous session
and the same mapping will now
toggle open that session's
terminal.

## Install

Install it with any Neovim/Vim package/plugin manager, or clone/download it to a "pack/\*/start" folder in `runtimepath` (`:h packages`).

Termcwd is lazy loaded (defined only when used). It's too light for lazy loading to matter,
but all (Neo)vim packages/plugins should just do this.

## Use

`termcwd#get()` opens the main terminal for the window-local CWD.

`termcwd#split_get()` or `termcwd#sp_get()` opens the terminal in a split.

`termcwd#vsplit_get()` or `termcwd#vsp_get()` opens the terminal in a vertical split.

*They all create the terminal if it is doesn't exist for the particular reference.*

Optionally they take two arguments:

1. (number | string)—the terminal to open (`"main"` by default).
2. (string)—the CWD termcwd will open the terminal from (window-local CWD by default—`getcwd(0)`). Use an empty string to be able to open it from any CWD, or configure with `getcwd()`.

*The actual folder path the terminal starts in is (Neo)vim default window-local CWD. Which is usually what you want.*

### Configure Insert Mode

For consistency between Neovim and Vim—and what's generally a nice workflow—when a new terminal is spawned insert mode is started (like the default of Vim), then normal mode when that terminal is opened the next time (like the default of both Neovim and Vim).

To always start termcwd's returned terminal in insert mode:

```vim
let g:termcwd_insert = v:true
```

To never start it in insert mode (only for Neovim):

```vim
let g:termcwd_start_insert = v:false
```

## Examples

E.g., for an alternative terminal (numbered 1) that can be opened for the window-local CWD:

```vim
nnoremap <silent> <leader>1 <cmd>call termcwd#sp_get(1)<cr>
```

Or for a terminal that can be toggled globally in a (Neo)vim instance:

```vim
nnoremap <silent> <leader>1 <cmd>wincmd s<cr><cmd>call termcwd#get(0, "")<cr>
```

*Note: You can use `0` for both your window-local CWD main terminal and your instance global terminal without them interfering.*
