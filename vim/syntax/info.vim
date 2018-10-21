syn keyword	cTodo		contained TODO FIXME XXX

syn match tbHidden "^-- .*"


syn region String start="\"" end="\""

syn match	Number "\A\d\|\.\d"
syn match	Number "\A\d\|\.\d"
syn match	Number "\A\d\+\(u\=l\{0,2}\|ll\=u\)"
syn match	Number "\A0x\x\+\(u\=l\{0,2}\|ll\=u\)"
syn match	Number "\A0\o\+\(u\=l\{0,2}\|ll\=u\)"
syn match	Number "\A0"
syn match	Number "\A\d\+f"
syn match	Number "\A\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
syn match	Number "\A\.\d\+\(e[-+]\=\d\+\)\=[fl]\="
syn match	Number "\A\d\+e[-+]\=\d\+[fl]\="

" @(comment) header //Comment
syn match Underlined "^@\((.\{-})\)\= .*" contains=Comment

" *(comment) Todo //Comment
if v:progname =~? "gvim"
	syn match PreProc "^!\((.\{-})\)\= .*" contains=Comment
else
	syn match Normal "^!\((.\{-})\)\= .*" contains=Comment
endif

" #(comment) Descr //Comment
syn match Special "^\*\((.\{-})\)\= .*" contains=Comment

" !(comment) Descr //Comment
syn match Constant "^#\((.\{-})\)\= .*" contains=Comment

" [#!*]+(comment) Descr //Comment
syn match LineNr "^[#!\*]+\((.\{-})\)\= .*" contains=Comment

" [#!*]-(comment) Descr //Comment
syn match Type "^[#!\*]-\((.\{-})\)\= .*" contains=Comment

syn match Comment "//.*" contains=cTodo
syn region Comment start="/\*" end="\*/" contains=cTodo

hi def link cTodo		Todo

hi def link tbHidden myHidden

hi myHidden guibg=black guifg=black gui=none ctermbg=black ctermfg=black


