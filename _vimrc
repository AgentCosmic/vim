"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

source $VIMRUNTIME/mswin.vim
behave mswin

" Change home directory
let $HOME = $VIM . '/home'

" ----- ----- ----- -----
" Behavior
" ----- ----- ----- -----

filetype plugin indent on " Important for a lot of things
set incsearch " Do incremental searching
set ignorecase " Ignore case when searching, but search capital if used
set smartcase " But use it when there is uppercase
set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m,%f:%l:%m
set history=50 " Keep 50 lines of command line history
set wildmenu " Auto complete on command line
set wildignore+=*.swp,.git,.svn,*.pyc,*.png,*.jpg,*.gif,*.psd,desktop.ini,Thumbs.db " Ignore these files when searching
set hidden " Don't unload buffer when it's hidden
set lazyredraw " Don't redraw while executing macros (good performance config)
set encoding=utf8 " Set utf8 as standard encoding and en_US as the standard language
set synmaxcol=500 " Don't try to highlight lines longer than this

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

	" less files
	" autocmd BufNewFile,BufRead *.less setlocal filetype=css

	" Remove trailing space before saving
	autocmd BufWritePre *.css,*.htm,*.html,*.js,*.php,*.py,*.vue :%s/\s\+$//e

	" Delete empty buffers, specially for files opened with --remote option
	" autocmd BufAdd * nested :call <SID>DeleteBufferIfEmpty()
	" command must be nested to other autocommand will also be called,
	" specifically MiniBufExpl https://github.com/fholgado/minibufexpl.vim/issues/90#issuecomment-19815252

	" Don't list preview and quickfix window
	autocmd BufEnter * :call <SID>DelistWindow()
augroup END

" function! s:DeleteBufferIfEmpty()
" 	" If no name and no content
" 	if bufname('%') == '' && line('$') == 1 && getline(1) == ''
" 		bwipe
" 		" This will trigger filetype detection, mainly to trigger syntax highlighting
" 		doautocmd BufRead
" 	endif
" endfunction

function! s:DelistWindow()
	if &previewwindow
		set nobuflisted
	elseif &filetype == 'qf'
		set nobuflisted
	endif
endf

" vp doesn't replace paste buffer
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
" GUI
" ----- ----- ----- -----

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

" Status line
set laststatus=2 " always show statusline
set statusline=\ %{getcwd()}\ \ \|\ \ %f " working directory followed by file path
set statusline+=\ %r " readonly flag
set statusline+=\ %m " modified flag
set statusline+=%= " right align from here
set statusline+=%c,\ %l\ \|\ %P\ of\ %L\ " cursor column, line/total percent
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'},\ %{&ff}]\  " encoding, format

" Line number
set numberwidth=5
set relativenumber
set number

set signcolumn=yes " always show signcolumns
set colorcolumn=80,120 " set ruler to show at column 80 and 120
set cursorline " highlight current line
set previewheight=8 " smaller preview window
set ruler " show the cursor position all the time
set scrolloff=1 " keep padding around cursor
set showcmd " display incomplete commands
set showtabline=1 " show tabs only if there are more than one

" gVim
" Make the cursor look nicer
set guicursor+=v:hor50
set guicursor+=i:ver1
set guicursor+=a:blinkwait750-blinkon750-blinkoff250
set guioptions=erR " tabs & right scollbar. No menu, toolbar and bottom scollbar
set guitablabel=%-0.12t%M " format of tab label


" ----- ----- ----- -----
" Text
" ----- ----- ----- -----

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
set foldmethod=indent
set foldnestmax=8
set foldlevel=9 " prefer to be open by default
set nofoldenable " disable by default


" ----- ----- ----- -----
" Remapping
" ----- ----- ----- -----

" Reset <c-f> mapping to original (scroll down) that was overridden in mswin.vim
unmap <c-f>

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

" Move line use alt-j and alt-k http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <c-j> :m .+1<cr>==
nnoremap <c-k> :m .-2<cr>==
inoremap <c-j> <esc>:m .+1<cr>==gi
inoremap <c-k> <esc>:m .-2<cr>==gi
vnoremap <c-j> :m '>+1<cr>gv=gv
vnoremap <c-k> :m '<-2<cr>gv=gv

