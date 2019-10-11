if has('gui_running')
	set guifont=Consolas:h10:cANSI
	set background=dark
	colorscheme comfort
else
	set t_Co=256
	set background=dark
	colorscheme desert
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

augroup vimrcGui
	autocmd!
	" Give alt key control to Windows
	autocmd GUIEnter * simalt ~x
augroup END

" show tabs only if there are more than one
set showtabline=1

" Make the cursor look nicer
set guicursor+=v:hor50
set guicursor+=i:ver1
set guicursor+=a:blinkwait750-blinkon750-blinkoff250
set guioptions=erR " tabs & right scollbar. No menu, toolbar and bottom scollbar
set guitablabel=%-0.12t%M " format of tab label

" Reset <c-f> mapping to original (scroll down) that was overridden in mswin.vim
unmap <c-f>
