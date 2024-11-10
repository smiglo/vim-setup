nmap <buffer> <silent> <F12>fL :set filetype=log2<CR>
setlocal nolist
setlocal nowrap
setlocal cursorline
setlocal iskeyword+=-,:,.
setlocal foldlevel=0 foldmethod=marker
" setlocal foldmarker=TB]\ BB,TB]\ AA
setlocal conceallevel=1
syntax on
nmap <buffer> <silent> <F12>cl :if &conceallevel == 1 <Bar> setlocal conceallevel=0 <Bar> else <Bar> setlocal conceallevel=1 <Bar> endif<CR>
nmap <buffer> <silent> <F12>clf :call TBToggleGroupConceal('logFile')<CR>

