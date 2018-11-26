if exists("b:current_syntax")
  finish
endif

set nolist
setlocal cursorline

" Pattern for personal debugs
syn match logMy        /\<TB] .*/                contains=logMyInfo,logMyFunc,logMyErr,logMyImp
syn match logMyInfo    /\<II\>/                  skipwhite
syn match logMyFunc    /\<BB\>\|\<AA\>\|\<TT\>/  skipwhite
syn match logMyErr     /\<EE\>\|\<FF\>/          skipwhite
syn match logMyImp     /\<IMP\>/                 skipwhite

syn match logStack /^\%(-\s\)*\%(Exception\|Registers\|Stack Dump\|reg\|pc\|ra\|PC\|Signal\).*/

syn match logFile /^[A-Za-z0-9_/~%\-\.]\{5,\}:\%(\d\+\)\{0,1\}[:-]/ contains=logLine nextgroup=logTime
syn match logLine /\d\+[:-]/                                        contained

syn match logTime      /[A-Za-z]\{3\} \d\+ \d\d:\d\d:\d\d\|\d\{4\}-\d\d-\d\d \d\d:\d\d:\d\d/                             nextgroup=logId,logMy,logIssue,logDebug,logWarning,logError,logFatal
syn match logTime      /\d\d:\d\d:\d\d/                                                                  conceal cchar=∙ nextgroup=logId,logMy,logIssue,logDebug,logWarning,logError,logFatal
syn match logId        /[0-9A-F]\{6\}-[A-Z]\+-\d\+\s\{0,1\}/                                             conceal cchar=∙ nextgroup=logException,logMy,logIssue,logDebug,logWarning,logError,logFatal
syn match logId        /\[\d\+\]:\{0,1\}\|\[\d\+\]\s\{0,1\}\|\[tid=\d\+\]\s\{0,1\}/                      conceal cchar=∙ nextgroup=logException,logMy,logIssue,logDebug,logWarning,logError,logFatal
syn match logId        /\d\{6}-\d\d:\d\d:\d\d\.\d\{6\}\s\{0,1\}\|\[[0-9\-]\+T[0-9:.]\+Z\]\s\{0,1\}/      conceal cchar=∙ nextgroup=logException,logMy,logIssue,logDebug,logWarning,logError,logFatal
syn match logId        /\[mod=[A-Z][^\]]*\]\s\{0,1\}/                                                    conceal cchar=∙ nextgroup=logException,logMy,logIssue,logDebug,logWarning,logError,logFatal
syn match logException /.*Exception.*\|.*\<at .*/                                                        contained       nextgroup=logMy
syn match logIssue     /\[[A-Z][A-Z0-9]\{2,\}-[1-9][0-9]\{2,\}\]\|[A-Z][A-Z0-9]\{2,\}-[1-9][0-9]\{2,\}:\|\<[A-Z][A-Z0-9]\{2,\}-[1-9][0-9]\{2,\}\>/

syn match logDebug     /\[DEBUG\]/    contains=logFile,logTime  skipwhite
syn match logWarning   /\[WARNING\]/  contains=logFile,logTime  skipwhite
syn match logError     /\[ERROR\]/    contains=logFile,logTime  skipwhite
syn match logFatal     /\[FATAL\]/    contains=logFile,logTime  skipwhite

syn keyword errorKeyword  error
syn keyword warnKeyword   warning

if !exists("did_logannotate_syntax_inits")
  let did_logannotate_syntax_inits = 1
  hi def link logId          Comment
  hi def link logStack       Error
  hi def link logFile        Statement
  hi def link logLine        Comment
  hi def link logTime        Special
  hi def link logIssue       Identifier
  hi def link logException   ErrorMsg
  hi def link logWarning     WarningMsg
  hi def link logDebug       Normal
  hi def link logMessage     Normal
  hi def link logError       ErrorMsg
  hi def link logFatal       ErrorMsg
  hi def link logMyInfo      ModeMsg
  hi def link logMyFunc      Function
  hi def link logMyErr                    Error
  hi def link logMyImp                    WildMenu
  hi errorKeyword       ctermfg=1   cterm=bold,underline
  hi warnKeyword        ctermfg=178 cterm=bold,underline
endif
hi def link logId Type

let b:current_syntax="logSyntax"

set nolist
set nowrap

