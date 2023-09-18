" ----- ----- ----- -----
" Behavior
" ----- ----- ----- -----

filetype plugin indent on " Important for a lot of things
set incsearch " Do incremental searching
set ignorecase " Ignore case when searching, but search capital if used
set smartcase " But use it when there is uppercase
set history=50 " Keep 50 lines of command line history
set path+=** " let's you fuzzy :find all files
set wildmenu " Auto complete on command line
set wildignore+=*.swp,.git,*/node_modules/*,*/venv/*,*/.venv/*,*.pyc,*.png,*.jpg,*.gif,*.psd,*.ai,desktop.ini,Thumbs.db " Ignore these files when searching
set hidden " Don't unload buffer when it's hidden
set lazyredraw " Don't redraw while executing macros (good performance config)
set encoding=utf8 " Set utf8 as standard encoding and en_US as the standard language
set synmaxcol=500 " Don't try to highlight lines longer than this
set signcolumn=yes " always show signcolumns
set colorcolumn=120 " set ruler to show at 120
set cursorline " highlight current line
set previewheight=8 " smaller preview window
set ruler " show the cursor position all the time
set scrolloff=1 " keep padding around cursor
set showcmd " display incomplete commands
set hlsearch " highlight search pattern

" Disable backup litters
set nobackup
set writebackup
" Use custom swap file location
set directory=$STORE/swap/
" Use persistent undo
set undofile
set undodir=$STORE/undo/

" Line number
set numberwidth=3
set relativenumber
set number

" Status line
set laststatus=2 " always show statusline
set statusline=\ %{StatuslineMode()}\ | " working directory
set statusline+=\ %f " working directory followed by file path
set statusline+=\ %r " readonly flag
set statusline+=\ %m " modified flag
set statusline+=%= " right align from here
set statusline+=\ %{&ff},\ %{strlen(&fenc)?&fenc:'none'}\ %y\  " filetype, format, encoding
set statusline+=\ | " separator
set statusline+=\ %l:\ %c\ -\ %L\ lines\ " current line, cursor column, line/total percent
function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
	return "NORMAL"
  elseif l:mode==?"v"
	return "VISUAL"
  elseif l:mode==#"i"
	return "INSERT"
  elseif l:mode==#"R"
	return "REPLACE"
  elseif l:mode==?"s"
	return "SELECT"
  elseif l:mode==#"t"
	return "TERMINAL"
  elseif l:mode==#"c"
	return "COMMAND"
  elseif l:mode==#"!"
	return "SHELL"
  endif
endfunction

augroup vimrcBehavior
	autocmd!

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	" Also don't do it when the mark is in the first line, that is the default
	" position when opening a file.
	autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") |
		\   exe "normal! g`\"" |
		\ endif

	" OmniComplete
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
	autocmd FileType python setlocal omnifunc=python3complete#Complete

	" Remove trailing whitespace before saving
	autocmd BufWritePre *.css,*.htm,*.html,*.js,*.php,*.py,*.ts,*.tsx,*.jsx,*.yaml,*.yml,*.vue :%s/\(\s\+\|\)$//e

	" Don't list preview window
	autocmd BufEnter * :call <SID>DelistWindow()
	" Don't list quickfix window
	autocmd FileType qf set nobuflisted
augroup END

function! s:DelistWindow()
	if &previewwindow
		set nobuflisted
	endif
endf

" visual paste doesn't replace paste buffer
function! RestoreRegister()
	let @" = s:restore_reg
	return ''
endfunction
function! s:Repl()
	let s:restore_reg = @"
	return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" keep cursor position when changing buffer
augroup keepCursorPosition
	autocmd!
	autocmd BufLeave * let b:winview = winsaveview()
	autocmd BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
augroup END


" ----- ----- ----- -----
" Text and formatting
" ----- ----- ----- -----

" Default to unix line ending
set fileformats=unix,dos

" Wordwrap
set linebreak

" Formatting
set textwidth=119
set formatoptions=croq " only comments

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set autoindent
set nocindent

" Folding
set foldnestmax=12
set foldlevel=9 " prefer to be open by default
set nofoldenable " disable by default
" define indent folds then allow manual folding
augroup enhanceFold
    autocmd!
    autocmd BufReadPre * setlocal foldmethod=indent
    autocmd BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
fun! FoldIndent() abort
    setlocal foldmethod=indent
	normal! za
    setlocal foldmethod=manual
endfun
nnoremap za :call FoldIndent()<cr>


" ----- ----- ----- -----
" Remapping
" ----- ----- ----- -----

" Change leader key
let mapleader = ' '

" Re-select after copying
vnoremap <c-c> "+ygv

" Delete without jumping http://vim.1045645.n5.nabble.com/How-to-delete-range-of-lines-without-moving-cursor-td5713219.html
command! -range D <line1>,<line2>d | norm <c-o>

" Don't use Ex mode, use Q for formatting
map Q gq

" Alternate file switching
nnoremap <bs> <c-^>

" Use 0 to move to first non-whitespace since I already have home button
nnoremap 0 ^
vnoremap 0 ^

" make k and l move one extra character
onoremap l 2l
onoremap h 2h

" Swap quote with backtick so it's easier to move to column
noremap ' `
vnoremap ' `
noremap ` '
vnoremap ` '

" Shorter undo sequence. Use CTRL-G u to break undo sequence. :h i_CTRL-G_u http://vim.wikia.com/wiki/Modified_undo_behavior
" Cannot use surrounds because it will disable delimitmate e.g. ()'"[]
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
inoremap . <c-g>u.
inoremap , <c-g>u,
inoremap = <c-g>u=

" Move line use ctrl-j and ctrl-k http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <c-j> :m .+1<cr>==
nnoremap <c-k> :m .-2<cr>==
inoremap <c-j> <esc>:m .+1<cr>==gi
inoremap <c-k> <esc>:m .-2<cr>==gi
vnoremap <c-j> :m '>+1<cr>gv=gv
vnoremap <c-k> :m '<-2<cr>gv=gv

" Select last modified/pasted http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> <leader>v '`[' . strpart(getregtype(), 0, 1) . '`]'

" Navigate between windows
noremap <a-j> <c-w>j
noremap <a-k> <c-w>k
noremap <a-h> <c-w>h
noremap <a-l> <c-w>l

" Increment, decrement number
nnoremap <c-up> <C-a>
nnoremap <c-down> <C-x>
nnoremap <c-s-up> 10<C-a>
nnoremap <c-s-down> 10<C-x>

" Shortcuts
nnoremap <leader>s :update<cr>
nnoremap <leader>as :wa<cr>
nnoremap <leader>nh :nohlsearch<cr>
nnoremap <leader>q :q<cr>
vnoremap <leader>p "_dP
nnoremap <leader>ou :update<cr>:source %<cr>
" Substitute
nnoremap <F2> yiw:%s/\<<c-r>0\>/
" Grep
nnoremap <F3> g*Nyiw:cw<cr>:grep <c-r>0
" Delete buffer without closing the split
nnoremap <F4> :bn\|bd #<cr>

" Disable function keys in insert mode
inoremap <F2> <esc><F2>
inoremap <F3> <esc><F3>
inoremap <F4> <esc><F4>
inoremap <F5> <esc><F5>
inoremap <F6> <esc><F6>
inoremap <F7> <esc><F7>
inoremap <F8> <esc><F8>
inoremap <F9> <esc><F9>
inoremap <F10> <esc><F10>


" ----- ----- ----- -----
" Commands
" ----- ----- ----- -----

command! CdToFile cd %:p:h
command! DeleteControlM %s/$//
command! EVimrc :e $MYVIMRC
command! SS :syntax sync fromstart
command! -nargs=? Count :%s/<f-args>//gn


" ----- ----- ----- -----
" TUI/GUI
" ----- ----- ----- -----

if (has("termguicolors"))
	set termguicolors
endif
syntax on
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif
colorscheme distinct


" ----- ----- ----- -----
" Plugins
" ----- ----- ----- -----

call plug#begin('$STORE/plugins')
" Universal Vim Functionality
Plug 'duff/vim-bufonly'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'itchyny/vim-cursorword'
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
" Programming Related
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " so vim-surround can repeat with dot command
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'wellle/targets.vim'
" GUI
Plug 'fholgado/minibufexpl.vim'
Plug 'ap/vim-css-color'
call plug#end()

" -----------------------------------------------------------------------------

" EasyMotion
let g:EasyMotion_leader_key = '<Leader>'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

" tcomment
nmap <leader>c <c-_><c-_>
vmap <leader>c <c-_><c-_>

" auto-pairs
augroup AutoPairs
	autocmd!
	autocmd FileType html,vue let b:AutoPairs = AutoPairsDefine({'<!--' : '-->'})
	autocmd FileType css,vue let b:AutoPairs = AutoPairsDefine({'/**' : '*/', '/*' : '*/'})
	autocmd FileType php let b:AutoPairs = AutoPairsDefine({'<?php' : '?>'})
