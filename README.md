# Heisenvim

Yes, I do watch Breaking Bad. No, the repo name doesn't mean anything.
This is just something I wrote in my free time, not too messy but it should work (hopefully).

## Features

- Supports Windows and Linux
- Runs out-of-the-box
- Basic Lua/Java/Python/C/C++/HTML/CSS/JS support
- Automatic LSP configuration (albeit simple)
- Nvim-dap configuration (still experimental)
- Easily extendable

## Requirements

The config is pretty much always updated to support the [latest stable Neovim version](https://github.com/neovim/neovim/releases/tag/stable), so make sure your Neovim version is suitable. Some plugins may not work on older versions.

There are also some packages, which I will list below, that must be installed beforehand if you want the setup to work. You can manually install them using a package manager of your choosing. I'm not planning on writing an installation script for different terminals, but we'll see.

    - ripgrep
    - npm
    - gcc
    - g++ (might have a different name depending on the distro)
    - make
    - python3

## Installation

After installing the required packages, you can clone the repo to the Neovim directory ('~/.config/nvim/' for Linux and '$HOME/AppData/Local/nvim' for Windows)

```bash
$ git clone https://github.com/rocket24h/heisenvim.git .
```

It is advised to checkout the file './lua/rocket24h/core/globals.lua' to see what options are available.

You can modify the file above before running the command to change to your preferred settings. To setup LSPs, linters, formatters, ... you must run the command

```code
:MasonInstallAll
```
