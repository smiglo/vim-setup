" Vim syntax file

" Language:         /var/log/messages file


if exists("b:current_syntax")
  finish
endif

set nolist
setlocal cursorline

let s:cpo_save = &cpo
set cpo&vim

syn match   logMy               /\<TB] .*/

syn match   messagesBegin       display '^' nextgroup=messagesFile,messagesDate,messagesDateRFC3339,logMy

syn match   messagesFile        contained display '^[A-Za-z0-9_\-/\.]\+:'
                                \ nextgroup=messagesLineNr
syn match   messagesLineNr      contained display '\d\+:*'
                                \ nextgroup=messagesDate

syn match   messagesDate        contained display '\a\a\a *\d\{1,2} *'
                                \ nextgroup=messagesHour

syn match   messagesHour        contained display '\d\d:\d\d:\d\d\s*'
                                \ nextgroup=messagesHost

syn match   messagesDateRFC3339 contained display '\d\{4}-\d\d-\d\d'
                                \ nextgroup=messagesRFC3339T

syn match   messagesRFC3339T    contained display '\cT'
                                \ nextgroup=messagesHourRFC3339

syn match   messagesHourRFC3339 contained display '\c\d\d:\d\d:\d\d\(\.\d\+\)\=\([+-]\d\d:\d\d\|Z\)'
                                \ nextgroup=messagesHost

syn match   messagesHost        contained display '\S*\s*' contains=dvrCoreKeyword
                                \,camgrKeyword,itvKeyword,upnpKeyword,watchdogKeyword
                                \,druidKeyword,plgwKeyword,uisessionKeyword,pgwsKeyword
                                \,bufferMgrKeyword,streamingKeyword,decoderSetupKeyword
                                \,errorKeyword,warnKeyword
                                \ nextgroup=messagesLabel

syn match   messagesLabel       contained display '\s*[^():]*:\s*'
                                \ nextgroup=messagesText contains=messagesKernel
                                \,messagesPID,druidKeyword,uisessionKeyword
                                \,pgwsKeyword,bufferMgrKeyword,streamingKeyword 
                                \,errorKeyword,warnKeyword
                                \,decoderSetupKeyword

syn match   messagesPID         contained display '\[\zs\d\+\ze\]'

syn match   messagesKernel      contained display 'kernel:'


syn match   messagesIP          '\d\+\.\d\+\.\d\+\.\d\+'

syn match   messagesURL         '\w\+://\S\+'

syn match   messagesText        contained display '.*'
                                \ contains=messagesNumber,messagesIP,messagesURL,messagesError
                                \,mediaPlayerKeyword,remotePlayerKeyword,localPlayerKeyword
                                \,dvrCoreKeyword,camgrKeyword,itvKeyword,apglibKeyword
                                \,upnpKeyword,watchdogKeyword,druidKeyword,plgwKeyword
                                \,uisessionKeyword,pgwsKeyword,bufferMgrKeyword
                                \,streamingKeyword,decoderSetupKeyword,
                                \,errorKeyword,warnKeyword


syn match   messagesNumber      contained '0x[0-9a-fA-F]*\|\[<[0-9a-f]\+>\]\|\<\d[0-9a-fA-F]*'

syn match   messagesError       contained '\c.*\<\(SERIOUS\|LOG_ERR\|ERROR\|ERRORS\|FAILED\|FAILURE\).*'

hi def link messagesFile        Statement
hi def link messagesLineNr      Comment
hi def link messagesDate        Constant
hi def link messagesHour        Type
hi def link messagesDateRFC3339 Constant
hi def link messagesHourRFC3339 Type
hi def link messagesRFC3339T    Normal
hi def link messagesHost        Identifier
hi def link messagesLabel       Operator
hi def link messagesPID         Constant
hi def link messagesKernel      Special
hi def link messagesError       WarningMsg
hi def link messagesIP          Constant
hi def link messagesURL         Underlined
hi def link messagesText        Normal
hi def link messagesNumber      Number