" Select last modified/pasted http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> <leader>v '`[' . strpart(getregtype(), 0, 1) . '`]'
" Paste then select
" nmap <leader>p p<leader>v

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
nnoremap <leader>a :wa<cr>
nnoremap <leader>h :nohlsearch<cr>
nnoremap <leader>q :q<cr>
vnoremap <leader>p "_dP
nnoremap <leader>o :update<cr>:source %<cr>
" Substitute
nnoremap <F2> yiw:%s/\<<c-r>0\>/
" Grep
nnoremap <F3> g*Nyiw:cw<cr>:grep <c-r>0
" Delete buffer
nnoremap <F4> :bdelete<cr>

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

" Highlight when double click
nnoremap <silent> <2-leftmouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>viwg<c-h>

" Get syntax under cursor
noremap <F1> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>


" ----- ----- ----- -----
" Commands
" ----- ----- ----- -----

command! CdToFile cd %:p:h
command! DeleteControlM %s/$//
command! EVimrc :e $MYVIMRC
command! SS :syntax sync fromstart

" edit a macro using cq(macro name)
fun! ChangeReg() abort
  let x = nr2char(getchar())
  call feedkeys("q:ilet @" . x . " = \<c-r>\<c-r>=string(@" . x . ")\<cr>\<esc>0f'", 'n')
endfun
nnoremap cq :call ChangeReg()<cr>


" ----- ----- ----- -----
" Plugins
" ----- ----- ----- -----

call plug#begin('$HOME/plugged')
" Universal Vim Functionality
" Plug 'embear/vim-localvimrc'
Plug 'duff/vim-bufonly'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'itchyny/vim-cursorword'
Plug 'easymotion/vim-easymotion'
" Programming Related
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'sickill/vim-pasta'
Plug 'AndrewRadev/sideways.vim'
Plug 'wellle/targets.vim'
Plug 'nathanaelkane/vim-indent-guides', {'on': ['IndentGuidesEnable', 'IndentGuidesToggle']}
Plug 'Shougo/echodoc.vim' " used by coc
" External Dependency
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}} " install yarn first
Plug 'ctrlpvim/ctrlp.vim' " https://github.com/BurntSushi/ripgrep/releases
Plug 'majutsushi/tagbar', { 'on': ['Tagbar', 'TagbarToggle', 'TagbarOpen'] } " https://github.com/universal-ctags/ctags-win32/releases
Plug 'w0rp/ale'
" GUI
Plug 'fholgado/minibufexpl.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Language
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'pearofducks/ansible-vim'
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install', 'on': 'MarkdownPreview' }

" Evaluating
Plug 'unblevable/quick-scope'
Plug 'tommcdo/vim-exchange'
Plug 'leafgarland/typescript-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'alvan/vim-closetag'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'KabbAmine/zeavim.vim'
" Plug 'dyng/ctrlsf.vim'
" Plug 'heavenshell/vim-jsdoc.git'
" Plug 'jbgutierrez/vim-better-comments'

call plug#end()

" Zeavim
" nmap <leader>z <Plug>Zeavim
" vmap <leader>z <Plug>ZVVisSelection

" QuickScope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars = 160
highlight QuickScopePrimary guifg='#f1ede4' gui=underline
highlight QuickScopeSecondary guifg='#94918a' gui=underline

" ultisnips
let g:UltiSnipsExpandTrigger = '<leader><tab>'


" -----------------------------------------------------------------------------


" localvimrc
let g:localvimrc_name = '_lvimrc'
let g:localvimrc_count = 1
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0

" BufOnly
nnoremap <c-F4> :BufOnly<cr>

" undotree
cabbrev UT UndotreeToggle

" EasyMotion
let g:EasyMotion_leader_key = '<Leader>'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

" vim-closetag
let g:closetag_filetypes = 'html,php,vue'

" tcomment
nmap <leader>c <c-_><c-_>
vmap <leader>c <c-_><c-_>
" imap <leader>c <c-o><c-_><c-_>

" sideways
noremap <c-h> :SidewaysLeft<cr>
noremap <c-l> :SidewaysRight<cr>

