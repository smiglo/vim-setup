syn match logKeyword    /\<TODO:\?/
syn match logKeyword2   /???\|\<FIXME:\?\|\<TBD\>:\?/

syn match logValue      /\<0x\x\{4,\}\>\|\<[a-fA-F0-9]\{8,\}\>/                                        " Hex number
syn match logValue      /\<\d\{4,\}\%([,.]\d\+\)\?\>/                                                  " Dec number
syn match logValue      /\<\d\+\%([,.]\d\{4,\}\)\{1\}\>/                                               " Dec number
syn match logValue      /-\?\d\{4,\}\%([,.]\d\+\)\?\>/                                                 " Dec number
syn match logValue      /-\?\d\+\%([,.]\d\{4,\}\)\{1\}\>/                                              " Dec number
syn match logValue      /\<\x\{4,\}\%(-\x\{4,\}\)\{2,\}/                                               " Hex id
syn match logValue      /"[^ "][^"]\{2,\}"/                  contains=logKeyword,logKeyword2           " String in double ''
syn match logValue      /\<\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\>\%(\/\d\+\)\?/                  " IPv4
syn match logValue      /\<\x\{4,\}:[:0-9a-fA-F]\+\>\%(\/\d\+\)\?/                                     " IPv6
syn match logValue      /\<[a-z]\{3,\}:\/\/[^ ,;()\[\]<>]\+/                                           " Protocol (e.g. https://)
syn match logValue      /\<\f\{3,\}\.\f\{3,\}\.[^ ,;()\[\]<>]\+/                                       " Domain/Class name
syn match logValue      /\<\%(\f\{3,\}\.\)*\f\{3,\}::\f\{3,\}[^ ,;()\[\]<>]*/                          " Domain/Class name
syn match logValue      /<\f\{3,\}[^>]*>/                                                              " Domain/Class name
syn match logValue      /\<\f\{3,\}\.\(cpp\|c\|hpp\|h\|js\|html\)\>/                                   " Domain/Class name
syn match logValue      /\<\f\{3,\}\.\f\+:\%(\d\+:\)\?\%(\f\{3,\}:\)\?/                                " Domain/Class name
syn match logValue      /\/*\f\{3,\}\/\f\{3,\}[^ ,;()\[\]<>]*/                                         " Path

syn match logModule      /^\<[A-Za-z][0-9a-zA-Z.\\_-]\+:\s/

syn match logMy         /\<TB] .*/                   contains=logMyInfo,logMyFunc,logMyErr,logMyImp,logValue,logId,logIssueLine,logTime,logKeyword,logKeyword2,logIssue
syn match logMyInfo     /\<II\> /                    skipwhite contained
syn match logMyFunc     /\<BB\> \|\<AA\> \|\<TT\> /  skipwhite contained
syn match logMyErr      /\<EE\> \|\<FF\> /           skipwhite contained
syn match logMyImp      /\<IMP\> /                   skipwhite contained

syn match logTime       /^\d\d:\d\d:\d\d/
syn match logTime       /\s*\<\d\d:\d\d:\d\d\>/
syn match logTime       /\s*\<\d\{8\}-\d\{6\}\>/
syn match logTime2      /\d\{6\}-\d\d:\d\d:\d\d\.\d\{6\}/                 conceal cchar=∙
syn match logFile       /^[A-Za-z0-9_/~%\-\.]\{5,\}:\%(\d\+\)\?[:-]/      contains=logLine
syn match logLine       /\d\+:/                                           contained

syn match logCmdLine    /^[☯+-:].\{-}[$#❶❷]\($\| .*$\)/ contains=logCmd1
syn match logCmd1       /^[☯+-:] \?/                   contained nextgroup=logCmd2,logCmd2Root,logCmd3 conceal
syn match logCmd2       /.\{-}[$❶❷]/                   contained contains=logCmd2a,logCmd3 nextgroup=logCmd3,logCmd4 conceal cchar=$
syn match logCmd2Root   /.\{-}#/                       contained contains=logCmd2a,logCmd3 nextgroup=logCmd3,logCmd4 conceal cchar=#
syn match logCmd2a      /(.\{-\})/                     contained nextgroup=logCmd3,logCmd3Root,logCmd4 conceal
syn match logCmd3       /[$❶❷]/                        contained nextgroup=logCmd4
syn match logCmd3Root   /#/                            contained nextgroup=logCmd4
syn match logCmd4       / .*$/                         contained

syn match logCmdLineV2  /^root@.*:[^ ]*#\%($\| .*\)/   contains=logCmdV2_1
syn match logCmdV2_1    /^root@/                       contained nextgroup=logCmdV2_2 conceal
syn match logCmdV2_2    /[A-Z0-9-]*/                   contained nextgroup=logCmdV2_3 conceal
syn match logCmdV2_2    /[a-z0-9-]*-debug*/            contained nextgroup=logCmdV2_3 conceal
syn match logCmdV2_3    /:/                            contained nextgroup=logCmdV2_4 conceal
syn match logCmdV2_4    /[^#]*/                        contained nextgroup=logCmdV2_5 conceal
syn match logCmdV2_5    /#/                            contained nextgroup=logCmdV2_6 conceal cchar=#
syn match logCmdV2_6    / .*$/                         contained

syn match logComment    /^# .*\|^\/\/.*/          contains=logMy,logKeyword,logKeyword2
    " was:   /^# [^{}].*\|^\/\/.*/
syn match logComment    /^#\s*$/
syn match logComment    /\(\/\/\|##\) .*\<TB].*/  contains=logMy
syn match logComment    /\(\/\/\|##\) .*\<TB].*/  contains=logMy
syn match logComment    /\(\/\/\/\|###\) .*/      contains=logMy,logKeyword,logKeyword2

syn match foldMarkerB /{\{3\}\d*/ conceal cchar=► containedin=ALL
syn match foldMarkerE /}\{3\}\d*/ conceal cchar=● containedin=ALL

hi def link logFile     Statement
hi def link logLine     Comment
hi def link logMyInfo   ModeMsg
hi def link logMyFunc   Function
hi def link logMyErr    Error
hi def link logMyImp    WildMenu
hi def link logValue    Identifier
hi def link logTime2    Comment
hi def link logTime     Special
hi def link logModule   PreProc
hi def link logKeyword  Todo
hi def link logKeyword2 ErrorMsg
hi def link logComment  Comment
hi def link logCmd1     Comment
hi def link logCmd2     PreProc
hi def link logCmd2Root PreProc
hi def link logCmd2a    Comment
hi def link logCmd3     String
hi def link logCmd3Root ErrorMsg
hi def link logCmd4     Special
hi def link logCmdV2_1  Comment
hi def link logCmdV2_2  Identifier
hi def link logCmdV2_3  Comment
hi def link logCmdV2_4  PreProc
hi def link logCmdV2_5  String
hi def link logCmdV2_6  Special
hi def link foldMarkerB Comment
hi def link foldMarkerE Comment

set iskeyword+=-