augroup end
inoremap {, {},<left><left>
inoremap (, (),<left><left>
inoremap [, [],<left><left>

" ctrlp
let g:ctrlp_map = '<leader>f'
let g:ctrlp_show_hidden = 1
let g:ctrlp_open_multiple_files = 'i'
let g:ctrlp_by_filename = 1
let g:ctrlp_match_current_file = 0
let g:ctrlp_custom_ignore = {
			\ 'dir': '\v[\/](\..+|node_modules|__pycache__)$',
			\ 'file': '\v[\/](.+\.min\.(css|js))$'
			\ }
let g:user_command_async = 1
let g:ctrlp_user_command = {
			\ 'types': {
				\ 1: ['.git', 'cd %s && git ls-files -- . ":!:*.jpg" . ":!:*.png" . ":!:*.psd" . ":!:*.ai"'],
			\ },
			\ }

" MiniBufExpl
nnoremap <tab> :MBEbn<cr>
nnoremap <s-tab> :MBEbp<cr>
vnoremap <tab> :MBEbn<cr>
vnoremap <s-tab> :MBEbp<cr>
inoremap <c-tab> <esc>:MBEbf<cr>
vnoremap <c-tab> <esc>:MBEbf<cr>
nnoremap <c-tab> :MBEbf<cr>
inoremap <c-s-tab> <esc>:MBEbb<cr>
vnoremap <c-s-tab> <esc>:MBEbb<cr>
nnoremap <c-s-tab> :MBEbb<cr>
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplCycleArround = 1
" automatically exit MiniBufExpl when we enter it
augroup blurMiniBufExpl
	autocmd!
	autocmd WinEnter * call timer_start(50, 'EscapeMiniBufExpl')
augroup END
function! EscapeMiniBufExpl(timer)
	if @% == '-MiniBufExplorer-' 
		execute('wincmd j') 
	endif 
endfunction
