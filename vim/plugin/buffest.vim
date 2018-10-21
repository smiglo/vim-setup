" Commands {{{

command! -complete=customlist,buffest#regcomplete -nargs=1
      \ Regsplit call buffest#regdo(<f-args>, 'split')
command! -complete=customlist,buffest#regcomplete -nargs=1
      \ Regvsplit call buffest#regdo(<f-args>, 'vsplit')
command! -complete=customlist,buffest#regcomplete -nargs=1
      \ Regtabedit call buffest#regdo(<f-args>, 'tabedit')

command! -complete=customlist,buffest#listfieldcomplete -nargs=*
      \ Qflistsplit call buffest#qflistdo('split', <f-args>)
command! -complete=customlist,buffest#listfieldcomplete -nargs=*
      \ Qflistvsplit call buffest#qflistdo('vsplit', <f-args>)
command! -complete=customlist,buffest#listfieldcomplete -nargs=*
      \ Qflisttabedit call buffest#qflistdo('tabedit', <f-args>)

command! -complete=customlist,buffest#listfieldcomplete -nargs=*
      \ Loclistsplit call buffest#loclistdo('split', <f-args>)
command! -complete=customlist,buffest#listfieldcomplete -nargs=*
      \ Loclistvsplit call buffest#loclistdo('vsplit', <f-args>)
command! -complete=customlist,buffest#listfieldcomplete -nargs=*
      \ Loclisttabedit call buffest#loclistdo('tabedit', <f-args>)

" }}}

" Bindings {{{

if !hasmapto('<Plug>Regsplit') && mapcheck('c@', 'n') == ''
  map <unique> c@ <Plug>Regsplit
  " Only map this if the defaul mapping is used
  nnoremap <unique> c@@ :Regsplit "<cr>
endif

nnoremap <Plug>Regsplit :execute 'Regsplit '.nr2char(getchar())<cr>

if hasmapto('<Plug>Regvsplit')
  nnoremap <Plug>Regvsplit :execute 'Regvsplit '.nr2char(getchar())<cr>
endif

if hasmapto('<Plug>Regtabedit')
  nnoremap <Plug>Regtabedit :execute 'Regtabedit '.nr2char(getchar())<cr>
endif

if !hasmapto('<Plug>Qflistsplit') && mapcheck('c,q', 'n') == ''
  map <unique> c,q <Plug>Qflistsplit
endif

nnoremap <Plug>Qflistsplit :Qflistsplit<cr>

if hasmapto('<Plug>Qflistvsplit')
  nnoremap <Plug>Qflistvsplit :Qflistvsplit<cr>
endif

if hasmapto('<Plug>Qflisttabedit')
  nnoremap <Plug>Qflisttabedit :Qflisttabedit<cr>
endif

if !hasmapto('<Plug>Loclistsplit') && mapcheck('c,l', 'n') == ''
  map <unique> c,l <Plug>Loclistsplit
endif

nnoremap <Plug>Loclistsplit :Loclistsplit<cr>

if hasmapto('<Plug>Loclistvsplit')
  nnoremap <Plug>Loclistvsplit :Loclistvsplit<cr>
endif

if hasmapto('<Plug>Loclisttabedit')
  nnoremap <Plug>Loclisttabedit :Loclisttabedit<cr>
endif

" }}}

" vim: set fdm=marker
