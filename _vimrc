"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

source $VIMRUNTIME/mswin.vim
behave mswin

" Change home directory
let $HOME = $VIM . '/home'

" Pathogen doesn't need to load itself
let g:pathogen_disabled = ['vim-pathogen']

" Disable localvimrc if it's here because we will load it later in the script
let hasLvimrc = filereadable('_lvimrc')
if hasLvimrc
	let g:pathogen_disabled = add(g:pathogen_disabled, 'vim-localvimrc')
endif

" Start Pathogen First!
source $VIM/bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect(expand('$VIM/bundle'))


" ----- ----- ----- -----
" Behavior
" ----- ----- ----- -----

filetype plugin indent on " Important for a lot of things
set incsearch " Do incremental searching
set ignorecase " Ignore case when searching, but search capital if used
set smartcase " But use it when there is uppercase
set grepprg=grep\ -rnH " Use grep instead of findstr
set history=50 " Keep 50 lines of command line history
set wildmenu " Auto complete on command line
set wildignore+=*.swp,.git,.svn,*.pyc,*.png,*.jpg,*.gif,*.psd,desktop.ini " Ignore these files when searching
set hidden " Don't unload buffer when it's hidden
set lazyredraw " Don't redraw while executing macros (good performance config)
set encoding=utf8 " Set utf8 as standard encoding and en_US as the standard language
set synmaxcol=1000 " Don't try to highlight lines longer than this

" Disable backup litters
set nobackup
set writebackup
" Use custom swap file location
set directory=$HOME/swap//,.
" Use persistent undo
set undofile
set undodir=$HOME/undo//,.

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

	" Remove trailing space before saving
	autocmd BufWritePre *.css,*.htm,*.html,*.js,*.php,*.py :%s/\s\+$//e

	" Delete empty buffers, specially for files opened with --remote option
	autocmd BufAdd * :call <SID>DeleteBufferIfEmpty()

	" Don't list preview and quickfix window
	autocmd BufEnter * :call <SID>DelistWindow()
augroup END

function! s:DeleteBufferIfEmpty()
	" If no name and no content
	if bufname('%') == '' && line('$') == 1 && getline(1) == ''
		bwipe
		" This will trigger filetype detection, mainly to trigger syntax highlighting
		doautocmd BufRead
	endif
endfunction

function! s:DelistWindow() 
    if &previewwindow 
        set nobuflisted 
	elseif &filetype == 'qf'
		set nobuflisted
	endif
endf 


" ----- ----- ----- -----
" GUI
" ----- ----- ----- -----

if has('gui_running')
	set guifont=Consolas:h10:cANSI
	colorscheme consis
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

" Make the cursor look nicer
set guicursor+=v:hor50
set guicursor+=i:ver1
set guicursor+=a:blinkwait750-blinkon750-blinkoff250

augroup vimrcGui
	autocmd!

	" Give alt key control to Windows
	autocmd GUIEnter * simalt ~x

	" Highlight current line
	autocmd InsertLeave * set nocursorline
	autocmd InsertEnter * set cursorline
	" set cursorline will cause MiniBufferExpl to have problem
augroup END

" Line number
set numberwidth=5
set relativenumber

set guitablabel=%-0.12t%M " format of tab label
set showtabline=1 " show tabs only if there are more than one
set ruler " show the cursor position all the time
set showcmd " display incomplete commands

" tabs & right scollbar. No menu, toolbar and bottom scollbar
set guioptions=erR

" Keep padding around cursor
set scrolloff=1

" Status line
set laststatus=2 " always show statusline
set statusline=\ %F
set statusline+=\ %r " readonly flag
set statusline+=\ %m " modified flag
set statusline+=%= " right align from here
set statusline+=%c,\ %l/%L\ %P " cursor column, line/total percent
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'},\ %{&ff}]\  " encoding, format

" Smaller preview window
set previewheight=6


" ----- ----- ----- -----
" Text
" ----- ----- ----- -----

" Wordwrap
set linebreak

" Formatting
set textwidth=79
set formatoptions=croq " only comments

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set autoindent
set nocindent

" Folding
set foldmethod=indent
set foldnestmax=5
set foldlevel=9 " prefer to be open by default
set nofoldenable " disable by default


" ----- ----- ----- -----
" Remapping
" ----- ----- ----- -----

" Don't use Ex mode, use Q for formatting
map Q gq

" Alternate file switching
nnoremap <bs> <c-^>

