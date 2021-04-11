if exists("b:current_syntax")
  finish
endif

runtime!  syntax/syntax-common.vim

syn match logKeyword       /\<INFO:\|\<ERR\>\|\<FAIL\>\|\<OK\>/
syn match logTime          /\<\%([1-2]\d\{3\}\)\%(0[1-9]\|1[0-2]\)\%(0[1-9]\|[1-2]\d\|3[0-1]\)\%(-\%([0-1]\d\|2[0-3]\)\%([0-5]\d\)\{2\}\)\?\>/
syn match logTime          /\<\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)\>\s+\d\+ \d\d:\d\d:\d\d/
syn match logTime          /\[\?\<\d\{4\}-\d\d-\d\d\>\%( \d\d:\d\d:\d\d\)\?\]\?/
syn match logTime          /\<\%(\d\+-\)\?\d\{1,2\}:\d\d:\d\d[:.]\d\+\>/
syn match logTime          /\.\d\{6,\}\>/

syn match logIssueLine     /\(\[[A-Z][A-Z0-9]\{1,\}-\d\{3,\}\]\|\<[A-Z][A-Z0-9]\{2,\}-\d\{3,\}\>\)\((https\?:\/\/[^)]*)\)\?\(: .*$\)\?/ contains=logIssue,logIssueLink,logIssueDescrF
syn match logIssue         /\(\[[A-Z][A-Z0-9]\{1,\}-\d\{3,\}\]\|\<[A-Z][A-Z0-9]\{2,\}-\d\{3,\}\>\)/           contained
syn match logIssueLink     /(https\?:\/\/[^)]*)/                                                              contained
syn match logIssueDescrF   /: .*/                                                                             contained contains=logIssueDescr
syn match logIssueDescr    /[^:][^ ].*/                                                                       contained

hi! def link logTime        Type
hi! def link logIssue       Question
hi! def link logIssueLink   Comment
hi! def link logIssueDescr  WarningMsg

let b:current_syntax="defaultSyntax"

set nowrap

