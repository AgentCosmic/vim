" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" set directory to keep all the vim files
let $STORE = $HOME .. '/vim/vimfiles'
set runtimepath+=$STORE

source $HOME/vim/common.vim
