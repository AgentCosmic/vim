" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Change home directory so plugins don't pollute our real home directory
let $ROOT = $VIM
let $HOME = $ROOT . '/home'
" Set directory to keep all the vim files
let $STORE = $ROOT . '/vimfiles'
set runtimepath+=$STORE

source $VIMRUNTIME/mswin.vim
behave mswin

source $ROOT/common.vim

" ----- ----- ----- -----
" GUI
" ----- ----- ----- -----

if has('gui_running')
	set guifont=Consolas:h10:cANSI
endif

" Make the cursor look nicer
set guicursor+=v:hor50
set guicursor+=a:blinkwait750-blinkon750-blinkoff250

augroup vimrcGui
	autocmd!
	" Give alt key control to Windows
	autocmd GUIEnter * simalt ~x
augroup END

set showtabline=1 " show tabs only if there are more than one
set guioptions=erR " tabs & right scollbar. No menu, toolbar and bottom scollbar
set guitablabel=%-0.12t%M " format of tab label

" Reset <c-f> mapping to original (scroll down) that was overridden in mswin.vim
unmap <c-f>
