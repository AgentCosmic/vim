" https://github.com/BurntSushi/ripgrep/releases
call plug#begin('$HOME/plugged')
" Universal Vim Functionality
Plug 'duff/vim-bufonly'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'itchyny/vim-cursorword'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-abolish'
Plug 'unblevable/quick-scope'
" Programming Related
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " so vim-surround can repeat with dot command
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'sickill/vim-pasta'
Plug 'AndrewRadev/sideways.vim'
Plug 'wellle/targets.vim'
Plug 'nathanaelkane/vim-indent-guides', {'on': ['IndentGuidesEnable', 'IndentGuidesToggle']}
Plug 'michaeljsmith/vim-indent-object'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'ervandew/supertab'
" Language
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
" GUI
Plug 'fholgado/minibufexpl.vim'
Plug 'ap/vim-css-color'
" External Dependency
Plug 'dyng/ctrlsf.vim'
Plug 'ctrlpvim/ctrlp.vim' " https://github.com/BurntSushi/ripgrep/releases
call plug#end()

" -----------------------------------------------------------------------------

" BufOnly
nnoremap <c-F4> :BufOnly<cr>

" undotree
cabbrev UT UndotreeToggle

" EasyMotion
let g:EasyMotion_leader_key = '<Leader>'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

" vim-closetag
let g:closetag_filetypes = 'html,php,vue'

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars = 160
highlight QuickScopePrimary guifg='#f1ede4' gui=underline
highlight QuickScopeSecondary guifg='#94918a' gui=underline

" tcomment
nmap <leader>c <c-_><c-_>
vmap <leader>c <c-_><c-_>
" imap <leader>c <c-o><c-_><c-_>

" sideways
noremap <c-h> :SidewaysLeft<cr>
noremap <c-l> :SidewaysRight<cr>

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

" CtrlSF
let g:ctrlsf_ackprg = 'rg'

" ctrlp
let g:ctrlp_map = '\'
let g:ctrlp_show_hidden = 1
let g:ctrlp_open_multiple_files = 'i'
let g:ctrlp_by_filename = 1
let g:ctrlp_match_current_file = 0
let g:ctrlp_custom_ignore = {
			\ 'dir': '\v[\/](\..+|node_modules|__pycache__)$',
			\ 'file': '\v[\/](.+\.min\.(css|js))$'
			\ }
let g:user_command_async = 1
let g:ctrlp_search_options = '-g "!*.jpg" -g "!*.png" -g "!*.gif" -g "!*.psd" -g "!*.ai" -g "!node_modules" -g "!__pycache__" -g "!venv"' " search options for ripgrep to reuse in other vimrc
let g:ctrlp_user_command = {
			\ 'types': {
				\ 1: ['.git', 'cd %s && git ls-files -- . ":!:*.jpg" . ":!:*.png" . ":!:*.psd" . ":!:*.ai"'],
			\ },
			\ 'fallback': 'rg %s --files --color=never ' . g:ctrlp_search_options
			\ }
nnoremap gb :CtrlPBuffer<cr>
nnoremap g/ :CtrlPLine<cr>
nnoremap gm :CtrlPMRU<cr>
" nnoremap gt :CtrlPTag<cr>
let g:ctrlp_buftag_ctags_bin = 'ctags.exe'
" let g:ctrlp_user_command = 'rg %s --files --color=never'



" Emmet
let g:user_emmet_leader_key = '<c-y>'
let g:user_emmet_expandabbr_key = '<c-e>'
" let g:user_emmet_expandword_key = '<c-e>'
" let g:user_emmet_complete_tag = 1



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
" For third party colorschemes
" hi MBENormal guifg=fg gui=none
" hi MBEChanged guifg=fg gui=italic
" hi link MBEVisibleNormal MBENormal
" hi link MBEVisibleChanged MBEChanged
" hi MBEVisibleActiveNormal gui=bold
" hi MBEVisibleActiveChanged gui=bold,italic
