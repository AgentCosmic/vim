call plug#begin('$HOME/plugged')
" Universal Vim Functionality
Plug 'duff/vim-bufonly'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'itchyny/vim-cursorword'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-abolish'
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
" Programming Related
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " so vim-surround can repeat with dot command
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'AndrewRadev/sideways.vim'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'alvan/vim-closetag'
" GUI
Plug 'fholgado/minibufexpl.vim'
Plug 'ap/vim-css-color'
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
let g:closetag_filetypes = 'html,jsx,tsx,,php,vue'

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
let g:ctrlp_user_command = {
			\ 'types': {
				\ 1: ['.git', 'cd %s && git ls-files -- . ":!:*.jpg" . ":!:*.png" . ":!:*.psd" . ":!:*.ai"'],
			\ },
			\ }
nnoremap gb :CtrlPBuffer<cr>
nnoremap g/ :CtrlPLine<cr>
nnoremap gh :CtrlPMRU<cr>



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
