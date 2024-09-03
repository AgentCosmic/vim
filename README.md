# Vim

Lightweight, dependency free vim setup for Windows and Linux.

## Dependencies

- [Vim](https://www.vim.org/)
	- [Windows download](https://github.com/vim/vim-win32-installer/releases/download/v9.0.2189/gvim_9.0.2189_x64.exe)

## Windows

- Clone project repository.
- Install vim into this project folder at `./vim90`.
- Link the `_vimrc` file: `New-Item -ItemType HardLink -Path D:\software\vim\vim90\_vimrc -Target .\_vimrc`
- Install plugins: `vim -S plugin-snapshot.vim`

## Linux

```bash
sudo apt install git vim -y
cd ~
git clone https://github.com/AgentCosmic/vim.git
ln -rsf ~/vim/.vimrc .vimrc
vim -S vim/plugin-snapshot.vim
```
