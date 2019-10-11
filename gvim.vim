if has('gui_running')
	set guifont=Consolas:h10:cANSI
	set background=dark
	colorscheme comfort
else
	set t_Co=256
	set background=dark
	colorscheme solarized
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

augroup vimrcGui
	autocmd!
	" Give alt key control to Windows
	autocmd GUIEnter * simalt ~x
augroup END

set showtabline=1 " show tabs only if there are more than one

" Make the cursor look nicer
set guicursor+=v:hor50
set guicursor+=i:ver1
set guicursor+=a:blinkwait750-blinkon750-blinkoff250
set guioptions=erR " tabs & right scollbar. No menu, toolbar and bottom scollbar
set guitablabel=%-0.12t%M " format of tab label

