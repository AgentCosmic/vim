" Vim color file
" Author: Dalton Tan <daltonyi@hotmail.com>

" auto reload colorscheme when saving this file
augroup DistinctColorscheme
	autocmd!
	autocmd BufWritePost distinct.vim colorscheme distinct
augroup end

set background=dark
hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'distinct'

function! s:h(group, style, ...)
	execute 'highlight' a:group
		\ 'guifg='   (has_key(a:style, 'fg')    ? a:style.fg   : 'NONE')
		\ 'guibg='   (has_key(a:style, 'bg')    ? a:style.bg   : 'NONE')
		\ 'guisp='   (has_key(a:style, 'sp')    ? a:style.sp   : 'NONE')
		\ 'gui='     (has_key(a:style, 'gui')   ? a:style.gui  : 'NONE')
		\ 'cterm='   (has_key(a:style, 'cterm') ? a:style.cterm: 'NONE')
endfunction

let s:orange = '#e0c287'
let s:green = '#add699'
let s:blue = '#98cfeb'
let s:purple = '#c7bcff'
let s:red = '#ffacac'
let s:highlight = '#182c57'
let s:fg0 = '#e2e2e2' " 90
let s:fg1 = '#c7c7c7' " 80
let s:fg2 = '#ababab' " 70
let s:fg3 = '#919191' " 60
let s:bg3 = '#2e2e2e' " 20
let s:bg2 = '#212121' " 15
let s:bg1 = '#161616' " 10
let s:bg0 = '#0a0a0a' " 05

" Syntax Groups (descriptions and ordering from `:h w18`)

call s:h('Comment', {'fg': s:fg3})
call s:h('Constant', {'fg': s:orange})
call s:h('String', {'fg': s:orange})
call s:h('Character', {'fg': s:orange})
call s:h('Number', {'fg': s:orange})
call s:h('Boolean', {'fg': s:orange})
call s:h('Float', {'fg': s:orange})

call s:h("Identifier", { "fg": s:blue })
call s:h('Function', {'fg': s:blue})

call s:h('Statement', {'fg': s:green})
call s:h('Conditional', {'fg': s:green})
call s:h('Repeat', {'fg': s:green})
call s:h('Label', {'fg': s:green, 'gui': 'none'})
call s:h('Operator', {'fg': s:green})
call s:h('Keyword', {'fg': s:green})
call s:h('Exception', {'fg': s:purple})

call s:h('PreProc', {'fg': s:purple})
call s:h('Include', {'fg': s:purple})
call s:h('Define', {'fg': s:purple})
call s:h('Macro', {'fg': s:purple, 'gui': 'italic'})
call s:h('PreCondit', {'fg': s:purple})

call s:h('Type', {'fg': s:blue, 'gui': 'none'})
call s:h('StorageClass', {'fg': s:blue, 'gui': 'none'})
call s:h('Structure', {'fg': s:blue})
call s:h('Typedef', {'fg': s:blue})

call s:h('Special', {'fg': s:purple})
call s:h('SpecialChar', {'fg': s:purple})
call s:h('Tag', {'fg': s:green, 'gui': 'italic'})
call s:h('Delimiter', {'fg': s:orange})
call s:h('SpecialComment', {'fg': s:fg2, 'gui': 'italic'})
call s:h('Debug', {'fg': s:purple})

call s:h('Underlined', {'fg': s:fg3, 'gui': 'underline'})
call s:h('Ignore', {'fg': s:fg3, 'bg': 'bg'})
call s:h('Error', {'fg': s:red, 'bg': 'NONE', 'sp': s:red})
call s:h('Todo', {'fg': s:fg1, 'gui': 'bold,italic'})

" Highlighting Groups (descriptions and ordering from `:h highlight-groups`)

