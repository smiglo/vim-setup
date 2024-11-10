if exists("b:current_syntax")
  finish
endif

runtime!  syntax/syntax-common.vim

syn match logKeyword       /\<INFO:\|\<INFO\>\|\<ERROR\>\|\<ERR\>\|\<WARNING\>\|\<WRN\>\|\<DEBUG\>\|\<DBG\>\|\<TRACE\>\|\<FAIL\>\|\<OK\>/
syn match logTime          /\<\%([1-2]\d\{3\}\)\%(0[1-9]\|1[0-2]\)\%(0[1-9]\|[1-2]\d\|3[0-1]\)\%(-\%([0-1]\d\|2[0-3]\)\%([0-5]\d\)\{2\}\)\?\>/
syn match logTime          /\<\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)\>\s+\d\+ \d\d:\d\d:\d\d/
syn match logTime          /\[\?\<\d\{4\}-\d\d-\d\d\>\%( \d\d:\d\d:\d\d\)\?\]\?/
syn match logTime          /\.\d\{6,\}\>/ conceal cchar=.
syn match logTime          /\[\s*\d\+\.\d\{6\}\]/

syn match logIssueLine     /\(\[[A-Z][A-Z0-9]\{1,\}-\d\{3,\}\]\|\<[A-Z][A-Z0-9]\{2,\}-\d\{3,\}\>\)\( \?(https\?:\/\/[^)]*)\)\?\(:\? [^\.]*\)$\?/ contains=logIssue,logIssueLink,logIssueDescrF,logIssueAuthor
syn match logIssue         /\(\[[A-Z][A-Z0-9]\{1,\}-\d\{3,\}\]\|\<[A-Z][A-Z0-9]\{2,\}-\d\{3,\}\>\)/           contained
syn match logIssueLink     / \?(https\?:\/\/[^)]*)/                                                           contained conceal
syn match logIssueDescrF   /:\? [^.]*$/                                                                       contained contains=logIssueDescr,logIssueAuthor
syn match logIssueDescr    /[^:][^ ][^.]*/                                                                    contained contains=logIssueAuthor
syn match logIssueAuthor   / *<.*>/                                                                           contained conceal

syn match logSha           /[a-z0-9]\{40\}/

syn match logBuild         /[A-Z][^ ]*-[0-9]\{14\}-un[0-9]\{3\}/

hi! def link logIssue       Question
hi! def link logIssueLink   Comment
hi! def link logIssueDescr  PreProc
hi! def link logIssueAuthor Comment
hi! def link logSha         Constant
hi! def link logBuild       Statement

let b:current_syntax="defaultSyntax"

