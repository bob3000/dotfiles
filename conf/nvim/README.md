# Neovim config

<!-- vim-markdown-toc GFM -->

* [Requirements](#requirements)
  * [Linux](#linux)
  * [MacOS](#macos)
  * [pip](#pip)
  * [Node](#node)
* [Install the config](#install-the-config)
* [Get healthy](#get-healthy)
* [Install Mason packages](#install-mason-packages)
* [Credits](#credits)

<!-- vim-markdown-toc -->

## Requirements

### Linux

```sh
pacman -S deno xclip wl-clipboard ripgrep fd ttf-jetbrains-mono noto-fonts noto-fonts-emoji
```

### MacOS

```sh
brew install deno ripgrep fd font-jetbrains-mono noto-fonts noto-fonts-emoji
```

### pip

```sh
pip install pynvim
```

### Node

```sh
npm i -g neovim
```

## Install the config

Make sure to remove or move your current `nvim` directory

```sh
git clone git@github.com:bob3000/neovim-config.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed

**NOTE** First time you will get an error just ignore them and press enter,
it will say nvim-ts-context-commentstring is not installed but that is fine just
close and reopen nvim and everything should be fine

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time
you open Neovim)

## Get healthy

Open `nvim` and enter the following:

```vim
:checkhealth
```

## Install Mason packages

from inside neovim do:

```lua
:MasonInstall isort black flake8 delve codespell shfmt firefox-debug-adapter cspell markdownlint codelldb
```

## Credits

[LunarVim/nvim-basic-ide](https://github.com/LunarVim/nvim-basic-ide)
