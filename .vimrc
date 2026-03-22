" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" set directory to keep all the vim files
let $ROOT = fnamemodify(resolve($MYVIMRC), ':h')
let $STORE = $ROOT . '/vimfiles'
set runtimepath+=$STORE

source $ROOT/common.vim

" ----- ----- ----- -----
" GUI
" ----- ----- ----- -----

if has('gui_running')
	set guifont=DejaVu\ Sans\ Mono\ 9
	" maximize window on startup
	set lines=999
	set columns=999
endif

" Make the cursor look nicer
set guicursor+=v:hor50
set guicursor+=a:blinkwait750-blinkon750-blinkoff250