" Use 0 to move to first non-whitespace since I already have home button
nnoremap 0 ^
vnoremap 0 ^

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

" Move line use alt-j and alt-k http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <a-j> :m .+1<cr>==
nnoremap <a-k> :m .-2<cr>==
inoremap <a-j> <esc>:m .+1<cr>==gi
inoremap <a-k> <esc>:m .-2<cr>==gi
vnoremap <a-j> :m '>+1<cr>gv=gv
vnoremap <a-k> :m '<-2<cr>gv=gv

" Select last modified/pasted http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> <leader>v '`[' . strpart(getregtype(), 0, 1) . '`]'
" Paste then select
map <leader>p p<leader>v

" Shortcuts
nnoremap <leader>s :update<cr>
nnoremap <leader>h :nohlsearch<cr>
nnoremap <leader>q :q<cr>
vnoremap <leader>p "_dP
nnoremap <leader>o :update<cr>:source %<cr>
" Substitute
nnoremap <F2> yiw:%s/\<<c-r>0\>/
" Grep
nnoremap <F3> *Nyiw:grep <c-r>0 
" Delete buffer
nnoremap <F4> :bdelete<cr>
nnoremap <c-F4> :BufOnly<cr>


" ----- ----- ----- -----
" Plugins
" ----- ----- ----- -----

" Gundo
ca GT GundoToggle

" Syntastic
let g:syntastic_javascript_gjslint_conf = '--nostrict'
let g:syntastic_python_checker_args = '--ignore=E501'

" delimitmate
let delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_expand_cr = 1

" ctrlp
let g:ctrlp_open_multiple_files = 'i'
let g:ctrlp_by_filename = 1

" EasyMotion
let g:EasyMotion_leader_key = '<Leader>'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

" Zen Coding
let g:user_zen_leader_key = '<c-y>'
let g:user_zen_expandabbr_key = '<c-e>'
let g:use_zen_complete_tag = 1

" Comments
nmap <leader>c <c-_><c-_>
imap <leader>c <c-o><c-_><c-_>
vmap <leader>c <c-_><c-_>

" localvimrc
let g:localvimrc_name = '_lvimrc'
let g:localvimrc_count = 1
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0

" Tagbar
ca TT TagbarToggle
let g:tagbar_sort = 0
let g:tagbar_type_php  = {
		\ 'ctagstype': 'php',
		\ 'kinds': [
			\ 'i:interfaces',
			\ 'c:classes',
			\ 'd:constant definitions',
			\ 'f:functions',
			\ 'j:javascript functions:1'
		\ ]
	\ }

" neocomplcache
inoremap <expr> <tab> pumvisible() ? '<c-n>' : '<tab>'
inoremap <expr> <s-tab> pumvisible() ? '<c-p>' : '<s-tab>'
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_caching_limit_file_size = 50000
" higher value = higher priority
" swap priority of syntax and buffer complete
let g:neocomplcache_source_rank = {
	\ 'buffer_complete': 7,
	\ 'syntax_complete': 5
	\ }


" MiniBufferExpl
nnoremap <tab> :bn!<cr>
nnoremap <s-tab> :bp!<cr>
inoremap <c-tab> <esc>:bn!<cr>
vnoremap <c-tab> <esc>:bn!<cr>
nnoremap <c-tab> :bn!<cr>
inoremap <c-s-tab> <esc>:bp!<cr>
vnoremap <c-s-tab> <esc>:bp!<cr>
nnoremap <c-s-tab> :bp!<cr>
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1 " ctrl hjkl
hi MBEVisibleActive guibg=#46474a gui=bold
hi MBEVisibleChangedActive guibg=#46474a gui=bold,italic
hi MBENormal guifg=#c2c7cc
hi MBEChanged guifg=fg gui=italic
hi link MBEVisibleNormal MBENormal
hi link MBEVisibleChanged MBEChanged
let g:miniBufExplCheckDupeBufs = 0
" Toggle g:miniBufExplCheckDupeBufs because sometimes it get very slow
map <F12> :call ToggleMiniBufExplCheckDupeBufs()<cr>
function! ToggleMiniBufExplCheckDupeBufs()
	if g:miniBufExplCheckDupeBufs == 1
		let g:miniBufExplCheckDupeBufs = 0
	else
		let g:miniBufExplCheckDupeBufs = 1
	endif
endfunction


" ----- ----- ----- -----
" Others
" ----- ----- ----- -----

