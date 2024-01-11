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
let s:green = '#a7d192'
let s:blue = '#98cfeb'
let s:purple = '#cabfff'
let s:red = '#ffb0b0'
let s:highlight = '#213a6e'
let s:grey95 = '#f1f1f1' " white
let s:grey85 = '#d4d4d4' " fg
let s:grey75 = '#b9b9b9' " inactive tab
let s:grey65 = '#9e9e9e' " comment
let s:grey25 = '#3b3b3b' " Visual
let s:grey20 = '#303030' " CursorLine
let s:grey15 = '#262626' " bg
let s:grey10 = '#1b1b1b' " column
let s:grey05 = '#121212' " black

" Syntax Groups (descriptions and ordering from `:h w18`)

call s:h('Comment', {'fg': s:grey65})
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
call s:h('SpecialComment', {'fg': s:grey85})
call s:h('Debug', {'fg': s:purple})

call s:h('Underlined', {'fg': s:grey65, 'gui': 'underline'})
call s:h('Ignore', {'fg': s:grey65, 'bg': 'bg'})
call s:h('Error', {'fg': s:red, 'bg': 'NONE', 'sp': s:red})
call s:h('Todo', {'fg': s:grey95, 'gui': 'bold,italic'})

" Highlighting Groups (descriptions and ordering from `:h highlight-groups`)

call s:h('ColorColumn', {'bg': s:grey10})
call s:h('Conceal', {'bg': 'bg', 'fg': s:grey25})
call s:h('Cursor', {'fg': s:grey15, 'bg': s:grey85})
call s:h('CursorColumn', {'bg': s:grey20})
call s:h('CursorLine', {'bg': s:grey20})
call s:h('Directory', {'fg': s:orange})
call s:h('DiffAdd', {'fg': s:blue, 'bg': s:grey25})
call s:h('DiffChange', {'fg': s:orange, 'bg': s:grey25})
call s:h('DiffDelete', {'fg': s:red, 'bg': 'NONE'})
call s:h('DiffText', {'bg': s:grey25, 'gui': 'italic,bold'})
call s:h('EndOfBuffer', {'fg': s:grey65, 'bg': 'NONE'})
call s:h('ErrorMsg', {'fg': s:red, 'bg': 'NONE', 'sp': s:red})
call s:h('VertSplit', {'fg': s:grey25, 'bg': s:grey15})
call s:h('Folded', {'fg': s:grey65, 'bg': s:grey05})
call s:h('FoldColumn', {'fg': s:grey65, 'bg': s:grey05})
call s:h('SignColumn', {'fg': s:purple, 'bg': 'bg'})
call s:h('IncSearch', {'fg': s:grey15, 'bg': s:orange})
call s:h('Substitute', {'fg': s:orange, 'bg': s:grey15})
call s:h('LineNr', {'fg': s:grey65})
call s:h('CursorLineNr', {'fg': s:grey65})
call s:h('MatchParen', {'fg': s:grey15, 'bg': s:green})
call s:h('ModeMsg', {'fg': s:orange})
call s:h('MsgArea', {'fg': s:grey85})
call s:h('MsgSeparator', {'fg': s:orange})
call s:h('MoreMsg', {'fg': s:orange})
call s:h('NonText', {'fg': s:grey65})
call s:h('Normal', {'fg': s:grey85, 'bg': s:grey15})
call s:h('NormalFloat', {'fg': s:grey85, 'bg': s:grey20})
call s:h('FloatBorder', {'fg': s:grey65, 'bg': s:grey20})
call s:h('Pmenu', {'fg': s:grey85, 'bg': s:grey25})
call s:h('PmenuSel', {'fg': s:grey15, 'bg': s:green})
call s:h('PmenuSbar', {'bg': s:grey95})
call s:h('PmenuThumb', {'fg': s:green})
call s:h('Question', {'fg': s:orange})
call s:h('QuickFixLine', {'bg': s:grey25, 'gui': 'bold'})
call s:h('Search', {'fg': s:grey95, 'bg': s:highlight, 'gui': 'bold'})
call s:h('SpecialKey', {'fg': s:grey65, 'gui': 'italic'})
call s:h('SpellBad', {'fg': s:red, 'gui': 'undercurl', 'sp': s:red})
call s:h('SpellCap', {'fg': s:orange, 'gui': 'undercurl', 'sp': s:orange})
call s:h('SpellLocal', {'fg': s:orange, 'gui': 'undercurl', 'sp': s:orange})
call s:h('SpellRare', {'fg': s:orange, 'gui': 'undercurl', 'sp': s:orange})
call s:h('StatusLine', {'fg': s:grey85, 'bg': s:grey20})
call s:h('StatusLineNC', {'fg': s:grey65, 'bg': s:grey10})
call s:h('TabLine', {'fg': s:grey85, 'bg': s:grey05})
call s:h('TabLineFill', {'fg': s:grey85, 'bg': s:grey05})
call s:h('TabLineSel', {'fg': s:grey85, 'bg': s:grey15})
call s:h('Title', {'fg': s:purple})
call s:h('Visual', {'bg': s:grey25})
call s:h('VisualNOS', {'bg': s:grey25})
call s:h('WarningMsg', {'fg': s:orange})
call s:h('Whitespace', {'fg': s:grey25})
call s:h('WildMenu', {'fg': s:grey15, 'bg': s:green})

" ------------------------------------------------------------------------------

" languages

hi link cssProp Statement
hi link cssAtRule Type
hi link cssPseudoClassId Type
hi link jsxAttrib Statement

" buftabline

hi link BufTabLineActive TabLineSel
call s:h('BufTabLineModifiedCurrent', {'fg': s:orange})
call s:h('BufTabLineHidden', {'fg': s:grey65, 'bg': s:grey05})
call s:h('BufTabLineModifiedHidden', {'fg': s:orange})
