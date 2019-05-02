syn match logValue      /\<0x\x\{4,\}/                                                                 " Hex number
syn match logValue      /\<\d\{4,\}\%([,.]\d\+\)\{0,1\}\>/                                             " Dec number
syn match logValue      /\<\d\+\%([,.]\d\{4,\}\)\{1\}\>/                                               " Dec number
syn match logValue      /-\{0,1\}\d\{4,\}\%([,.]\d\+\)\{0,1\}\>/                                       " Dec number
syn match logValue      /-\{0,1\}\d\+\%([,.]\d\{4,\}\)\{1\}\>/                                         " Dec number
syn match logValue      /\<\x\{4,\}\%(-\x\{4,\}\)\{2,\}/                                               " Hex id
syn match logValue      /'\%([^ t]\|t[^ ]\)[^']\{3,\}'/                                                " String in ''
syn match logValue      /"[^ ][^"]\{3,\}"/                                                             " String in double ''
syn match logValue      /\<\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\>\%(\/\d\+\)\{0,1\}/             " IPv4
syn match logValue      /\<\x\{4,\}:[:0-9a-fA-F]\+\>\%(\/\d\+\)\{0,1\}/                                " IPv6
syn match logValue      /\<[a-z]\{3,\}:\/\/[^ ,;()\[\]<>]\+/                                           " Protocol (e.g. https://)
syn match logValue      /\<\f\{3,\}\.\f\{3,\}\.[^ ,;()\[\]<>]\+/                                       " Domain/Class name
syn match logValue      /\<\%(\f\{3,\}\.\)*\f\{3,\}::\f\{3,\}[^ ,;()\[\]<>]*/                          " Domain/Class name
syn match logValue      /<\f\{3,\}[^>]*>/                                                              " Domain/Class name
syn match logValue      /\<\f\{3,\}\.\(cpp\|c\|hpp\|h\|js\|html\)\>/                                   " Domain/Class name
syn match logValue      /\<\f\{3,\}\.\f\+:\%(\d\+:\)\{0,1\}\%(\f\{3,\}:\)\{0,1\}/                      " Domain/Class name
syn match logValue      /\/*\f\{3,\}\/\f\{3,\}[^ ,;()\[\]<>]*/                                         " Path

syn match logMy         /\<TB] .*/                contains=logMyInfo,logMyFunc,logMyErr,logMyImp,logValue,logId,logIssue,logTime
syn match logMyInfo     /\<II\>/                  skipwhite contained
syn match logMyFunc     /\<BB\>\|\<AA\>\|\<TT\>/  skipwhite contained
syn match logMyErr      /\<EE\>\|\<FF\>/          skipwhite contained
syn match logMyImp      /\<IMP\>/                 skipwhite contained

syn match logFile       /^[A-Za-z0-9_/~%\-\.]\{5,\}:\%(\d\+\)\{0,1\}[:-]/ contains=logLine
syn match logLine       /\d\+:/                                           contained

hi def link logFile     Statement
hi def link logLine     Comment
hi def link logMyInfo   ModeMsg
hi def link logMyFunc   Function
hi def link logMyErr    Error
hi def link logMyImp    WildMenu
hi def link logValue    Identifier