call s:h('ColorColumn', {'bg': s:bg0})
call s:h('Conceal', {'bg': 'bg', 'fg': s:bg3})
call s:h('Cursor', {'fg': s:bg1, 'bg': s:fg1})
call s:h('CursorColumn', {'bg': s:bg2})
call s:h('CursorLine', {'bg': s:bg2})
call s:h('Directory', {'fg': s:orange})
call s:h('DiffAdd', {'fg': s:blue, 'bg': s:bg3})
call s:h('DiffChange', {'fg': s:orange, 'bg': s:bg3})
call s:h('DiffDelete', {'fg': s:red, 'bg': s:bg3})
call s:h('DiffText', {'bg': s:bg3, 'gui': 'italic,bold'})
call s:h('EndOfBuffer', {'fg': s:fg3, 'bg': 'NONE'})
call s:h('ErrorMsg', {'fg': s:red, 'bg': 'NONE', 'sp': s:red})
call s:h('VertSplit', {'fg': s:bg3, 'bg': s:bg1})
call s:h('Folded', {'fg': s:fg3, 'bg': s:bg0})
call s:h('FoldColumn', {'fg': s:fg3, 'bg': s:bg0})
call s:h('SignColumn', {'fg': s:purple, 'bg': 'bg'})
call s:h('IncSearch', {'fg': s:bg1, 'bg': s:orange})
call s:h('Substitute', {'fg': s:orange, 'bg': s:bg1})
call s:h('LineNr', {'fg': s:fg3})
call s:h('CursorLineNr', {'fg': s:fg3})
call s:h('MatchParen', {'fg': s:bg1, 'bg': s:green})
call s:h('ModeMsg', {'fg': s:orange})
call s:h('MsgArea', {'fg': s:fg1})
call s:h('MsgSeparator', {'fg': s:orange})
call s:h('MoreMsg', {'fg': s:orange})
call s:h('NonText', {'fg': s:fg3})
call s:h('Normal', {'fg': s:fg1, 'bg': s:bg1})
call s:h('NormalFloat', {'fg': s:fg1, 'bg': s:bg1})
call s:h('FloatBorder', {'fg': s:fg3, 'bg': s:bg1})
call s:h('Pmenu', {'fg': s:fg1, 'bg': s:bg3})
call s:h('PmenuSel', {'fg': s:bg1, 'bg': s:green})
call s:h('PmenuSbar', {'bg': s:bg3})
call s:h('PmenuThumb', {'bg': s:fg3})
call s:h('Question', {'fg': s:orange})
call s:h('QuickFixLine', {'bg': s:bg3, 'gui': 'bold'})
call s:h('Search', {'fg': s:fg0, 'bg': s:highlight})
call s:h('SpecialKey', {'fg': s:fg3, 'gui': 'italic'})
call s:h('SpellBad', {'fg': s:red, 'gui': 'undercurl', 'sp': s:red})
call s:h('SpellCap', {'fg': s:orange, 'gui': 'undercurl', 'sp': s:orange})
call s:h('SpellLocal', {'fg': s:orange, 'gui': 'undercurl', 'sp': s:orange})
call s:h('SpellRare', {'fg': s:orange, 'gui': 'undercurl', 'sp': s:orange})
call s:h('StatusLine', {'fg': s:fg1, 'bg': s:bg2})
call s:h('StatusLineNC', {'fg': s:fg3, 'bg': s:bg0})
call s:h('TabLine', {'fg': s:fg3, 'bg': s:bg0})
call s:h('TabLineFill', {'fg': s:fg3, 'bg': s:bg0})
call s:h('TabLineSel', {'fg': s:fg0, 'bg': s:bg1})
call s:h('Title', {'fg': s:purple})
call s:h('Visual', {'bg': s:bg3})
call s:h('VisualNOS', {'bg': s:bg3})
call s:h('WarningMsg', {'fg': s:orange})
call s:h('Whitespace', {'fg': s:bg3})
call s:h('WildMenu', {'fg': s:bg1, 'bg': s:green})

" ------------------------------------------------------------------------------

" languages

hi link cssProp Statement
hi link cssAtRule Type
hi link cssPseudoClassId Type
hi link jsxAttrib Statement

" buftabline

hi link BufTabLineActive TabLineSel
call s:h('BufTabLineModifiedCurrent', {'fg': s:orange})
call s:h('BufTabLineHidden', {'fg': s:fg3, 'bg': s:bg1})
call s:h('BufTabLineModifiedHidden', {'fg': s:orange})
