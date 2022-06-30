# Vim

Personal vim setup.

## Dependencies

- [vim](https://www.vim.org/) for [Windows](http://tuxproject.de/projects/vim/)
- *Optional:* [Universal ctags](https://github.com/universal-ctags/ctags-win32/releases)

## Windows

- Clone project repository.
- Install vim into this project folder at `/vim...`.
- Create these 2 folders at `/home/.cache/swap` and `/home/.cache/undo`.

## Linux

```bash
git clone https://github.com/AgentCosmic/vim.git
ln -rsf ~/vim/.vimrc .vimrc
mkdir .vimfiles
mkdir .vimfiles/undo
mkdir .vimfiles/swap
vim
```

## Getting Started

Install plugins: `:PlugInstall`
