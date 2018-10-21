" Maintainer:  Henrique C. Alves (hcarvalhoalves@gmail.com)
" Version:      1.0
" Last Change:  September 25 2008

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "mustang"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine   guifg=#ffffff guibg=#005f5f            ctermfg=231 ctermbg=23  cterm=none
  hi CursorColumn guifg=#ffffff guibg=#005f5f            ctermfg=231 ctermbg=23  cterm=none
  hi MatchParen   guifg=#ffd700 guibg=black   gui=bold   ctermfg=220 ctermbg=235 cterm=bold
  hi Pmenu        guifg=#ffffff guibg=#444444            ctermfg=255 ctermbg=238
  hi PmenuSel     guifg=#000000 guibg=#b1d631            ctermfg=0   ctermbg=148
endif

hi logMy          guifg=Red                   gui=none   ctermfg=82

" General colors
hi Cursor         guifg=NONE    guibg=#626262 gui=none               ctermbg=241
hi Normal         guifg=#e2e2e5 guibg=black   gui=none   ctermfg=253 ctermbg=black
hi NonText        guifg=#808080 guibg=black   gui=none   ctermfg=244 ctermbg=black
hi LineNr         guifg=#808080 guibg=#000000 gui=none   ctermfg=244 ctermbg=233
hi CursorLineNr   guifg=yellow  guibg=#000000 gui=none   ctermfg=220 ctermbg=233
hi StatusLine     guifg=#f5ea4e guibg=#444444 gui=none   ctermfg=24  ctermbg=15  term=reverse
hi StatusLineNC   guifg=#939395 guibg=#444444 gui=none   ctermfg=242 ctermbg=238
hi StatusLineMark guifg=#d3d3d5 guibg=#444444 gui=none   ctermfg=15  ctermbg=9   term=reverse cterm=bold
hi StatusLineLoc  guifg=#d3d3d5 guibg=#444444 gui=none   ctermfg=15  ctermbg=240 term=reverse
hi TabLine        guifg=#f5ea4e guibg=#444444 gui=none   ctermfg=15  ctermbg=24  cterm=NONE
hi TabLineFill    guifg=#f5ea4e guibg=#444444 gui=none   ctermfg=15  ctermbg=24  cterm=NONE
hi TabLineSel     guifg=#d3d3d5 guibg=#444444 gui=none   ctermfg=15  ctermbg=240 cterm=NONE
hi TabLineLast    guifg=#f5ea4e guibg=#444444 gui=none   ctermfg=15  ctermbg=24  cterm=underline
hi VertSplit      guifg=#444444 guibg=#444444 gui=none   ctermfg=238 ctermbg=238
hi Folded         guifg=#a0a8b0 guibg=#384048 gui=none   ctermfg=130 ctermbg=0
hi FoldColumn     guifg=#a0a8b0 guibg=black   gui=none   ctermfg=130 ctermbg=233
hi Title          guifg=#f6f3e8 guibg=NONE    gui=bold   ctermfg=254             cterm=bold
hi Visual         guifg=black   guibg=#ffd700 gui=none   ctermfg=0   ctermbg=220
hi SpecialKey     guifg=#808080 guibg=#343434 gui=none   ctermfg=244 ctermbg=235
hi Search         guifg=black   guibg=#ffd700            ctermfg=220 ctermbg=24  cterm=bold
hi IncSearch      guifg=black   guibg=#ccac00            ctermfg=220 ctermbg=238 cterm=NONE
hi _m1            guifg=#ffff00 guibg=#005f00 gui=none   ctermfg=226 ctermbg=22  cterm=NONE
hi _m2            guifg=#ffff00 guibg=#870000 gui=none   ctermfg=226 ctermbg=88  cterm=NONE

" Syntax highlighting
hi Comment        guifg=#808080               gui=italic ctermfg=244
hi Todo           guifg=#8f8f8f guibg=#e6ea50 gui=italic ctermfg=234 ctermbg=208 cterm=bold
hi Boolean        guifg=#b1d631               gui=none   ctermfg=148
hi String         guifg=#b1d631               gui=italic ctermfg=138
hi Identifier     guifg=#b1d631               gui=none   ctermfg=148
hi Function       guifg=#ffffff               gui=bold   ctermfg=2
hi Type           guifg=#7e8aa2               gui=none   ctermfg=103
hi Statement      guifg=#7e8aa2               gui=none   ctermfg=103
hi Keyword        guifg=#ff9800               gui=none   ctermfg=192
hi Constant       guifg=#ff9800               gui=none   ctermfg=208
hi Number         guifg=#ff9800               gui=none   ctermfg=203
hi Special        guifg=#ff9800               gui=none   ctermfg=220
hi PreProc        guifg=#faf4c6               gui=none   ctermfg=230

" Code-specific colors
hi pythonOperator guifg=#7e8aa2               gui=none   ctermfg=103

" Diff colors
hi DiffAdd        guifg=#F5EA4E guibg=#0A8F4C gui=none   ctermfg=14  ctermbg=black cterm=bold
hi DiffDelete     guifg=#F5EA4E guibg=#A85D5D gui=none   ctermfg=9   ctermbg=black cterm=bold
hi DiffChange     guifg=#F5EA4E guibg=#4F678F gui=none   ctermfg=10  ctermbg=black cterm=bold
hi DiffText       guifg=#F5EA4E guibg=#AA0000 gui=none   ctermfg=231 ctermbg=88    cterm=bold

" vim-signature
hi SignColumn     guifg=#808080 guibg=#000000 gui=none   ctermfg=244 ctermbg=233