let b:current_syntax = "messages"

let &cpo = s:cpo_save
unlet s:cpo_save

"==============================================================================
syn match   channelChange       '\(watchStation\|watchRecording\)().*'
syn match   keyPress            'KeyEventDispatcher - KEYTRACK.*rawkey=1.*'
syn match   exceptionStack      'at com\..*'
syn match   logsenseNotes       'logsense.py.*'

syn keyword mediaPlayerKeyword   MediaPlayer
syn keyword localPlayerKeyword   LocalPlayer
syn keyword remotePlayerKeyword  RemotePlayer RUIProtocol RUI RVU rvulib RVULIB RvuStreamingControlImpl rvuLibCloseConnection Rvu RUISession rvu_context RvuUpnpProxy RVUClientImageService
syn keyword dvrCoreKeyword       dvr_core
syn keyword camgrKeyword         camgr
syn keyword itvKeyword           ITV WEBKIT OPENGL_GL OPENGL_EGL ITVSessionManager IPOR ipor
syn keyword apglibKeyword        APGLIB APGStation
syn keyword upnpKeyword          upnp_proxy AVOM
syn keyword watchdogKeyword      watchdog WATCHDOG
syn keyword druidKeyword         druid DRUID
syn keyword plgwKeyword          PLGW
syn keyword uisessionKeyword     UiSession
syn keyword pgwsKeyword          PGWS PGWSProgramGuide pgwsclient PGWSCategoryService PGWSPDSSDCommand PGWSIterator PGWSProgramCommand PGWSClientDispatcher
syn keyword bufferMgrKeyword     BufferManager
syn keyword streamingKeyword     VideoStreamingService HLS hls rtsp streaming Streaming mp4lib Mp4Streamer
syn keyword decoderSetupKeyword  VideoDecoder AudioDecorder Decode decode DecodeManager0 AudioService1 decoder Decoder VIDEO ECM AUDIO CLOCK TTS ATSC ChannelId TRANSPORT_STREAM_MPEG
syn keyword errorKeyword         SERIOUS LOG_ERR ERR ERROR ERRORS FAILED FAILURE CRIT CRITICAL error errors err failed fatal crit critical
syn keyword warnKeyword          WARN CONCERN WARNING warn warning concern

" defining highilghts "
hi channelChangeHighlight  ctermbg=18 ctermfg=192
hi keyPressHighlight       ctermbg=22 ctermfg=192
hi exceptionStackHighlight ctermbg=88 ctermfg=192
hi logsenseHighlight       ctermbg=17  ctermfg=184 cterm=bold

" keyword highlighting "
hi mediaPlayerKeyword  ctermfg=117
hi localPlayerKeyword  ctermfg=97  cterm=bold
hi remotePlayerKeyword ctermfg=109 cterm=bold
hi dvrCoreKeyword      ctermfg=118 cterm=bold
hi camgrKeyword        ctermfg=111
hi itvKeyword          ctermfg=168
hi apglibKeyword       ctermfg=166
hi upnpKeyword         ctermfg=127
hi watchdogKeyword     ctermfg=184 cterm=bold
hi druidKeyword        ctermfg=11
hi plgwKeyword         ctermfg=116
hi uisessionKeyword    ctermfg=131
hi pgwsKeyword         ctermfg=97
hi rvuKeyword          ctermfg=104 cterm=bold
hi bufferMgrKeyword    ctermfg=138
hi streamingKeyword    ctermfg=153 cterm=bold
hi decoderSetupKeyword ctermfg=148 cterm=bold
hi errorKeyword        ctermfg=1   cterm=bold,underline
hi warnKeyword         ctermfg=178 cterm=bold,underline

" linking definition with regex syntax "
hi def link channelChange            channelChangeHighlight
hi def link keyPress                 keyPressHighlight
hi def link exceptionStack           exceptionStackHighlight
hi def link logsenseNotes            logsenseHighlight

"==============================================================================

set nolist
set nowrap

