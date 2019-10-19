if exists("b:current_syntax")
  finish
endif

source ~/.vim/syntax/syntax-common.vim

syn match logKeyword       /\<INFO:\|\<TODO:\|\<ERR\>\|\<FAIL\>\|\<OK\>/
syn match logKeyword2      /???/
syn match logTime          /\<\%([1-2]\d\{3\}\)\%(0[1-9]\|1[0-2]\)\%(0[1-9]\|[1-2]\d\|3[0-1]\)\%(-\%([0-1]\d\|2[0-3]\)\%([0-5]\d\)\{2\}\)\?\>/
syn match logTime          /\<\(Jan\|Feb\|Mar\|Apr\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)\> \d\+ \d\d:\d\d:\d\d/
syn match logTime          /\[\?\<\d\{4\}-\d\d-\d\d\>\%( \d\d:\d\d:\d\d\)\?\]\?/
syn match logTime          /\<\%(\d\+-\)\?\d\{1,2\}:\d\d:\d\d[:.]\d\+\>/
syn match logTime          /\.\d\{6,\}\>/
syn match logIssue         /\[[A-Z][A-Z0-9]\{2,\}-[1-9]\d\{2,\}\]\|[A-Z][A-Z0-9]\{2,\}-[1-9]\d\{2,\}:\|\<[A-Z][A-Z0-9]\{2,\}-[1-9]\d\{2,\}\>/
syn match logComment       /^#.*/                         contains=logMy
syn match logComment       /\(\/\/\)\|\(##\) .*\<TB].*/   contains=logMy
syn match logComment       /\(\/\/\/\)\|\(###\).*/

hi! def link logComment     Comment
hi! def link logTime        Type
hi! def link logIssue       Constant
hi! def link logKeyword     Todo
hi! def link logKeyword2    Todo

let b:current_syntax="defaultSyntax"

set nowrap

