## Requirements
- zsh
- zsh-fast-syntax-highlighting (this isn't a default package on linux, clone [the repo](https://github.com/zdharma-continuum/fast-syntax-highlighting) or use zsh-syntax-highlighting)
- zsh-autocomplete
- zsh-autosuggestions
- lsd
- trash-cli (on macos, /usr/bin/trash comes builtin)
- zoxide
- the vulkan sdk

## Notes
If you are not on an apple silicon mac using homebrew, you may need to change paths in .zshenv.
You should also remove the environement variables and aliases for things you don't use.
For example, chances are you don't use vulkan, so remove this line in .zshenv
```zsh
source $HOME/VulkanSDK/1.4.341.0/setup-env.sh > /dev/null
```
