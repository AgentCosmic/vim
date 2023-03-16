# Vim

Personal vim setup.

## Dependencies

- [vim](https://www.vim.org/) - [v8.2 64bit](https://cdn.tuxproject.de/vim-builds/2022-06-24_Vim_8.2.5153_pl_5.32.1_py_2.7.18_py_3.10.4_rkt_8.3_rb_3.1.2_lua_5.4.2_tcl_8.6.12_sod_1.0.18_complete-x86.exe)

## Windows

- Clone project repository.
- Install vim into this project folder at `/vim82`.
- Create these 2 folders at `./home/.cache/swap` and `./home/.cache/undo`.

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
