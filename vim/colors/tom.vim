" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Ron Aaron <ron@ronware.org>
" Last Change:	2003 May 02

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "tom"
hi Normal		guifg=#C0C0C0	guibg=black
hi CursorLine 	guibg=Red	ctermbg=236 cterm=bold term=bold
hi NonText		guifg=brown
hi comment		guifg=green
hi constant		guifg=cyan	gui=NONE
hi identifier	guifg=cyan	gui=NONE
hi statement	guifg=lightblue	gui=NONE
hi preproc		guifg=Pink2 ctermfg=green
hi type			guifg=seagreen	gui=NONE
hi special		guifg=yellow
hi ErrorMsg		guifg=Black	guibg=Red
hi WarningMsg	guifg=Black	guibg=Green
hi Error		guibg=Red
hi Todo			guifg=Black	guibg=orange
hi Cursor		guibg=#60a060 guifg=#00ff00
hi Search		guibg=lightslateblue
hi IncSearch	gui=NONE guibg=steelblue
hi LineNr		guifg=darkgrey
hi title		guifg=darkgrey
hi StatusLineNC	gui=NONE guifg=lightblue guibg=darkblue
hi StatusLine	gui=NONE	guifg=cyan	guibg=blue
hi label		guifg=gold2
hi operator		guifg=orange
hi clear Visual
hi Visual		term=reverse cterm=reverse gui=reverse
hi DiffChange   guibg=darkgreen
hi DiffText		guibg=olivedrab
hi DiffAdd		guibg=slateblue
hi DiffDelete   guibg=coral
hi Folded		guibg=gray30
hi FoldColumn	guibg=gray30 guifg=white
hi cIf0			guifg=gray

" Diff colors
hi DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=#F5EA4E guibg=#0A8F4C
hi DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=#F5EA4E guibg=#A85D5D
hi DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=#F5EA4E guibg=#4F678F
hi DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=#F5EA4E guibg=#AA0000

