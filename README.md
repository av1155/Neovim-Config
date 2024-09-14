# Neovim-Config

###### My own personalized Neovim config which uses [AstroNvim](https://github.com/AstroNvim/AstroNvim), an aesthetic and feature-rich Neovim configuration.

<!--toc:start-->

-   [Neovim-Config](#neovim-config)
    -   [✨ Features](#features)
    -   [⚡ Requirements](#requirements)
    -   [🛠️ Installation](#🛠️-installation)
        -   [Backup your existing Neovim configuration](#backup-your-existing-neovim-configuration)
        -   [Create a new user repository](#create-a-new-user-repository)
        -   [Install and launch AstroNvim](#install-and-launch-astronvim)
        <!--toc:end-->

## ✨ Features

-   Common plugin specifications with [AstroCommunity](https://github.com/AstroNvim/astrocommunity)
-   File explorer with [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
-   Autocompletion with [Cmp](https://github.com/hrsh7th/nvim-cmp)
-   Git integration with [Gitsigns](https://github.com/lewis6991/gitsigns.nvim)
-   Statusline, Winbar, and Bufferline with [Heirline](https://github.com/rebelot/heirline.nvim)
-   Terminal with [Toggleterm](https://github.com/akinsho/toggleterm.nvim)
-   Fuzzy finding with [Telescope](https://github.com/nvim-telescope/telescope.nvim)
-   Syntax highlighting with [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
-   Formatting and Linting with [None-ls](https://github.com/nvimtools/none-ls.nvim)
-   Language Server Protocol with [Native LSP](https://github.com/neovim/nvim-lspconfig)
-   Debug Adapter Protocol with [nvim-dap](https://github.com/mfussenegger/nvim-dap)

## ⚡ Requirements

-   [Nerd Fonts](https://www.nerdfonts.com/font-downloads) (_Optional with manual intervention:_ See [Documentation on customizing icons](https://docs.astronvim.com/Recipes/icons)) <sup>[[1]](#1)</sup>
-   [Neovim 0.9.5+ (_Not_ including nightly)](https://github.com/neovim/neovim/releases/tag/stable)
-   [Tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md) (_Note:_ This is only necessary if you want to use `auto_install` feature with Treesitter)
-   A clipboard tool is necessary for the integration with the system clipboard (see [`:help clipboard-tool`](https://neovim.io/doc/user/provider.html#clipboard-tool) for supported solutions)
-   Terminal with true color support (for the default theme, otherwise it is dependent on the theme you are using) <sup>[[2]](#2)</sup>
-   Optional Requirements:
    -   [ripgrep](https://github.com/BurntSushi/ripgrep) - live grep telescope search (`<leader>fw`)
    -   [lazygit](https://github.com/jesseduffield/lazygit) - git ui toggle terminal (`<leader>tl` or `<leader>gg`)
    -   [go DiskUsage()](https://github.com/dundee/gdu) - disk usage toggle terminal (`<leader>tu`)
    -   [bottom](https://github.com/ClementTsang/bottom) - process viewer toggle terminal (`<leader>tt`)
    -   [Python](https://www.python.org/) - python repl toggle terminal (`<leader>tp`)
    -   [Node](https://nodejs.org/en/) - node repl toggle terminal (`<leader>tn`)

> **Note:** All downloadable Nerd Fonts contain icons which are used by AstroNvim. Install the Nerd Font of your choice to your system and in your terminal emulator settings, set its font face to that Nerd Font. If you are using AstroNvim on a remote system via SSH, you do not need to install the font on the remote system.

> **Note:** When using the default theme: For MacOS, the default terminal does not have true color support. You will need to use [iTerm2](https://iterm2.com/), [Kitty](https://sw.kovidgoyal.net/kitty/), [WezTerm](https://wezfurlong.org/wezterm/), or another [terminal emulator](https://github.com/termstandard/colors?tab=readme-ov-file#truecolor-support-in-output-devices) that has true color support.

## 🛠️ Installation

### Backup your existing Neovim configuration

Before proceeding, it's recommended to backup your existing Neovim configuration:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### Create a new user repository

1. Fork this repository by clicking the "Fork" button at the top right of this page.
2. Clone your forked repository to your local machine.

    - Alternatively, if you don't want to track your configuration on GitHub, you can clone this repository directly.

        ```bash
        git clone --depth 1 https://github.com/av1155/Neovim-Config.git ~/.config/nvim
        rm -rf ~/.config/nvim/.git
        nvim
        ```

### Install and launch AstroNvim

After cloning the repository, start Neovim:

```bash
git clone git@github.com:av1155/Neovim-Config.git ~/.config/nvim && nvim
```
