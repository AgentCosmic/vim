# Windows

Remember to create these 2 folders in same folder as .vimrc

- /home/swap
- /home/undo

Latest Windows build available at:

- [http://tuxproject.de/projects/vim/](http://tuxproject.de/projects/vim/)
- [http://wyw.dcweb.cn/](http://wyw.dcweb.cn/)
- [https://bitbucket.org/Haroogan/vim-for-windows/src](https://bitbucket.org/Haroogan/vim-for-windows/src)


# Linux

```bash
git clone git@github.com:AgentCosmic/vim.git
ln -rsf ~/vim/.vimrc .vimrc
mkdir .vimfiles
mkdir .vimfiles/undo
mkdir .vimfiles/swap
vim
```

Install plugins: `:PlugInstall`
