if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab

" don't remove indent when commenting
inoremap <buffer> # <left><right>#
