# vim-rust-ide
My attempt to make vim more rust friendly from an IDE perspective

These instructions get neovim setup for
* Autocompletion
* Live-linting
* Autoformatting
* Syntax-highlighting
* hover docs
* jump to def

## Install the rust toolchains
Install [rustup](https://www.rust-lang.org/tools/install)
Add ~/.cargo/bin to PATH `echo "~/.cargo/bin" >> ~/.bashrc`

### RLS
Rust Language Server [RLS](https://github.com/rust-lang/rls)

```bash
rustup toolchain install stable
rustup toolchain install nightly
rustup default stable
rustup component add rls rust-analysis rust-src
```
### Racer
Rust Code Completion utility [Racer](https://github.com/racer-rust/racer)

```bash
cargo +nightly install racer
```

It is recommeded to set `RUST_SRC_PATH` for speed it isn't needed

```bash
echo "export RUST_SRC_PATH=\"$(rustc --print sysroot)/lib/rustlib/src/rust/src\"" >> ~/.bashrc
```

### rustfmt

Format Rust code [rustfmt](https://github.com/rust-lang/rustfmt)

```bash
cargo install rustfmt-nightly
```

### python modules
Most operating systems come with python installed
[Python](https://github.com/python/cpython)

Need to have `msgpack` >= 1.0.0

```bash
python3 -m pip install -U pynvim msgpack
```

### nodejs install

coc.nvim uses nodejs.  Some may not like nodejs installed.  If that is the case use deoplete.  There are some commits in the repo that have examples of how to use it with rust.
[coc.nvim](https://github.com/neoclide/coc.nvim)

```bash
curl -sL install-node.now.sh/lts | bash
```

### Neovim

[vim-plug](https://github.com/junegunn/vim-plug)

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Install neovim
[Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

Update `~/.config/nvim/init.vim` using init.vim file in source repo

```bash
cp init.vim ~/.config/nvim/
```

Install patched powerline font (Optional)

[SauceCodePro](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf)

Start neovim

```bash
nvim
```

Inside neovim install plugins `:PlugInstall`

## Alacritty terminal (Optional)

Install alacritty terminal
[Alacritty](https://github.com/alacritty/alacritty)

Copy `alacritty.yml` from repo

```bash
cp alacritty.yml ~/.config/alacritty/
```

## Tmux (Optional)

Install tmux
[Tmux](https://github.com/tmux/tmux)

Copy `tmux.conf` from repo

```bash
cp tmux.conf ~/.tmux.conf
```

```bash
tmux
```

`ctrl+b I` to install plugins
`ctrl+b r` to reload tmux

###  Refs
- [tmux-vi-yank](https://github.com/casonadams/tmux-vi-yank)
- [tmux-vi-navigation](https://github.com/casonadams/tmux-vi-navigation)

## Usage

| Command | Result          |
| ------- | ------          |
| K       | show doc hover  |
| gd      | go to def       |
| gcc     | Line comment    |
| F3      | Toggle NERDTree |
| F2      | Toggle Tagbar   |
| F1      | Update tags     |
| SPACE = | Buffer Next     |
| SPACE - | Buffer Previous |

