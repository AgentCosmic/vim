if has('gui_running')
	set guifont=Consolas:h10:cANSI
	colorscheme distinct
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
