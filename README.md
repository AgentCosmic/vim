# Vim

Lightweight, dependency free vim setup for Windows and Linux.

## Dependencies

- [Vim](https://www.vim.org/)
	- [Windows download](https://ftp.nluug.nl/pub/vim/pc/gvim90.exe)

## Windows

- Clone project repository.
- Install vim into this project folder at `./vim90`.
- Link the `_vimrc` file: `New-Item -ItemType HardLink -Path .\vim90\_vimrc -Target .\_vimrc`
- Install plugins: `vim -S plugin-snapshot.vim`

## Linux

```bash
cd ~
git clone https://github.com/AgentCosmic/vim.git
ln -rsf ~/vim/.vimrc .vimrc
vim -S vim/plugin-snapshot.vim
```