" ctrlp
let g:ctrlp_map = '<space>'
let g:ctrlp_show_hidden = 1
let g:ctrlp_open_multiple_files = 'i'
let g:ctrlp_by_filename = 1
let g:ctrlp_match_current_file = 0
let g:ctrlp_custom_ignore = {
			\ 'dir': '\v[\/](\..+)$',
			\ 'file': '\v[\/](.+\.min\.(css|js))$'
			\ }
let g:user_command_async = 1
let g:ctrlp_search_options = '-g "!*.jpg" -g "!*.png" -g "!*.gif" -g "!*.psd" -g "!*.ai" -g "!node_modules" -g "!__pycache__" -g "!venv"' " search options for ripgrep to reuse in other vimrc
let g:ctrlp_user_command = {
			\ 'types': {
				\ 1: ['.git', 'cd %s && git ls-files | rg --files --color=never ' . g:ctrlp_search_options],
			\ },
			\ 'fallback': 'rg %s --files --color=never ' . g:ctrlp_search_options
			\ }
nnoremap gt :CtrlPBufTag<cr>
nnoremap gT :CtrlPBufTagAll<cr>
nnoremap gb :CtrlPBuffer<cr>
nnoremap g/ :CtrlPLine<cr>
nnoremap gm :CtrlPMRU<cr>
" use exuberant ctags because universal ctags isn't supported
let g:ctrlp_buftag_ctags_bin = 'ectags.exe'
" gotags doesn't work now
let g:ctrlp_buftag_types = {
\ 'go'         : '--language-force=go --golang-types=ftv',
\ }
" let g:ctrlp_user_command = 'rg %s --files --color=never'



" echodoc
set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'



" coc
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=500
" don't give |ins-completion-menu| messages.
set shortmess+=c
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if &filetype == 'vim'
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)
" Remap for format selected region
nmap g= :call CocAction('format')<cr>
augroup CocGroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json,vue setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap ga <Plug>(coc-codeaction-selected)
nmap ga <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif



" Tagbar
cabbrev TT TagbarToggle
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
" go get -u github.com/jstemmer/gotags
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" ale
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 0
let g:ale_open_list = 'on_save' " auto open and close location list on save
let g:ale_list_window_size = 5
" let g:ale_fix_on_save = 1
let g:ale_fixers = {
	\ 'javascript': ['eslint'],
	\ 'python': ['isort'],
\}
let g:ale_linters = {
	\ 'javascript': ['tsserver'],
	\ 'css': ['stylelint'],
	\ 'python': ['mypy'],
\}
let g:ale_python_pyls_executable = 'C:/Python36/Scripts/pyls'
function! SetALEShortcuts()
	" nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
	" nnoremap <buffer> <silent> gd :ALEGoToDefinition<CR>
	nnoremap <buffer> <silent> gf :ALEFix<CR>
	" nnoremap <buffer> <silent> <f3> :ALEFindReferences<CR>
	nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
	" nnoremap <buffer> <silent> <leader>= :call LanguageClient#textDocument_formatting()<CR>
endfunction()
augroup ALE
  autocmd!
  autocmd FileType javascript,html,css,scss,python,go call SetALEShortcuts()
augroup END
" npm install -g javascript-typescript-langserver vscode-html-languageserver-bin stylelint 
" pip install python-language-server rope mypy flake8 isort



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
" For third party colorschemes
" hi MBENormal guifg=fg gui=none
" hi MBEChanged guifg=fg gui=italic
" hi link MBEVisibleNormal MBENormal
" hi link MBEVisibleChanged MBEChanged
" hi MBEVisibleActiveNormal gui=bold
" hi MBEVisibleActiveChanged gui=bold,italic

" airline
let g:airline#extensions#branch#enabled = 0
let g:airline_detect_paste = 0
let g:airline_detect_crypt = 0
let g:airline_extensions = ['quickfix', 'ctrlp', 'whitespace', 'ale']
let g:airline_theme = 'bubblegum'
" let g:airline_powerline_fonts = 1
" set guifont=Hack:h9



" vue
let g:vue_disable_pre_processors=1



" Emmet
let g:user_emmet_leader_key = '<c-y>'
let g:user_emmet_expandabbr_key = '<c-e>'
" let g:user_emmet_expandword_key = '<c-e>'
let g:user_emmet_complete_tag = 1



" ----- ----- ----- -----
" Others
" ----- ----- ----- -----

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
