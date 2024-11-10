au BufRead,BufNewFile *.log             set filetype=log cursorline
au BufRead,BufNewFile *.log.*           set filetype=log cursorline
au BufRead,BufNewFile *.log-all         set filetype=log cursorline
au BufRead,BufNewFile journal_by_file.* set filetype=log cursorline
au BufRead,BufNewFile *
      \ if
      \    (getline(1) =~ '^\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\) \s\?\d\d\? \d\d:\d\d:\d\d' ||
      \     getline(1) =~ '\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d' ||
      \     getline(1) =~ '\d\{10\}\.\%(\d\{3\}\)\+: ' ) |
      \   set filetype=log cursorline |
      \ endif
au BufEnter *
      \ if (&filetype == "" || &filetype == "text") &&
      \    (getline(1) =~ '^\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\) \s\?\d\d\? \d\d:\d\d:\d\d' ||
      \     getline(1) =~ '\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d' ||
      \     getline(1) =~ '\d\{10\}\.\%(\d\{3\}\)\+: ' ) |
      \   set filetype=log cursorline |
      \ endif

