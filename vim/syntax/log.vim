if exists("b:current_syntax")
  finish
endif

set nolist
setlocal cursorline

source ~/.vim/syntax/syntax-common.vim

syn match logStack       /^\%(-\s\)*\<\%(Exception\|Registers\|Stack Dump\|reg\|pc\|ra\|PC\|Signal\)\>.*/

syn match logFile        /^[A-Za-z0-9_/~%\-\.]\{5,\}:\%(\d\+\)\?[:-]/                                                                          nextgroup=logTime contains=logLine

syn match logTime        /\<\(Jan\|Feb\|Mar\|Apr\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)\> \d\+\s*/                               conceal cchar=∙ nextgroup=logTime
syn match logTime        /\s*\[\?\<\d\{4\}-\d\d-\d\d\>\%( \d\d:\d\d:\d\d\)\?\]\?\s*/                                           conceal cchar=∙ nextgroup=logTime
syn match logTime        /\s*\<\%(\d\+-\)\?\d\{1,2\}:\d\d:\d\d[:.]\d\+\>/                                                      conceal cchar=∙ nextgroup=logId,logMy,logIssue,logDebug,logNotice,logInfo,logWarning,logError,logFatal,logValue
syn match logTime        /\s*\<\d\d:\d\d:\d\d\>/                                                                                               nextgroup=logId,logMy,logIssue,logDebug,logNotice,logInfo,logWarning,logError,logFatal,logValue
syn match logTime        /\.\d\{6,\}\>/                                                                                        conceal cchar=∙ nextgroup=logId,logMy,logIssue,logDebug,logNotice,logInfo,logWarning,logError,logFatal,logValue
syn match logModule      /\<[A-Z][0-9a-zA-Z.\-_]\+\[\d\+]:\s*/                                                                                 nextgroup=logException,logMy,logIssue,logDebug,logNotice,logInfo,logWarning,logError,logFatal,logTime,logValue contained contains=logId
syn match logModule      /^\<[A-Z][0-9a-zA-Z.\-_]\+\%(\[\d\+]\)\?:\s*/                                                                         nextgroup=logException,logMy,logIssue,logDebug,logNotice,logInfo,logWarning,logError,logFatal,logTime,logValue contains=logId
syn match logId          /\s*\<\x\{6\}-[A-Z]\+-\d\+\s*/                                                                        conceal cchar=∙ nextgroup=logModule,logException,logMy,logIssue,logDebug,logNotice,logInfo,logWarning,logError,logFatal,logTime,logValue
syn match logId          /\s*\%(\[\d\+\]:\?\|\[\d\+\]\s\?\s*\|\[tid=\d\+\]\)\s*/                                               conceal cchar=∙ nextgroup=logException,logMy,logIssue,logDebug,logNotice,logInfo,logWarning,logError,logFatal,logTime,logValue
syn match logId          /\s*\%(\<\d\{6}-\d\d:\d\d:\d\d\.\d\{6\}\s\?\>\|\[\?[0-9\-]\+T[0-9:.]\+Z\]\?\)\s*/                     conceal cchar=∙ nextgroup=logException,logMy,logIssue,logDebug,logNotice,logInfo,logWarning,logError,logFatal,logTime,logValue
syn match logId          /\s*\[mod=[A-Z][^\]]*\]\s*/                                                                           conceal cchar=∙ nextgroup=logException,logMy,logIssue,logDebug,logNotice,logInfo,logWarning,logError,logFatal,logTime,logValue
syn match logException   /.*Exception .*/                                                                                                      nextgroup=logMy contained
syn match logException   /\s*\<at .*(\/.*:\d\+:\d\+).*/                                                                        conceal cchar=∙ nextgroup=logMy contained
syn match logIssue       /\[[A-Z][A-Z0-9]\{2,\}-[1-9][0-9]\{2,\}\]\|[A-Z][A-Z0-9]\{2,\}-[1-9][0-9]\{2,\}:\|\<[A-Z][A-Z0-9]\{2,\}-[1-9]\d\{2,\}\>/
syn match logTmp         //                                                                                                  conceal cchar=∙
syn match logTmp         /\s*\[\d\+. blob data\]/                                                                              conceal cchar=∙

syn match logDebug       /\[\?\<TRACE\>\]\?:\?/     skipwhite conceal cchar=T
syn match logDebug       /\[\?\<DEBUG\>\]\?:\?/     skipwhite conceal cchar=D
syn match logNotice      /\[\?\<NOTICE\>\]\?:\?/    skipwhite conceal cchar=N
syn match logInfo        /\[\?\<INFO\>\]\?:\?/      skipwhite conceal cchar=I
syn match logWarning     /\[\?\<WARN\>\]\?:\?/      skipwhite conceal cchar=W
syn match logWarning     /\[\?\<WARNING\>\]\?:\?/   skipwhite conceal cchar=W
syn match logError       /\[\?\<ERROR\>\]\?:\?/     skipwhite conceal cchar=E
syn match logFatal       /\[\?\<FATAL\>\]\?:\?/     skipwhite conceal cchar=F

syn keyword errorKeyword error
syn keyword warnKeyword  warning

hi! def link logId          Comment
hi! def link logTmp         Comment
hi! def link logStack       Error
hi! def link logModule      PreProc
hi! def link logTime        Special
hi! def link logIssue       Constant
hi! def link logException   ErrorMsg
hi! def link logDebug       Comment
hi! def link logNotice      Comment
hi! def link logInfo        Comment
hi! def link logWarning     WarningMsg
hi! def link logError       ErrorMsg
hi! def link logFatal       ErrorMsg
hi! errorKeyword            ctermfg=1   cterm=bold,underline
hi! warnKeyword             ctermfg=178 cterm=bold,underline

let b:current_syntax="logSyntax"

set nolist
set nowrap