" Get syntax under cursor
noremap <F1> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>


" Code taken from TagbarToggle
" Get the number of the scratch buffer. Will create one if needed.
function! GetScratchBuffer(name) abort
    let buffer_number = bufwinnr(a:name)
    if buffer_number == -1
		" create buffer
		let eventignore_save = &eventignore
		set eventignore=all
		execute 'silent keepalt belowright vertical 60split ' . a:name
		let &eventignore = eventignore_save

		setlocal noreadonly " in case the "view" mode is used
		setlocal buftype=nofile
		setlocal bufhidden=hide
		setlocal noswapfile
		setlocal nobuflisted
		setlocal nomodifiable
		setlocal nolist
		setlocal nonumber
		setlocal winfixwidth
		setlocal textwidth=0
		setlocal nocursorline
		setlocal nocursorcolumn
		setlocal nospell

		if exists('+relativenumber')
			setlocal norelativenumber
		endif

		setlocal nofoldenable
		setlocal foldcolumn=0
		" Reset fold settings in case a plugin set them globally to something
		" expensive. Apparently 'foldexpr' gets executed even if 'foldenable' is
		" off, and then for every appended line (like with :put).
		setlocal foldmethod&
		setlocal foldexpr&

		let buffer_number = bufwinnr(a:name)
    endif
	return buffer_number
endfunction

" Replace the content of the buffer
function! ReplaceContent(buffer_number, content) abort
	" focus on buffer
	let original_buffer = winnr()
    if original_buffer == a:buffer_number
        let in_buffer = 1
    else
        let in_buffer = 0
        call s:winexec(a:buffer_number . 'wincmd w')
    endif

    let lazyredraw_save = &lazyredraw
    set lazyredraw
    let eventignore_save = &eventignore
    set eventignore=all

    setlocal modifiable

    silent %delete _

    " Delete empty lines at the end of the buffer
    for linenr in range(line('$'), 1, -1)
        if getline(linenr) =~ '^$'
            execute 'silent ' . linenr . 'delete _'
        else
            break
        endif
    endfor

	" render
	silent put = a:content

    setlocal nomodifiable

    let &lazyredraw  = lazyredraw_save
    let &eventignore = eventignore_save

	" return to previous buffer
    if !in_buffer
        call s:winexec(original_buffer . 'wincmd w')
    endif
endfunction

function! s:winexec(cmd) abort
    let eventignore_save = &eventignore
    set eventignore=BufEnter
    execute a:cmd
    let &eventignore = eventignore_save
endfunction


" BufOnly from https://github.com/duff/vim-bufonly
command! -nargs=? -complete=buffer -bang BufOnly :call <SID>BufOnly('<args>', '<bang>')
function! s:BufOnly(buffer, bang)
	if a:buffer == ''
		" No buffer provided, use the current buffer.
		let buffer = bufnr('%')
	elseif (a:buffer + 0) > 0
		" A buffer number was provided.
		let buffer = bufnr(a:buffer + 0)
	else
		" A buffer name was provided.
		let buffer = bufnr(a:buffer)
	endif

	if buffer == -1
		echohl ErrorMsg
		echomsg "No matching buffer for" a:buffer
		echohl None
		return
	endif

	let last_buffer = bufnr('$')

	let delete_count = 0
	let n = 1
	while n <= last_buffer
		if n != buffer && buflisted(n)
			if a:bang == '' && getbufvar(n, '&modified')
				echohl ErrorMsg
				echomsg 'No write since last change for buffer'
							\ n '(add ! to override)'
				echohl None
			else
				silent exe 'bdel' . a:bang . ' ' . n
				if ! buflisted(n)
					let delete_count = delete_count+1
				endif
			endif
		endif
		let n = n+1
	endwhile

	if delete_count == 1
		echomsg delete_count "buffer deleted"
	elseif delete_count > 1
		echomsg delete_count "buffers deleted"
	endif

endfunction


" Vim default diff does not work well
set diffexpr=MyDiff()
function! MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '\"' . arg1 . '\"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '\"' . arg2 . '\"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '\"' . arg3 . '\"' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '\"' . $VIMRUNTIME . '\diff\"'
			let eq = '\"\"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '\" ', '') . '\diff\"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


" ----- ----- ----- -----
" _lvimrv
" ----- ----- ----- -----
" we still need this becuase localvimrc does not load fast enough
if hasLvimrc
	source _lvimrc
endif
