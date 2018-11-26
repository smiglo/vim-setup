" Code based off ehamberg/vim-cute-python.

" Fallback if the conceal feature is unsupported.
if !has('conceal')
    finish
endif

" Operators
syntax match rsCuteOperator "||" conceal cchar=∨
syntax match rsCuteOperator "&&" conceal cchar=∧
syntax match rsCuteOperator "\!" conceal cchar=¬
syntax match rsCuteOperator "<=" conceal cchar=≤
syntax match rsCuteOperator ">=" conceal cchar=≥
syntax match rsCuteOperator "->" conceal cchar=→
syntax match rsCuteOperator "=>" conceal cchar=⇒
syntax match rsCuteOperator "\^" conceal cchar=⊕
" Only conceal “==” if alone, to avoid concealing SCM conflict markers.
syntax match rsCuteOperator "=\@<!===\@!" conceal cchar=≟
syntax match rsCuteOperator "!=" conceal cchar=≠

hi link rsCuteOperator Operator

setlocal conceallevel=2

