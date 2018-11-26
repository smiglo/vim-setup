if exists("b:current_syntax")
  finish
endif

syn match entryKeyword   /\<INFO:\|\<TODO:\|\<ERR\>\|\<FAIL\>\|\<OK\>/
syn match entryKeyword2  /???/
syn match entryFile      /^[A-Za-z0-9_/~%\-\.]\+:\%(\d\+\)\{0,1\}[:-]/  contains=entryLine
syn match entryLine      /\d\+[:-]/                                     contained
syn match entryDate      /\<\%([1-2][0-9]\{3\}\)\%(0[1-9]\|1[0-2]\)\%(0[1-9]\|[1-2][0-9]\|3[0-1]\)\%(-\%([0-1][0-9]\|2[0-3]\)\%([0-5][0-9]\)\{2\}\)\{0,1\}\>\|[A-Za-z]\{3\} \d\+ \d\d:\d\d:\d\d\|\d\{4\}-\d\d-\d\d \d\d:\d\d:\d\d/
syn match entryIssue     /\[[A-Z][A-Z0-9]\{2,\}-[1-9][0-9]\{2,\}\]\|[A-Z][A-Z0-9]\{2,\}-[1-9][0-9]\{2,\}:\|\<[A-Z][A-Z0-9]\{2,\}-[1-9][0-9]\{2,\}\>/
syn match logMy          /\<TB] .*/                 contains=logMyInfo,logMyFunc,logMyErr,logMyImp
syn match logMyInfo      /\<II\>/                   skipwhite contained
syn match logMyFunc      /\<BB\>\|\<AA\>\|\<TT\>/   skipwhite contained
syn match logMyErr       /\<EE\>\|\<FF\>/           skipwhite contained
syn match logMyImp       /\<IMP\>/                  skipwhite

hi def link entryFile       Statement
hi def link entryLine       Comment
hi def link entryDate       Type
hi def link entryIssue      Identifier
hi def link entryKeyword    Todo
hi def link entryKeyword2   Todo
hi def link logMyInfo       ModeMsg
hi def link logMyFunc       Function
hi def link logMyErr        Error
hi def link logMyImp        WildMenu

let b:current_syntax="defaultSyntax"

set nowrap

