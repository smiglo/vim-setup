nmap <buffer> <silent> <F12>fL :set filetype=log2<CR>
setlocal nolist
setlocal nowrap
setlocal cursorline
setlocal conceallevel=2
setlocal foldlevel=0 foldmethod=marker
setlocal foldmarker=TB]\ AA,TB]\ BB
nmap <buffer> <silent> <F12>cl :if &conceallevel == 2 <Bar> setlocal conceallevel=0 <Bar> else <Bar> setlocal conceallevel=2 <Bar> endif<CR>

