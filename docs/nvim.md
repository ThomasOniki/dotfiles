## Requirements
- latest nvim stable release
- git
- curl
- ripgrep
- fzf
- nightly rust toolchain (install with rustup)
- python 
- python venv
- npm

## Customisation
### Plugins
Return lazy.nvim plugin specs in lthe lua/plugins folder. You can use the files that I already have there or [this website](https://lazy.folke.io). LazyVim and lazy.nvim are not the same, lazy.nvim is a plugin manager and LazyVim is a configuration template that uses lazy.nvim. You can find documentation for LazyVim [here](https://www.lazyvim.org)

### Colorschemes
Add functions that enable your colorscheme to the table returned by [config/colorschemes.lua](../nvim/.config/nvim/lua/config/colorschemes.lua), and add their corresponding plugins to [plugins/colorschemes.lua](../nvim/.config/nvim/lua/plugins/colorschemes.lua). Again, see the existing configs if you want examples.
The colorscheme that will actually be enabled is chosen by this line in [init.lua](../nvim/.config/nvim/init.lua).
```lua
require("config.colorschemes").edge()
```
Change this to your prefered colorscheme.

### Keymaps
Add keymaps to [keymaps.lua](../nvim/.config/nvim/lua/config/keymaps.lua). If you use colemak dh, add colemak specific mappings to the map_colemak function and unmap them in unmap_colemak. If you don't use colemak, change this line in [init.lua](../nvim/.config/nvim/init.lua)
```lua
require("config.keymaps").colemak()
```
to
```lua
require("config.keymaps").qwerty()
```
or remove the colemak functions entirely.

## Useful mappings and commands
### Colemak

|action|description
|-|-
|n|Left
|i|Right
|u|Up
|e|Down
|r|Last WORD
|t|Next WORD
|R|Last word
|T|Next word
|h|Start of line (non ws)
|o|End of line
|a|Insert
|w|Append
|q|Undo


### Search

|action|description
|-|-
|\<leader>ff|Find file
|\<leader>fs|Find session
|\<leader>fb|Find open buffer
|\<leader>fh|Find recent file
|\<leader>fg|Grep files
|\<leader>f*|Grep for current word 
|\<leader>fr|Find and replace... 


### Lsp

|action|description
|-|-
|\<leader>ld|Goto definition
|\<leader>lr|Rename symbol
|\<leader>lk|Show hover info
|\<leader>lh|Toggle inlay hints
|\<leader>lc|Code action


### Buffers

|action|description
|-|-
|\<leader>w|Save buffer
|\<leader>W|Save all buffers
|\<leader>x|Save and close buffer
|\<leader>X|Force quit buffer without saving
|\<leader>q|Save all buffers and quit neovim
|\<leader>Q|Force quit neovim without saving
|\<leader>n|Prev buffer
|\<leader>i|Next buffer


### Miscalaneous

|action|description
|-|-
|jj, jk, tn|Escape
|:Lazy|Open lazy.nvim ui
|:Mason|Open mason.nvim ui


## Credits
This config was heavily inspired by [LazyVim](https://github.com/LazyVim/LazyVim) and [jdhao/nvim-config](https://github.com/jdhao/nvim-config), so you may want to look at those too.
Though I don't think there are any directly copied sections from lazyvim that aren't on the website, I have included its license in [licenses/LazyVim](../licenses/LazyVim) just in case. If you are knowlegable in this field and think I don't need the license, or have an explanation as to why I do, please contact me.
