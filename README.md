<div align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Neovim-logo.svg/742px-Neovim-logo.svg.png">
</div>

<hr>

<div align="center"><p>
    <a href="https://github.com/masajinobe-ef/modular.nvim/releases/latest">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/masajinobe-ef/modular.nvim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41&include_prerelease&sort=semver" />
    </a>
    <a href="https://github.com/masajinobe-ef/modular.nvim/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/masajinobe-ef/modular.nvim?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/masajinobe-ef/modular.nvim/blob/main/LICENSE">
      <img alt="License" src="https://img.shields.io/github/license/masajinobe-ef/modular.nvim?style=for-the-badge&logo=starship&color=ee999f&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/masajinobe-ef/modular.nvim/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/masajinobe-ef/modular.nvim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/masajinobe-ef/modular.nvim/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/masajinobe-ef/modular.nvim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/masajinobe-ef/modular.nvim">
      <img alt="Repo Size" src="https://img.shields.io/github/repo-size/masajinobe-ef/modular.nvim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>
</div>

Modular is a Neovim setup powered by [💤 lazy.nvim](https://github.com/folke/lazy.nvim)
to make it easy to customize and extend your config.

![Image](https://github.com/user-attachments/assets/dd760054-38d9-47fd-901e-b01c4980cb1b)

![Image](https://github.com/user-attachments/assets/3a3c48d4-14e5-4633-84c5-8ae07b02b6bf)

## ⚡️ Requirements

- Neovim >= **0.9.0** (needs to be built with **LuaJIT**)
- Git >= **2.19.0** (for partial clones support)
- a [Nerd Font](https://www.nerdfonts.com/)(v3.0 or greater) **_(optional, but needed to display some icons)_**
- a **C** compiler for `nvim-treesitter`. See [here](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
- for [fzf-lua](https://github.com/ibhagwan/fzf-lua) **_(optional)_**
  - **fzf**: [fzf](https://github.com/junegunn/fzf) **(v0.25.1 or greater)**
  - **live grep**: [ripgrep](https://github.com/BurntSushi/ripgrep)
  - **find files**: [fd](https://github.com/sharkdp/fd)
- a terminal that support true color and _undercurl_:
  - [alacritty](https://github.com/alacritty/alacritty) **_(Linux, Macos & Windows)_**
  - [kitty](https://github.com/kovidgoyal/kitty) **_(Linux & Macos)_**
  - [wezterm](https://github.com/wez/wezterm) **_(Linux, Macos & Windows)_**
  - [iterm2](https://iterm2.com/) **_(Macos)_**

## Installation

### Install Neovim

Modular targets _only_ the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:

- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

### Install Modular

> **NOTE**
> Backup your previous configuration (if any exists)

```sh
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

Neovim's configurations are located under the following paths, depending on your OS:

| OS                   | PATH                                      |
| :------------------- | :---------------------------------------- |
| Linux, MacOS         | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)        | `%localappdata%\nvim\`                    |
| Windows (powershell) | `$env:LOCALAPPDATA\nvim\`                 |

#### Clone Modular

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/masajinobe-ef/modular.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/masajinobe-ef/modular.nvim.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/masajinobe-ef/modular.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
current plugin status. Hit `q` to close the window.

<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```

</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```

</details>

### License

Based on [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
This project is licensed under MIT. Please refer to the [LICENSE](LICENSE.md) file for detailed license information.
