" vim: fdl=0 fdm=marker

if $IS_MAC == 'true' && has("python3") " {{{
  py3 ""
endif " }}}
" Useful stuff {{{
" if has('win16') || has('win32') || has('win64')
" else
" endif
" if $LOCATION ==? "home"
" else
" endif
" }}}
" Runtime setup. {{{
if has('win16') || has('win32') || has('win64')
  if $LOCATION ==? "home"
    set path+=e:/Tom/programy/batch
    set path+=e:/Tom/programy/_setup/vim/vim
    set runtimepath+=e:/Tom/programy/_setup/vim/vim
  endif
endif
" When started as "evim", evim.vim will already have done these settings. {{{
  if v:progname =~? "evim"
    finish
  endif
" }}}
" set runtimepath+=~/.vim/my_mods
" }}}
" General {{{
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" Map arrow keys properly if terminal is screen-* {{{
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
" }}}
set enc=utf8                                                        " encoding
set number                                                          " line numbers
set laststatus=2                                                    " always show status line
set showtabline=2                                                   " tab line always
set showcmd                                                         " display incomplete commands
set showmode                                                        " display current mode
set history=500                                                     " keep 500 lines of command line history
set undolevels=5000                                                 " set undolevels
set tabpagemax=100                                                  " max number of opened tabs
set lazyredraw                                                      " do not refresh screen when executing a macro
set modeline                                                        " vim setup at the end of a file
set splitright
set statusline=
set statusline+=%<\                                                 " Trim if too long
set statusline+=%#StatusLineMark#%(%{TBSBFilename(0)}%*\ %)         " File name
set statusline+=%#StatusLineLoc#%{TBSBFilename(1)}%*                " File name
set statusline+=\%#StatusLineMark#%(\ %M\ %)%*                      " Flag: Modified
set statusline+=\ %=\                                               " Middle
set statusline+=%#StatusLineMark
set statusline+=#%(%(\ %R%)%(\ %H%)%(\ %W%)\ %)%*                   " Rest of Flags
set statusline+=%#StatusLineLoc#
set statusline+=%(\ %{TBSessGetName('SB')}\ \|%)                    " Sesison
set statusline+=%(\ %{TBSBGitStatus()}\ \|%)                        " Branch
set statusline+=%(\ %{TBSBExtraInfo()}\ \|%)                        " Extra information
if $TERMINAL_HAS_EXTRA_CHARS != 'false'
  set statusline+=\ %4l\ ×\ %-3c\ \|                                " Cursor position
else
  set statusline+=\ %4l\ x\ %-3c\ \|                                " Cursor position
endif
set statusline+=\ %P\                                               " Percentage
set statusline+=%*\                                                 " Right side - End
set noruler
set novisualbell
set noerrorbells  " quiet
set belloff=all
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set cpo+=>        " add line break when appending into a register
set tw=0          " textwidth
set timeout timeoutlen=750 ttimeoutlen=200   " ESC timeout
set clipboard=unnamed " if unnamedplus is chosen, then all deletes go into system clipboard what is unwanted
if $VIM_CLIPBOARD != ""
  set clipboard=$VIM_CLIPBOARD
endif
set pastetoggle=<f5> " do I need this if I know "+ register?
set switchbuf=useopen,usetab " don't duplicate an existing open buffer
set matchpairs+=<:> " Jump over '<' '>' blocks using TAB (and % by default)
set sessionoptions=buffers,sesdir,tabpages,winsize,globals,localoptions,folds
set fillchars=vert:\│,fold:\⋅
set viminfo='500,<80,s10,h
if $VIM_UTILS_PATH != ""
  set viminfo+=n$VIM_UTILS_PATH/viminfo
endif
" set colorcolumn=110 "shows color column at 110
if has("gui_macvim")
  set guifont=Fira\ Mono:h17,Inconsolata:h17
  set printfont=Fira\ Mono:h17,Inconsolata:h17
else
  set guifont=Fira\ Mono\ 14,Inconsolata\ 16
  set printfont=Fira\ Mono\ 14,Inconsolata\ 16
endif
set printencoding=latin2
set printheader=%=%t/%N
set autoread " Auto reread file if changed outside
set hidden   " Does not close buffers
" if $STY != ""
"   set titlestring=vim:\ %t
"   let &t_ti .= "\e[22;0t"
"   let &t_te .= "\e[23;0t"
" endif
" set title    " Change terminal's title
set listchars=tab:\|\⋅,trail:¬,extends:\#,precedes:\#,conceal:∙
set list     " enables list by default
set nowrap        " wrap disabled
let &showbreak = ' ↳ ⋅'
if v:version < 900 && ( v:version > 801 || v:version == 801 && has("patch360"))
  set diffopt=indent-heuristic,algorithm:patience
else
  set diffopt=
endif
set diffopt+=filler,iwhite,vertical " diff switches
set cryptmethod=blowfish2 " algorithm for encryption
set undofile " persistent undo
set undodir=$VIM_UTILS_PATH/undoes " location of persistent undo
if $VIM_UNDOES_PATH != ""
  set undodir=$VIM_UNDOES_PATH
endif
set concealcursor=ncv " Unfold coneals only when editing
set shortmess=aIoOtT  " Shortens messages to avoid 'press a key' prompt
set cmdheight=1       " Avoid 'press enter...' message
set scrolloff=4       " Start scrolling when we're 4 lines away from margins
set sidescrolloff=15
set sidescroll=1
let g:is_bash=1
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif
if $VIM_GIT_SHOW_STATUS == 'true'
  let g:GitShowStatus = 1
endif
" menu bar on status bar with completion & menu in concole mode {{{
set wildmenu
set cpo-=<
set wildcharm=<C-Z>
" <F4> displays menu bar on status bar
map <F4> :emenu My.<C-Z>
" }}}
" Backup setup {{{
set nobackup    " do not keep a backup file, use versions instead
set noswapfile  " no swap file
" }}}
" }}}
" Complete menu {{{
set complete=.,b,u,] " Complete from current file, buffers, tags
set wildmode=list:longest,full
set completeopt=longest,menu,preview
" }}}
" Folding {{{
set foldlevel=10
set foldlevelstart=10

set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  let sub  = substitute(line, '/\*\|\*/\|^\s*[#"]*\s*\|\s\+$\|\s*#*\s*{{{\d\=', '', 'g')
" }}} # fix for "\{\{\{" in "let sub = ..."
  let lines = v:foldend - v:foldstart + 1
  let char = 'x'
  if $TERMINAL_HAS_EXTRA_CHARS != 'false' | let char = '×' | endif
  return  '➣ ' . substitute(v:folddashes, '-', '∙', 'g') . ' [ ' . sub . ' ' . char . ' ' . lines . ' lines ] '
endfunction

set foldmethod=marker
set foldmarker=#\ {{{,#\ }}}
autocmd FileType python       setlocal foldmethod=indent
autocmd FileType lua,go,c,cpp setlocal foldmethod=syntax
autocmd FileType arduino      setlocal foldmethod=syntax
autocmd FileType vim          setlocal foldmarker={{{,}}}

" let g:vim_markdown_folding_disabled=1

" }}}
" Guioptions {{{
if has('gui_running')
  " hides menu in gvim
  set guioptions-=m
  " hides toolbar in gvim
  set guioptions-=T
  set guioptions-=L
  set guioptions-=r
  set guioptions-=b
  set cursorline
endif
" }}}
" Navigation between split windows {{{
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l
" }}}
" Keep search pattern at the center of the screen {{{
nnoremap <silent>n nzz
nnoremap <silent>N Nzz
nnoremap <silent>* *zz
nnoremap <silent># #zz
nnoremap <silent>g* g*zz
" }}}
" Tabs {{{
set shiftwidth=0
set tabstop=2
set softtabstop=2
set smarttab
set expandtab  " replaces tabs with spaces
set shiftround " use multiple of shiftwidth when indenting with < >
set notitle
" }}}
" Indents {{{
set autoindent    " always set autoindenting on
set smartindent   " smart indent
set copyindent    " copy previous indent
" }}}
" Searching {{{
set ignorecase
set smartcase    " smart search
set incsearch    " do incremental searching
set gdefault     " replace globally by default
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
set showmatch " matching bracket
set mat=2 " bracket blinking
" }}}
" In many terminal emulators the mouse works just fine, thus enable it. {{{
if has('mouse')
  set mouse=a
endif
" }}}
" Color setup {{{
" Set number of colors to 256
set t_Co=256

if has("gui_running") || &t_Co == 256 || &t_Co == 88
  set background=dark
  colorscheme gruvbox
else
  colorscheme tom
endif

hi HL_HiCurLine ctermbg=darkblue guibg=#404040
let HL_HiCurLine = "HL_HiCurLine"

" }}}
" File formats {{{
if has('win16') || has('win32') || has('win64')
  set fileformats=dos,unix
else
  set fileformats=unix,dos
endif
" }}}
" File type recognition on {{{
filetype plugin on
" }}}
" Only do this part when compiled with support for autocommands. {{{
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  if exists('g:GitShowStatus') && g:GitShowStatus == 1
    autocmd BufRead,BufWritePost,FocusGained,BufEnter * call TBUpdateGitStatus()
  endif

  autocmd FileType make setlocal list tabstop=4 noexpandtab

  " Auto reload vimrc when it's saved
  autocmd BufWritePost ~/.vimrc source ~/.vimrc

  autocmd Syntax h,vim,c,cpp
        \ syn match foldMarkerB /{\{3\}\d*/ conceal cchar=► containedin=ALL |
        \ syn match foldMarkerE /}\{3\}\d*/ conceal cchar=● containedin=ALL |
        \ hi def link foldMarkerB Comment |
        \ hi def link foldMarkerE Comment |
        \ syn cluster cCommentGroup   add=foldMarkerB,foldMarkerE |
        \ syn cluster shCommentGroup  add=foldMarkerB,foldMarkerE |
        \ syn cluster vimCommentGroup add=foldMarkerB,foldMarkerE |
        \ setlocal conceallevel=0

  autocmd Syntax sh
        \ syn match foldMarkerB /{\{3\}\d*/ conceal cchar=► containedin=ALL |
        \ syn match foldMarkerE /}\{3\}\d*/ conceal cchar=● containedin=ALL |
        \ syn keyword shMyKeywordE  echo printf                               containedin=ALLBUT,shComment,shSingleQuote,shDoubleQuote |
        \ syn keyword shMyKeywordE  cl clf echoc printfc                      containedin=ALLBUT,shComment,shSingleQuote,shDoubleQuote |
        \ syn keyword shMyKeyword   echor echorv echorc echore echorm echormf containedin=ALLBUT,shComment,shSingleQuote,shDoubleQuote |
        \ syn keyword shMyKeyword2  FAT ERR WRN INF DBG TRC dbgF dbg dbgC     containedin=ALLBUT,shComment,shSingleQuote,shDoubleQuote |
        \ syn keyword shMyKeyword   die                                       containedin=ALLBUT,shComment,shSingleQuote,shDoubleQuote |
        \ syn keyword shMyKeyword2  getTS                                     containedin=ALLBUT,shComment,shSingleQuote,shDoubleQuote |
        \ syn keyword shMyKeyword2  timeMeasure                               containedin=ALLBUT,shComment,shSingleQuote,shDoubleQuote |
        \ syn keyword shMyKeywordB  true false                                containedin=ALLBUT,shComment |
        \ syn match   shMyGlobVar   /[012&]\?\(>\{0,2\}\|<\?\)\/dev\/\%\(stdout\|stderr\|null\|tty\)/     containedin=ALLBUT,shComment |
        \ syn match   shMyGlobVar   /[12&]\?>>\?&[12]/                                                    containedin=ALLBUT,shComment |
        \ syn match   shMySet       /set \+[-+][xv]\+/                                                    containedin=ALLBUT,shComment |
        \ syn match   shVariable    /\<\h\w*\ze+\?=/ nextgroup=shVarAssign |
        \ hi def link foldMarkerB Comment               |
        \ hi def link foldMarkerE Comment               |
        \ hi! def link shMyKeyword  Question            |
        \ hi! def link shMyKeyword2 GruvboxAquaBold     |
        \ hi! def link shMyKeywordE DiffDelete          |
        \ hi! def link shMyKeywordB Type                |
        \ hi! def link shMyGlobVar  GruvboxGray         |
        \ hi! def link shMyset      WildMenu            |
        \ setlocal conceallevel=0

  " Save all files when vim loses focus
  au FocusLost * silent! wa

  au BufNewFile,BufReadPost,CmdwinEnter *
        \ if index(['nofile', 'terminal'], &buftype) >= 0 || index(['qf', 'help', 'nofile'], &filetype) >= 0
        \ | setlocal cursorline
        \ | nnoremap <buffer> <space> <c-d>
        \ | nnoremap <buffer> <silent> q<CR> :quit<CR>
        \ | endif
  if exists(':Terminal')
    au TerminalOpen *
            \ if index(['nofile', 'terminal'], &buftype) >= 0 || index(['qf', 'help', 'nofile'], &filetype) >= 0
            \ | setlocal cursorline
            \ | nnoremap <buffer> <space> <c-d>
            \ | nnoremap <buffer> <silent> q<CR> :quit<CR>
            \ | endif
  endif

  au BufNewFile,BufRead * :set relativenumber " relative line numbers

  " with comments
  au BufNewFile,BufEnter *.c,*.h,*.java,*.jsp set formatoptions-=t

  " set default filetype
  au BufEnter * if &filetype == "" || &filetype == "text" | setlocal filetype=default | endif
  au BufReadPost * if expand("<afile>") =~# ".*/grep-last/.*" | setlocal filetype=default | endif

  au BufNewFile,BufRead *.service  setf systemd

  " Session stuff
  au VimEnter * if ! exists("g:TBSessionDir") || ! isdirectory(g:TBSessionDir) | let g:TBSessionDir = getcwd() | endif
  au VimLeave * if exists("g:TBSessionName") | call TBSessSave(TBSessGetName(), 1) | endif
  au WinEnter * if exists("g:TBSessionName") | call TBSessUpdate() | endif
  au SessionLoadPost * let g:TBSessionSaveTimeLast = localtime()

  " Working with split screen nicely - Resize Split When the window is resized"
  au VimResized * :wincmd =

  " Omni completion for file types:
  autocmd FileType java setlocal omnifunc=javacomplete#Complete | completefunc=javacomplete#CompleteParamsInfo

  autocmd FileType arduino set filetype=cpp
  autocmd FileType c set filetype=cpp

  au TabLeave * if ! exists("SessionLoad") | let g:LastTab = tabpagenr() | endif

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd VimEnter * normal! zvzMzv

  let g:DuzyPlik = 2 " MB
  let g:DuzyPlik = g:DuzyPlik * 1024 * 1024

  autocmd BufReadPre * if getfsize(expand("<afile>")) > g:DuzyPlik | setlocal noswapfile bufhidden=unload ro | endif

  " Fix syntax corrupted by folds
  au Syntax * if getfsize(expand("<afile>")) < g:DuzyPlik | syntax sync fromstart | else | syntax sync minlines=3 | endif

  augroup END
endif " has("autocmd")
" }}}
" Convenient command to see the difference between the current buffer and the " {{{
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif
" }}}
" My Own {{{
" Functions & Commands {{{
" Sessions {{{
function! TBSessGetName(...) " {{{
  if ! exists("g:TBSessionName") | return "" | endif
  if a:0 >= 1 && (a:1 == 'SB' || a:1 == 'SB-e')
    if g:TBSessionName == 'Session'
      if a:1 == 'SB' | return "" | else | return 'S' | endif
    elseif g:TBSessionName ==? 'tmp'
      if a:1 == 'SB' | return "" | else | return 'T' | endif
    endif
    if ! exists("g:tbSessionWName")  | let g:tbSessionWName = trim(system("tmux display-message -p -t $TMUX_PANE -F '#W'")) | endif
    if g:tbSessionWName =~? "^" . g:TBSessionName
      if a:1 == 'SB' | return "" | else | return 'W' | endif
    elseif g:TBSessionName =~? "^" . g:tbSessionWName
      if a:1 == 'SB' | return "" | else | return 'W-' . substitute(g:TBSessionName, g:tbSessionWName . '-*', '', 'g') | endif
    endif
  endif
  return g:TBSessionName
endfunction " }}}
function! TBSessGetFile(auto_save, local) " {{{
  let l:ret = TBSessGetName()
  if l:ret == "" | return "" | endif
  if a:local == 1 || l:ret == "Session"
    let l:ret = substitute(l:ret, "--.*", "", "")
    if isdirectory(".vim") | let l:ret = "./.vim/" . substitute(l:ret, "Session-?", "", "")
    elseif l:ret !~ "Session" | let l:ret = "Session-" . l:ret
    endif
  endif
  if a:auto_save == 1 | let l:ret .= ".as" | endif
  let l:ret .= ".vim"
  return l:ret
endfunction
command! -nargs=? TBSessGetFile call TBSessGetFile(<f-args>) " }}}
function! TBSessUpdate(...) " {{{
  if ! exists("g:TBSessionName") | return | endif
  let l:delta = 60 * 60
  if exists("g:TBSessionSaveTimeDelta") | let l:delta = g:TBSessionSaveTimeDelta | endif
  if !exists("g:TBSessionSaveTimeLast") | let g:TBSessionSaveTimeLast = 0 | endif
  if g:TBSessionSaveTimeLast + l:delta < localtime()
    call TBSessSave(TBSessGetName(), 1)
  endif
endfunction " }}}
function! TBSessFiles(A, L, P) " {{{
  return system("cd $VIM_SESSIONS_PATH && ls *.vim 2>/dev/null | command grep -vF '.as' | sed -e 's/\.vim//g'")
endfunction " }}}
function! TBSessSave(...) " {{{
  let l:sessionName = ""
  let l:pwd = getcwd()
  let l:sessionDir = l:pwd
  if exists("g:TBSessionDir") && isdirectory(g:TBSessionDir) | let l:sessionDir = g:TBSessionDir
  else | let g:TBSessionDir = l:sessionDir
  endif
  if a:0 >= 1
    let l:sessionName = a:1
  else
    let l:sessionName = TBSessGetName()
    if l:sessionName == "" | let l:sessionName = $VIM_SESSION_NAME | endif
    if l:sessionName == "" | let l:sessionName = "Session-" . strftime("%Y%m%d-%H%M%S") | endif
  endif
  let g:TBSessionName = l:sessionName
  let l:auto_save = (a:0 >= 2) ? a:2 : 0
  let l:filename_vsd = TBSessGetFile(l:auto_save, 0)
  execute "lcd " . l:sessionDir
  execute "mksession! " . l:filename_vsd
  if l:auto_save == 1 | let g:TBSessionSaveTimeLast = localtime() | endif
  if l:sessionName != "Session"
    let l:filename_cwd = TBSessGetFile(l:auto_save, 1)
    call system("mv " . l:filename_vsd . " $VIM_SESSIONS_PATH/")
    call system("ln -sf $VIM_SESSIONS_PATH/" . l:filename_vsd . " " . l:filename_cwd)
  endif
  execute "lcd " . l:pwd
endfunction
command! -nargs=? -complete=custom,TBSessFiles TBSessSave call TBSessSave(<f-args>) " }}}
function! TBSessLoad(sessionName) " {{{
  let g:TBSessionName = a:sessionName
  let l:filename_vsd = TBSessGetFile(0, 0)
  let l:filename_cwd = TBSessGetFile(0, 1)
  call system("ln -sf $VIM_SESSIONS_PATH/" . l:filename_vsd . " " . l:filename_cwd)
  execute "source " . l:filename_cwd
endfunction
command! -nargs=1 -complete=custom,TBSessFiles TBSessLoad call TBSessLoad(<f-args>) " }}}
" }}}
" Open corresponding cpp/hpp/c/h file in a split # {{{
function! TBOpenFile(...)
    let ext  = expand('%:e')
    let file = expand('%:r')
    if l:ext == 'h' || l:ext == 'hpp'
      let l:ext = 'c'
    elseif l:ext == 'c' || l:ext == 'cpp' || l:ext == 'cc'
      let l:ext = 'h'
    else
      return
    endif
    if filereadable(l:file . '.' . l:ext)            | let file .= '.' . l:ext
    elseif filereadable(l:file . '.' . l:ext . 'pp') | let file .= '.' . l:ext . 'pp'
    elseif filereadable(l:file . '.' . l:ext . 'h')  | let file .= '.' . l:ext . 'h'
    else
      if expand('%:p:.') =~ "^/" | return | endif
      let file = expand('%:t:r')
      let p = ""
      let p_fmt = '%:p:.:h'
      let cnt = 3
      if exists('g:TBOpenFileMaxUp') | let cnt = g:TBOpenFileMaxUp | endif
      if a:0 > 0 | let cnt = a:1 | endif
      while l:cnt > 0
        let p = expand(l:p_fmt . ':h')
        if l:p == "." | break | endif
        let p_fmt .= ':h'
        let cnt -= 1
      endwhile
      let res = glob(l:p . "/**/" . l:file . '.' . l:ext . '*')
      if empty(l:res) | return | endif
      let file = split(l:res)[0]
    endif
    execute 'edit ' . l:file
endfunction
" }}}
" Resizing splits {{{
function! Resize(dir) " {{{
  let c = v:count
  let this = winnr()
  if 'down' == a:dir
    execute "normal \<c-w>k"
    if winnr() != this
      execute "normal " . l:c . "\<c-w>-"
      execute "normal \<c-w>j"
    else
      execute "normal \<c-w>j"
      if winnr() != this
        execute "normal \<c-w>k"
        execute "normal " . l:c . "\<c-w>+"
      endif
    endif
  elseif 'up' == a:dir
    execute "normal \<c-w>k"
    if winnr() != this
      execute "normal " . l:c . "<c-w>+"
      execute "normal \<c-w>j"
    else
      execute "normal! \<c-w>j"
      if winnr() != this
        execute "normal \<c-w>k"
        execute "normal " . l:c . "\<c-w>-"
      endif
    endif
  elseif 'left' == a:dir
    execute "normal \<c-w>h"
    if winnr() != this
      execute "normal " . l:c . "\<c-w><"
      execute "normal \<c-w>l"
    else
      execute "normal \<c-w>l"
      if winnr() != this
        execute "normal \<c-w>h"
        execute "normal " . l:c . "\<c-w><"
      endif
    endif
  elseif 'right' == a:dir
    execute "normal \<c-w>h"
    if winnr() != this
      execute "normal " . l:c ."\<c-w>>"
      execute "normal \<c-w>l"
    else
      execute "normal \<c-w>l"
      if winnr() != this
        execute "normal \<c-w>h"
        execute "normal " . l:c . "\<c-w>>"
      endif
    endif
  endif
endfunction " }}}
if has('unix')
    nnoremap <silent> jj :silent :<C-U>call Resize('down')<CR>
    nnoremap <silent> kk :silent :<C-U>call Resize('up')<CR>
    nnoremap <silent> hh :silent :<C-U>call Resize('left')<CR>
    nnoremap <silent> ll :silent :<C-U>call Resize('right')<CR>
else
    nnoremap <M-j><M-j> :silent :<C-U>call Resize('down')<CR>
    nnoremap <M-k><M-k> :silent :<C-U>call Resize('up')<CR>
    nnoremap <M-h><M-h> :silent :<C-U>call Resize('left')<CR>
    nnoremap <M-l><M-l> :silent :<C-U>call Resize('right')<CR>
endif
" }}}
" TabEdit - relative {{{
function! RelTabEdit(file)
  let l:p = fnamemodify(expand(a:file), ":~:.")
  execute "tabedit " . l:p
endfunction
" }}}
" Command output redirecting {{{
function! TabMessage(cmd)
  if a:cmd =~ '!.*'
    tabnew
    silent execute 'read ' . a:cmd
  else
    redir => message
    silent execute a:cmd
    redir END
    tabnew
    silent put=message
  endif
  set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
" }}}
" Toggle line number mode {{{
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
nnoremap <F12><C-n> :call NumberToggle()<cr>
" }}}
" acm execute {{{
function! TBACMRun()
  execute "!./a.out <" . expand("%") . ".txt"
endfunction
" }}}
" Scratch Buffers {{{
command! SaveTmp if &buftype == 'nofile' | setlocal buftype= | endif | let ft=&filetype | if ft == '' | let ft='tmp' | elseif ft == 'default' || ft == 'text' | let ft='txt' | endif | execute 'save' . tempname() . '.' . ft
nnoremap <silent> <F12>cs :execute 'SaveTmp'<CR>
command! FastBuffer    setlocal buftype= bufhidden=hide noswapfile cursorline | noremap <buffer> q<CR> :quit!<CR>    | noremap qq<CR> :quitall!<CR> | execute "noremap <buffer> <special> <silent> \<F12\>cF :execute 'ScratchBuffer'<CR>"
command! FastVim       setlocal buftype= bufhidden=hide noswapfile cursorline | noremap          q<CR> :quit!<CR>    | noremap qq<CR> :quitall!<CR> | execute "noremap <buffer> <special> <silent> \<F12\>cF :execute 'ScratchBuffer'<CR>"
command! FastVimSave   noremap          q<CR> :xa!<CR>      | noremap qq<CR> :quitall!<CR> | execute "noremap <buffer> <special> <silent> \<F12\>cF :execute 'ScratchBuffer'<CR>"
command! ScratchBuffer execute 'FastBuffer' | setlocal buftype=nofile | execute "noremap <buffer> <special> <silent> \<F12\>cF :execute 'FastBuffer'<CR>"
command! NormClipboard unmap y                 |  unmap Y
" }}}
" Building {{{
function! TBBldGetMakefile() " {{{
  let makeTypes = [ 'c', 'cpp' ]
  if index(l:makeTypes, &filetype) == -1 | return '' | endif 
  let makeCompiler = ''
  if expand('%:h') != '.' && !empty(glob(expand('%:h').'/Makefile')) | let makeCompiler = 'make -C ' . expand('%:h')
  elseif !empty(glob('Makefile')) | let makeCompiler = 'make'
  endif
  return l:makeCompiler
endfunction " }}}
function! TBBldGetMakefileTargets(makeCompiler) " {{{
  let makeCompl = '/usr/share/bash-completion/completions/make'
  let sedParams = '-nrf'
  if $IS_MAC == 'true' " {{{
    let makeCompl = $RUNTIME_PATH . '/completion.d/ports.completions/make'
    let sedParams = '-nf'
  endif " }}}
  return split(system(
        \ 'source ' . l:makeCompl . '; ' .
        \ a:makeCompiler . ' -npq .DEFAULT 2>/dev/null ' .
        \ '| sed ' . l:sedParams . ' <(_make_target_extract_script --) ' .
        \ '| sort -u' .
        \ '| tr "\\n" " "'
        \ ))
endfunction " }}}
function! TBBldFileCompl(A, L, P) " {{{
  let l:out = [ '-r', '-d' , '-sh', '-cpp', '-' ]
  let makeCompiler = TBBldGetMakefile()
  if !empty(l:makeCompiler)
    let l:out += TBBldGetMakefileTargets(l:makeCompiler)
  endif
  if a:A != ""
    let out = filter(l:out, 'v:val =~ "^" . a:A')
  endif
  return l:out
endfunction " }}}
function! TBBldFile(...) " {{{
  let params = split(join(a:000))
  let run = 0
  let runParam = 0
  let dbg = 0
  let ftype = &filetype
  let findMakefile = 1
  for i in params " {{{
    if     i == '-r'   | let run = 1 | let runParam = 1 | unlet params[0]
    elseif i == '-d'   | let dbg = 1 | unlet params[0]
    elseif i == '-sh'  | let ftype='sh' | unlet params[0]
    elseif i == '-cpp' | let findMakefile = 0 | unlet params[0]
    elseif i == '-'    | unlet params[0] | break
    else               | break
    endif
  endfor " }}}
  if !empty(params) | let run = 1 | endif
  let shTypes = [ 'sh', 'default' ]
  let makeCompiler = ''
  if l:findMakefile == 1 && index(l:shTypes, l:ftype) == -1 | let makeCompiler = TBBldGetMakefile() | endif
  if index(l:shTypes, l:ftype) != -1 " {{{
    let compiler = '%w !clear; bash'
    if l:dbg == 1 | let compiler .= ' -xv' | endif
    let compiler .= ' -s - ' . join(l:params)
    execute l:compiler
    " }}}
  elseif !empty(l:makeCompiler) " {{{
    let l:targets = TBBldGetMakefileTargets(l:makeCompiler)
    if index(l:targets, expand('%:r')) != -1 | let l:makeCompiler .= ' TARGET=' . expand('%:r') | endif
    if l:runParam == 1 | let l:params = [ "run" ] + l:params | execute 'silent !clear' | redraw! | endif
    echomsg "Building as '" . l:makeCompiler . ' ' . join(l:params) . "'"
    execute l:makeCompiler . ' ' . join(l:params)
    " }}}
  elseif l:ftype == 'c' || l:ftype == 'cpp' " {{{
    let compiler = ''
    if   l:ftype == 'c' | let compiler = 'clang -std=c99'
    else                | let compiler = 'clang++ -std=c++11 -Wno-deprecated'
    endif
    if l:dbg == 1 | let compiler .= ' -g -O0' | endif
    let outFile = expand('%:r') . '.out'
    let compiler .= ' -Wall -o ' . l:outFile . ' ' . expand('%')
    echomsg "Building as '" . l:compiler . "'"
    if l:run == 1 " {{{
      echomsg "Running as '" . l:outFile . ' ' . join(l:params) . "'"
      execute '!' . l:compiler . ' && { clear; ' . l:outFile . ' ' . join(l:params) . '; }'
      " }}}
    else " {{{
      execute "cexpr system('" . l:compiler . "')"
    endif " }}}
    " }}}
  else " {{{
    echoerr "Could to find compiler for file type '" . l:ftype . "'"
  endif " }}}
  return
endfunction " }}}
command! -nargs=? -complete=customlist,TBBldFileCompl Bld call TBBldFile(<f-args>)
" }}}
" Status Bar {{{
function! TBSBGitStatus() " {{{
  if has('gui_running') | return | endif
  let ret = FugitiveStatusline()
  if empty(l:ret) | return '' | endif
  if ! exists('g:GitShowStatus') || g:GitShowStatus == 0 | return l:ret | endif
  let dir = FugitiveWorkTree()
  if empty(l:dir) | return l:ret | endif
  if l:ret =~# '^\x\{7,\}$'
    if !exists('g:GitName') | let g:GitName = {} | endif
    if !has_key(g:GitName, l:ret)
      let git_dir = l:dir . '/.git'
      let head = system('git --work-tree=' . l:dir . ' --git-dir=' . l:git_dir . ' name-rev HEAD' . " | head -n1 | awk '{print $2'}")[0:-2]
      let g:GitName[l:ret] = substitute(l:head, '\C^\%(heads/\|remotes/\|tags/\)\=', '', '')
    endif
    let l:ret = g:GitName[l:ret]
  endif
  if !exists('g:GitStatusDict') || !has_key(g:GitStatusDict, l:dir) | call TBUpdateGitStatus() | endif
  let st = g:GitStatusDict[l:dir]
  if empty(l:st) | let st = '=' | endif
  return l:ret . ':' . l:st
endfunction " }}}
function! TBUpdateGitStatus() " {{{
  if has('gui_running') | return | endif
  if ! exists('g:GitShowStatus') || g:GitShowStatus == 0 | return | endif
  let dir = FugitiveWorkTree()
  if empty(l:dir) | return | endif
  if !exists('g:GitStatusDict') | let g:GitStatusDict = {} | endif
  let git_dir = l:dir . '/.git'
  let st = ''
  call system('git --work-tree=' . l:dir . ' --git-dir=' . l:git_dir . ' diff --quiet')
  if v:shell_error != 0 | let st .= '*' | endif
  call system('git --work-tree=' . l:dir . ' --git-dir=' . l:git_dir . ' diff --cached --quiet')
  if v:shell_error != 0 | let st .= '+' | endif
  let g:GitStatusDict[l:dir] = l:st
endfunction " }}}
function! TBSBExtraInfo() " {{{
  let ret = ''
  let sName = TBSessGetName('SB-e')
  if $TERMINAL_HAS_EXTRA_CHARS != 'false'
    if     l:sName == 'W'    | let ret .= ' 𝑆'  |
    elseif l:sName =~ 'W-.*' | let ret .= ' 𝑆:' . substitute(l:sName, 'W-*', '', '') |
    elseif l:sName == 'S'    | let ret .= ' 𝑆𝑆' |
    elseif l:sName == 'T'    | let ret .= ' 𝑇'  |
    endif
    if &list  == 1 | let ret .= ' ¶' | endif
    if &wrap  == 1 | let ret .= ' ↵' | endif
    if &spell == 1 | let ret .= ' ✘' | endif
    if     &filetype == 'default' | let ret .= ' ⅅ' |
    elseif &filetype == 'log'     | let ret .= ' ℒ' |
    elseif &filetype == 'log2'    | let ret .= ' ℒ2' |
    endif
  else
    if     l:sName == 'W' | let ret .= ' S'  |
    elseif l:sName == 'S' | let ret .= ' SS' |
    elseif l:sName == 'T' | let ret .= ' T'  |
    endif
    if &list  == 1 | let ret .= ' P' | endif
    if &wrap  == 1 | let ret .= ' W' | endif
    if &spell == 1 | let ret .= ' S' | endif
    if     &filetype == 'default' | let ret .= ' D' |
    elseif &filetype == 'log'     | let ret .= ' L' |
    elseif &filetype == 'log2'    | let ret .= ' L2' |
    endif
  endif
  return l:ret[1:]
endfunction " }}}
function! TBSBFilename(mode) " {{{
  let fName = substitute(expand('%'),'^\./\(.*\)', '\1', '')
  let ret = ''
  let predefined = {
        \ 'nofile'    : '[Scratch]',
        \ 'qf'        : '[QuickFix]',
        \ 'help'      : '[Help]',
        \ 'emptyfile' : '[ScratchFile]',
        \ }
  if has_key(l:predefined, &buftype) | let ret = l:predefined[&buftype]
  elseif l:fName == '' | let ret = l:predefined['emptyfile']
  endif
  if a:mode == 0
    if l:ret != '' | let ret = ' ' . l:ret . ' ' | endif
    return l:ret
  elseif l:ret != ''
    return ''
  endif
  let maxLen = 50
  if exists("g:TBSBMaxLen") | let maxLen = g:TBSBMaxLen | endif
  if exists("g:TBSBFull") && g:TBSBFull == 1 | let maxLen = 500 | endif
  if strlen(l:fName) > l:maxLen
    let fName = substitute(l:fName,'\([^/]*\)/.*/\(.*\)', '\1/.../\2', 'g')
    let fNameFull = expand('%:p')
    if fNameFull =~ '^' . getcwd() && getcwd() != $HOME
      " nop
    elseif fNameFull =~ '^' . $HOME
      let firstDir = substitute(l:fNameFull, $HOME . '\(/[^/]*\)/.*', '\1', 'g')
      let fName = '~' . l:firstDir . l:fName
    elseif fNameFull =~ '^[a-z0-9]\+://'
      let host = substitute(l:fNameFull, '[a-z0-9]\+://\%([^/]*@\)\{0,1\}\([^/]*\)/.*', '\1', 'g')
      let fName = substitute(l:fName,'\([^/]*\)/.*/\(.*\)', '\2', 'g')
      let fName = l:host . ':/.../' . l:fName
    else
      let firstDir = substitute(l:fNameFull,'\(/[^/]*\)/.*', '\1', 'g')
      let fName = l:firstDir . l:fName
    endif
  endif
  return ' ' . l:fName . ' '
endfunction " }}}
function! TBSBFilenameToggle() " {{{
  if ! exists("g:TBSBFull") || g:TBSBFull == 0
    let g:TBSBFull = 1
  else
    let g:TBSBFull = 0
  endif
endfunction " }}}
nnoremap <silent> <F12>cf :silent call TBSBFilenameToggle()<CR>
" }}}
" Conceals " {{{
function! TBToggleGroupConceal(group) " {{{
  redir => syntax_def
  exe 'silent syn list' a:group
  redir END
  let lines = split(syntax_def, "\n")
  exe 'syn clear' a:group
  for line in lines
    if line =~ a:group
      let type = substitute(line, '\v' . a:group . '\s+xxx\s+(\k+)\s+(.*)', '\1', '')
      if type == 'match'
        let args = substitute(line, '\v' . a:group . '\s+xxx\s+(\k+)\s+(.*)', '\2', '')
      else
        let args = substitute(line, '\v' . a:group . '\s+xxx\s+(.*)', '\1', '')
        if args =~ 'start' && args =~ 'end'
          let type = 'region'
        endif
      endif
      if args =~ 'conceal'
        exe 'syn' type a:group substitute(args, ' conceal', '', '')
      else
        exe 'syn' type a:group args 'conceal cchar=♦'
      endif
    endif
  endfor
endfunction " }}}
function! TBSkipConceal(count, dir) " {{{
  let cnt = a:count
  let c   = col('.')
  let l   = line('.')
  let lc  = 1
  if a:dir == 1 | let lc = col('$') | endif
  while cnt && c != lc
    let c += a:dir
    if stridx(&concealcursor, 'n') != -1 && synconcealed(l, c)[0] == 1
      while c != lc && synconcealed(l, c)[0] | let c += a:dir | endwhile
    endif
    let cnt -= 1
  endwhile
  if a:dir == 1 | exec "normal! ".(c-col('.'))."l"
  else          | exec "normal! ".(col('.')-c)."h"
  endif
endfunction " }}}
nnoremap <silent> l :<C-U>call TBSkipConceal(v:count1,  1)<CR>
nnoremap <silent> h :<C-U>call TBSkipConceal(v:count1, -1)<CR>
" }}}
" Tmux Split {{{
function! TBTmuxSplit(...) " {{{
  let params = {}
  if a:0 >= 1 | let l:params = a:1 | endif
  let fdir = expand('%:p:h')
  if empty(l:fdir) | let fdir = getcwd() | endif
  let p    = 30
  let dir  = '-v'
  let epar = ''
  let wnd  = 0
  if has_key(l:params, 'd')
    if     l:params['d'] == '-' || l:params['d'] == 'v' | let dir='-v' | let p=30
    elseif l:params['d'] == '|' || l:params['d'] == 'h' | let dir='-h' | let p=50
    endif
  endif
  if has_key(l:params, 'wnd') | let wnd  = l:params['wnd'] | endif
  if has_key(l:params, 'dir') | let fdir = l:params['dir'] | endif
  if has_key(l:params, 'p')   | let p    = l:params['p']   | endif
  if has_key(l:params, 'par') | let epar = l:params['par'] | endif
  if $TMUX_VERSION >= 34
    let p = '-l ' . l:p . '\%'
  else
    let p = '-p' . l:p
  endif
  if l:wnd == 0
    execute 'silent !tmux split-window ' . l:dir . ' ' . l:p . ' -c "' . l:fdir . '"' . ' ' . l:epar
  else
    execute 'silent !tmux new-window -a -c "' . l:fdir . '"' . ' ' . l:epar
  endif
  redraw!
endfunction " }}}
nnoremap <silent> <C-q>-    :call TBTmuxSplit({'d': '-'})<CR>
nnoremap <silent> <C-q>\    :call TBTmuxSplit({'d': '<Bar>'})<CR>
nnoremap <silent> <C-q>l    :call TBTmuxSplit({'d': '<Bar>', 'par': 'git l ' . expand('%:t')})<CR>
nnoremap <silent> <C-q>L    :call TBTmuxSplit({'d': '<Bar>', 'par': 'git l ' . expand('%:p:h')})<CR>
nnoremap <silent> <C-q><CR> :call TBTmuxSplit({'wnd': '1'})<CR>
" }}}
" Send To Pane " {{{
function! TBSendToPaneCompl(A, L, P) " {{{
  if $IS_MAC == 'true' | let l:cmd = "pstree $p | command grep -q '[M]acOS/Vim'"
  else                 | let l:cmd = "pstree -Ac $p | command grep -q -e '---vim'"
  endif
  let l:out = split(system(
    \ ""
    \ . "idd=$(tmux display-message -p '#S:#I.#P');"
    \ . "while read id p; do"
    \ . "  [[ $id != $idd ]] && " . l:cmd . " && echo $id;"
    \ . "done < <(tmux list-panes -a -F '#S:#I.#P #{pane_pid}')"
    \ ))
  if a:A != "" | let out = filter(l:out, 'v:val =~ "^" . a:A') | endif
  return l:out
endfunction " }}}
function! TBSendToPane(...) " {{{
  let t = "." . v:count1
  if a:0 >= 1 && a:1 != "" | let t = a:1 | endif
  if l:t !~ ".*\..*" | let t .= ".1" | endif
  let f = expand('%:p')
  if filereadable(l:f)
    silent execute '!$ALIASES_SCRIPTS/fzf-tools/fzf-exe.sh -c pane --pane ' . l:t . ' -f ' . shellescape(l:f)
    execute ':redraw!'
  else
    echom "Not existing file [" . l:f . "]"
  endif
endfunction " }}}
command! -nargs=? -complete=customlist,TBSendToPaneCompl TBSendToPane call TBSendToPane(<q-args>)
nnoremap     <F2>  <C-w>gF
nnoremap <silent>  <Leader><F2> :<C-u>TBSendToPane<CR>
nnoremap <F12><F2> :<C-u>TBSendToPane 
" }}}
" Log Inserter " {{{
function! TBInsertLog(...) " {{{
  let id = $ISSUE
  if !empty(l:id) | let id = ' [' . l:id . ']' | endif
  if len(a:000) > 1 || get(a:000, 0) == '-' " {{{
    if ! exists("g:TBLogMap") | let g:TBLogMap = {} | endif
    let id = 0
    if get(a:000, 0) == '-' | let id = 1 | endif
    let key = a:000[l:id]
    if l:key !~ '.*\.\*.*' | let key = ".*/" . l:key . "/.*" | endif
    call extend(g:TBLogMap, { l:key: {
          \ 'cmd'  : get(a:000, l:id + 1, ''),
          \ 'style': get(a:000, l:id + 2, '') }})
    return 0
  endif " }}}
  let commentType = "#"
  let ft=&filetype
  if index(["c", "cpp"], ft) >= 0
    let commentType = "//"
  elseif index(["vim"], ft) >= 0
    let commentType = '"'
  endif
  if get(a:000, 0) == 'DBG' " {{{
    let line = "\<ESC>mmA " . l:commentType . " TB] Dbg" . l:id . "\<ESC>`mmm"
    if mode() == 'i' | let line .= 'i' | endif
    return l:line
  endif " }}}
  let type  = get(a:000, 0, 'II')
  let cmd   = $VIM_LOG_DEFAULT_COMMAND
  let style = $VIM_LOG_DEFAULT_STYLE
  let file  = expand("%")
  let map   = eval('{' . $VIM_LOG_MAP . '}')
  let found = 0
  let duplicate = 0
  let keyLen = 0
  if empty(l:cmd)   | let cmd   = 'printf(' | endif
  if empty(l:style) | let style = 'c'       | endif
  if exists("g:TBLogMap") | call extend(l:map, g:TBLogMap) | endif
  if l:type == 'DUPL'
    let type = 'II'
    let duplicate = 1
  endif
  for [k, v] in items(l:map)
    if l:file =~ l:k && len(l:k) >= l:keyLen
      let found = 1
      if has_key(l:v, 'cmd')   && !empty(l:v['cmd'])   | let cmd   = l:v['cmd']   | endif
      if has_key(l:v, 'style') && !empty(l:v['style']) | let style = l:v['style'] | endif
      let keyLen = len(l:k)
    endif
  endfor
  if ! l:found && exists("g:TBLogFallback")
    let style = 'fallback'
    let cmd   = g:TBLogFallback
  endif
  let cmd .= '"TB]' . l:id . ' ' . l:type . ' '
  let len = len(l:cmd)
  if (l:type == 'EE' || l:type == 'TT')
    let l:space = ''
    if (l:type == 'EE' ) | let l:space = ' ' | endif
    if     l:style == 'c'   | let cmd .= l:space . '[%s(): %s:%d]", __func__, __FILE__, __LINE__);'
    elseif l:style == 'cpp' | let cmd .= l:space . '[" << __func__ << "(): " << __FILE__ << ":" << __LINE__ << "]");'
    elseif l:style == 'js'  | let cmd .= l:space . '#' . expand('%:t') . ':' . (line('.')+1) . '");'
    endif
  else
    let cmd .= '");'
  endif
  let cmd .= ' ' . l:commentType . ' TB] Dbg' . l:id
  let @9 = l:cmd
  " Insert space and delete it (keep indent), Paste Reg#9, Press esc, go to the beginning, move right nth. and change mode to insert
  let cmd = " \<BS>" . "\"9p" . "\<ESC>^" . l:len . 'l'
  if (l:type != 'TT' && l:type != 'DUPL') | let cmd .= 'i' | endif
  if mode() != 'i'
    if l:type == 'BB' | let cmd = 'O' . l:cmd
    else              | let cmd = 'o' . l:cmd
    endif
  endif
  if l:duplicate
    " Go to the beginnning of current line, find '"", move left, yank to Reg#Z to ';'
    let cmd = "|" . "f\"l" . "\"zyf;" . l:cmd
    " Exit from insert mode, paste Reg#Z, delete till ';'
    let cmd .= "\<ESC>" . "\"zp" . "dt;"
  endif
  return l:cmd
endfunction " }}}
nnoremap <expr> <Leader>\tb TBInsertLog("BB")
nnoremap <expr> <Leader>\ta TBInsertLog("AA")
nnoremap <expr> <Leader>\ti TBInsertLog("II")
nnoremap <expr> <Leader>\te TBInsertLog("EE")
nnoremap <expr> <Leader>\tt TBInsertLog("TT")
nnoremap <expr> <Leader>\td TBInsertLog("DBG")
nnoremap <expr> <Leader>\tD TBInsertLog("DUPL")
" }}}
" Clipboard helpers {{{
function! ClipStore(reg)
  if $CLIP_FILE == "" | return | endif
  call writefile(getreg(a:reg, 1, 1), $CLIP_FILE . ".vim", "s")
  let out = system("$ALIASES xclip --put $CLIP_FILE.vim")
endfunction
function! ClipPaste(cmd, clip)
  if has('gui_running') || $TMUX == ""
    exec "normal \"+" . a:cmd
    return
  endif
  let y_store = @y
  if a:clip == "-"
    let @y = system("tmux show-buffer")
  else
    let @y = system("tmux show-buffer -b " . a:clip)
  endif
  exec "normal \"y" . a:cmd
  let @y = l:y_store
endfunction
" }}}
" Oth {{{
command! -nargs=1 VG lvimgrep /<args>/j %:p:~:. <Bar> lopen
command! FPdf execute("hardcopy >$TMP_MEM_PATH/%:t:r.ps | !ps2pdf $TMP_MEM_PATH/%:t:r.ps %:p:r.pdf")
nnoremap vg :VG 
nnoremap v/ :VG <C-R><C-R>/<CR>
" }}}
" }}}
" Abbreviations {{{
iabbr /** /************************************************************************
iabbr **/ ************************************************************************/
iabbr //- //-----------------------------------------------------------------------
" }}}
" Mappings {{{
" To small to catalogue {{{
nnoremap <silent> <F12>cl       :if &conceallevel == 1 <Bar> setlocal conceallevel=0 <Bar> else <Bar> setlocal conceallevel=1 <Bar> endif<CR>
nnoremap <silent> <F12>gf       :execute 'silent !tmux set-buffer "' . expand('%:p:~') . '"' <Bar> redraw!<CR>
nnoremap          <F12>h        :Map<CR>
nnoremap          <Leader>ttt   :terminal<CR>
nnoremap <silent> <F6>          :redraw!<CR>
nnoremap <silent> <F12>s        :exe "tabn " . g:LastTab <BAR> let this_tab = bufname('%') <BAR> exe "tabn " . g:LastTab <BAR> exe 'vsplit ' . this_tab <BAR> exe "tabclose " . g:LastTab <BAR> unlet this_tab<CR>
nnoremap <silent> <leader>\cd   :cd $PWD<CR>
" <c-i> is the same as <tab> and tab is changed to "%", thus <c-l> map the
" behaviour of <c-i>, i.e. jump to newer cursor position in jump list
noremap           <c-l>   <c-i>
nnoremap <silent> <Leader>cf  :let @f = expand("%")   <BAR> let @+=@f<CR>
nnoremap <silent> <Leader>cF  :let @f = expand("%:t") <BAR> let @+=@f<CR>
nnoremap <silent> <Leader>cFF :let @f = expand("%:p") <BAR> let @+=@f<CR>
vnoremap <CR> y
" }}}
" cd # {{{
nnoremap <silent> <Leader>tcd  :execute "tcd " . expand("%:p:h")<CR>
nnoremap <silent> <Leader>lcd  :execute "tcd " . expand("%:p:h")<CR>
nnoremap <silent> <Leader>mcd  :execute "cd "  . g:TBSessionDir<CR>
" }}}
" Arrow keys disabled {{{
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
" }}}
" Quit vim {{{
nnoremap <silent> ZZZ    :xa!<CR>
nnoremap <silent> ZQQ    :qa!<CR>
" }}}
" Execute last macro {{{
nnoremap Q @@
" }}}
" todo {{{
nmap todo A // TODO:
nmap TODO O/*<CR>TODO: <CR>*/k$
" }}}
" Insert with "debug" suffix # {{{
nnoremap <Leader>dd o//TB] Dbg<Esc>4bi
nnoremap <Leader>da A //TB] Dbg<Esc>
" }}}
" adds space&co before and after cursor/selection {{{
nnoremap <Leader><space> i a 
vnoremap <Leader><space> `<i `>la hv`<l

nmap <Leader><space>( viw<Leader><space>(
nmap <Leader><space>[ viw<Leader><space>[
nmap <Leader><space>{ viw<Leader><space>{
nmap <Leader><space>< viw<Leader><space><
nmap <Leader><space>" viw<Leader><space>"
nmap <Leader><space>' viw<Leader><space>'
nmap <Leader><space>` viw<Leader><space>`
nmap <Leader><space>p viw<Leader><space>p

nmap 2<Leader><space>( viw2<Leader><space>(
nmap 2<Leader><space>[ viw2<Leader><space>[
nmap 2<Leader><space>{ viw2<Leader><space>{
nmap 2<Leader><space>< viw2<Leader><space><
nmap 2<Leader><space>" viw2<Leader><space>"
nmap 2<Leader><space>' viw2<Leader><space>'
nmap 2<Leader><space>` viw2<Leader><space>`
nmap 2<Leader><space>p viw2<Leader><space>p

nmap <Leader>g( gv<Leader><space>(
nmap <Leader>g[ gv<Leader><space>[
nmap <Leader>g{ gv<Leader><space>{
nmap <Leader>g< gv<Leader><space><
nmap <Leader>g" gv<Leader><space>"
nmap <Leader>g' gv<Leader><space>'
nmap <Leader>g` gv<Leader><space>`
nmap <Leader>gp viw<Leader><space>p

vnoremap <Leader><space>( `<i(`>la)hv`<l
vnoremap <Leader><space>[ `<i[`>la]hv`<l
vnoremap <Leader><space>{ `<i{`>la}hv`<l
vnoremap <Leader><space>< `<i<`>la>hv`<l
vnoremap <Leader><space>" `<i"`>la"hv`<l
vnoremap <Leader><space>' `<i'`>la'hv`<l
vnoremap <Leader><space>` `<i``>la`hv`<l
vnoremap <Leader><space>p `>p`.hm>`<P`]l

vmap 2<Leader><space>( <Leader><space>(gv<Leader><space>(
vmap 2<Leader><space>[ <Leader><space>[gv<Leader><space>[
vmap 2<Leader><space>{ <Leader><space>{gv<Leader><space>{
vmap 2<Leader><space>< <Leader><space><gv<Leader><space><
vmap 2<Leader><space>" <Leader><space>"gv<Leader><space>"
vmap 2<Leader><space>' <Leader><space>'gv<Leader><space>'
vmap 2<Leader><space>` <Leader><space>`gv<Leader><space>`
vmap 2<Leader><space>p <Leader><space>pgv<Leader><space>p
" }}}
" Comments {{{
" surrounds selected block with /*...*/
vnoremap /* `>a*/`<i/*
" adds // at the beginning of each line in the selected block
vnoremap // '<'>\|I//
" }}}
" Fold {{{
noremap  <Leader>{ mmA # {{{<ESC>`mmm
noremap  <Leader>} mmA # }}}<ESC>`mmm
vnoremap <Leader>{ <ESC>mm'<A # {{{<ESC>'>A # }}}<ESC>`mmm
vnoremap <Leader>} <ESC>mm'<A # {{{<ESC>'>A # }}}<ESC>`mmm
" }}}
" Show registers {{{
nnoremap <Leader>"" :registers<CR>
" }}}
" Use ; as : {{{
nnoremap ; :
" }}}
" Use space to open/close a fold # {{{
nnoremap <Space> za
vnoremap <Space> za
" }}}
" Copy & Pase line to system clipboard, etc {{{
nnoremap <silent> <Leader>y "+y$<bar>:call ClipStore("+")<CR>
nnoremap <silent> <Leader>Y g^"+y$<bar>:call ClipStore("+")<CR>
vnoremap <silent> <Leader>y "+y<bar>:call ClipStore("+")<CR>
vnoremap <silent> <Leader>Y $"+y<bar>:call ClipStore("+")<CR>
if $IS_DOCKER == "false"
  nnoremap <Leader>p "+p
  nnoremap <Leader>P "+P
  vnoremap <Leader>p "+p
  vnoremap <Leader>P "+P
else
  nnoremap <silent> <Leader>p :call ClipPaste("p", "-")<CR>
  nnoremap <silent> <Leader>P :call ClipPaste("P", "-")<CR>
  vnoremap <silent> <Leader>p :call ClipPaste("p", "-")<CR>
  vnoremap <silent> <Leader>P :call ClipPaste("P", "-")<CR>
endif
nnoremap <silent> <Leader><Leader>p :call ClipPaste("p", "clip")<CR>
nnoremap <silent> <Leader><Leader>P :call ClipPaste("P", "clip")<CR>
vnoremap <silent> <Leader><Leader>p :call ClipPaste("p", "clip")<CR>
vnoremap <silent> <Leader><Leader>P :call ClipPaste("P", "clip")<CR>
nnoremap <silent> <Leader><C-y> :call ClipStore("\"")<CR>
vnoremap <silent> <C-y> "+y<bar>:call ClipStore("+")<CR>
nmap Y y$
" }}}
" Clip file, open {{{
if $CLIP_FILE != ''
  nnoremap <silent> <Leader>co :call execute('tabedit ' . $CLIP_FILE)<CR>
endif " }}}
" copy with c-v in gui (insert mode) {{{
if has('gui_running')
  inoremap <Leader><c-v> <c-o>"+p
  nnoremap <Leader><c-v>      "+p
endif " }}}
" Fix for linewrapping: jump to the next/prev editor line (not physical) {{{
nnoremap <silent> j gj
nnoremap <silent> k gk
" }}}
" Tig {{{
nmap <Leader>gt :!command cd %:h && tig -- %:t<CR><CR>
" }}}
" Search for a file in git repo {{{
nnoremap ?? :GFiles<CR>
" }}}
" Scroll pages {{{
nnoremap <up>   
nnoremap <down> 
" }}}
" Tab key moves to the matched bracket {{{
if !exists("g:matchup_matchparen_status_offscreen")
  nnoremap <Tab> %
  vnoremap <Tab> %
endif
" }}}
" Help key disabled {{{
noremap <F1> <nop>
inoremap <F1> <nop>
" }}}
" replaces selected text with buffer {{{
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>
" }}}
" pressing < or > will let you indent/unident selected lines {{{
vnoremap < <gv
vnoremap > >gv
" }}}
" moving lines up and down {{{
nnoremap <silent> <C-j> :m .+1<CR>==
nnoremap <silent> <C-k> :m .-2<CR>==
vnoremap <silent> <C-j> :m '>+1<CR>gv=gv
vnoremap <silent> <C-k> :m '<-2<CR>gv=gv
" }}}
" Make tab in v mode work like I think it should (keep highlighting): {{{
" vmap <tab> >gv
" vmap <s-tab> <gv
" }}}
" Very magic searching {{{
" nnoremap / /\v
" vnoremap / /\v
" }}}
" Buffer naviation {{{
nmap <M-Left> :bprevious<CR>
nmap <M-Right> :bnext<CR>
" }}}
" Undo in insert mode. {{{
imap <c-z> <c-o>u
" }}}
" Searching {{{
nnoremap * *N
nnoremap <silent> + :let @/ .= '\\|\<'.expand('<cword>').'\>'<cr>
nnoremap <silent> *L *:lgrep // %<CR>:lopen<CR>
nnoremap <silent> *D *N:g//d<CR>
nnoremap <silent> DD  mz:g//d<CR>`z
nnoremap <silent> D!D mz:g!//d<CR>`z
" search for highlighted text {{{
vnoremap */ y/<C-R>"<CR>
" }}}
" }}}
" clear last search pattern {{{
nnoremap <silent> <F12><F12> :let @/ = ""<CR>
nnoremap <silent> //         :let @/ = ""<CR>
" }}}
" On Mac HOME key on external keyboard is recognized as <Help> {{{
nmap <Help>  i
imap <Help> <Esc>
vmap <Help> <Esc>i
" }}}
" Writes a files as root {{{
command! W execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" }}}
" next/prev line found using l[vim]grep {{{
nnoremap <S-Up> :lprev<CR>
nnoremap <S-Down> :lnext<CR>
nnoremap <C-Down> :cnext<CR>
nnoremap <C-Up> :cprev<CR>
nnoremap .< :lprev<CR>
nnoremap .> :lnext<CR>
nnoremap ,< :cprev<CR>
nnoremap ,> :cnext<CR>
nnoremap <Leader>Ln :lnext<CR>
nnoremap <Leader>Lp :lprev<CR>
nnoremap <Leader>Cn :cnext<CR>
nnoremap <Leader>Cp :cprev<CR>
" }}}
" Ack from search{{{
nnoremap <Leader>ack :AckFromSearch<cr>
" }}}
" tab next and tab prev {{{
nnoremap tn gt
nnoremap tp gT
nnoremap <silent> tH :-tabmove<CR>
nnoremap <silent> tL :+tabmove<CR>
nnoremap H gT
nnoremap L gt
nnoremap <Left> gT
nnoremap <Right> gt
nnoremap <silent> <S-Left> :tabmove -1<CR>
nnoremap <silent> <S-Right> :tabmove +1<CR>
" C-Left/C-Right{{{
if v:progname ==# "vim"
  if has('win16') || has('win32') || has('win64') || $TERM ==? "cygwin"
  else
    " C-Left
    nnoremap [D :tabp<CR>
    " C-Right
    nnoremap [C :tabn<CR>
  endif
endif
" }}}
" }}}
" Open tag in new tab {{{
nnoremap <Leader><C-]> <C-w><C-]><C-w>T
" }}}
" Go to the last tab {{{
let g:LastTab = 1
" nmap <silent> tl :echomsg "l-tab1:[" . g:LastTab . "]" <CR> | :exe "tabn ".g:LastTab <CR> | :echomsg "l-tab2:[" . g:LastTab . "]" <CR>
nmap <silent> tl :exe "tabn " . g:LastTab <CR>
" }}}
" Close all splits in the current window {{{
nnoremap <C-W>q <C-w>o <bar> ZQ
" }}}
" Open a Quickfix window for the last search. {{{
nnoremap <silent> <leader>q/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
" }}}
" shortcuts in diff {{{
au FilterWritePre * if &diff | exe 'nnoremap <space> ]cz.' | exe 'nnoremap <S-space> [cz.' | endif
" au FilterWritePre * if &diff | exe 'nexecute "normal \<c-w>\<c-w>"' | endif
au FilterWritePre * if &diff | exe 'nnoremap <C-L> :diffupdate<CR>' | endif
au FilterWritePre * if &diff | exe 'nnoremap =1 :do<CR>' | exe 'nnoremap =2 :dp<CR>' | endif
au FilterWritePre * if &diff | exe 'nnoremap =8 :vertical resize 82<CR>' | exe 'nnoremap =0 :execute "vertical resize " . (&columns+1)/2<CR>' | endif
" }}}
" configuration - <F12>c... {{{
" toggle current line highlight {{{
nmap <F12>cul :set cursorline!<CR>
nmap <F12>cuc :set cursorcolumn!<CR>
nmap <F12>cuC :set cursorcolumn! <Bar> :set cursorline!<CR>
nnoremap <silent> <Leader>l1  ml:execute 'match  _m1 /'.expand("<cword>").'/'<CR>
nnoremap <silent> <Leader>l2  ml:execute '2match _m2 /'.expand("<cword>").'/'<CR>
nnoremap <Leader>ll1 :match _m1 //<Left>
nnoremap <Leader>ll2 :match _m2 //<Left>
nnoremap <silent> <Leader>lL1 ml:execute 'match'<CR>
nnoremap <silent> <Leader>lL2 ml:execute '2match'<CR>
" }}}
" nowrap {{{
nmap <F12>cw :set wrap!<CR>
" }}}
" line marks {{{
nmap <silent> <F12>c8 :set list! <Bar> if &list <Bar> else <Bar> match <Bar> endif<CR>
nmap <silent> <F12>c* :set list <Bar> match ErrorMsg '\s\+$'<CR>
" }}}
" oth {{{
nmap <silent> <F12>c<space>
      \ :if maparg("<lt>space>","n") =~ "^za" <Bar> exe 'nnoremap <lt>silent> <lt>space> <lt>c-d>' <Bar>
      \ else <Bar> exe 'nnoremap <lt>silent> <lt>space> za' <Bar>
      \ endif<CR>
" }}}
" }}}
" build - <F12><F10>... {{{
nmap <F12><F10>t :!ctags -R --sort=yes --c-kinds=cdefglmnpstuvx --c++-kinds=cdefglmnpstuvx --Java-kinds=cfilmp --fields=+iaStnml --extra=+q --exclude=.svn --exclude=CVS . <CR>
nmap <F12><F10>s :!find . -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.java' > cscope.files; cscope -b <CR>
" save all and execute (BTV)
nmap <F12><F10>m :wa<CR>:make btv_tests<CR>
" acm maps - compile and execute
nmap <F12><F10>a :call TBACMMap()<CR>
function! TBACMMap()
  :set makeprg=gcc\ -lm\ -lcrypt\ -O2\ -pipe\ -ansi\ -DONLINE_JUDGE\ \%
  nmap <S-F10> :call TBACMRun()<CR>
  nmap <F10> :!./a.out<CR>
endfunction
" }}}
" tools - <F12>t... {{{
" Session Load & Save # {{{
nmap <silent> <F12>ts :if ! exists("g:TBSessionName") <Bar> let g:TBSessionName = "Session" <Bar> endif <Bar> call TBSessSave() <Bar> echomsg "Session stored as [" . TBSessGetName() . "]"<CR>
nmap <F12>tS :TBSessSave 
nmap <F12>tL :TBSessLoad 
" }}}
nmap <F12>fs :syntax sync minlines=500 <Bar> syn off <Bar> syn on <Bar> normal zv <CR>
nmap <F12>tvl :tabedit $MYVIMRC<CR>
nmap <F12>tvr :source $MYVIMRC<CR>
" }}}
" check spell {{{
nmap <F12>= :setlocal spell!<CR>
" }}}
" set file types {{{
nmap <F12>fl :set filetype=log<CR>
nmap <F12>fD :set filetype=default<CR>
" wiki page editing {{{
if has('win16') || has('win32') || has('win64')
  nmap <silent> <F12>fW :setfiletype Wikipedia<CR>
endif
" }}}
" }}}
" default makeprg {{{
nmap <S-F9> :call TBMake()<CR>
function! TBMake()
  let cwp=system('pwd')
  if cwp =~# ".*/g4" || cwp =~# ".*g4-7500" || cwp=~# ".*/browser/*"
    let &mp = 'touch $BUILDER_MAKE_BUILD_TRIGGER'
  elseif cwp =~# ".*/acm"
    let &mp = gcc\ -lm\ -lcrypt\ -O2\ -pipe\ -ansi\ -DONLINE_JUDGE\ \%
  endif
  :make
endfunction
" }}}
" execute current buffer {{{
nmap <F9>bb :Bld<CR>
nmap <F9>br :Bld -r<CR>
nmap <F9>ba :Bld -r 
nmap <F9>bd :Bld -d -r<CR>
nmap <F9>bs :Bld -sh -r<CR>
nmap <F9>   :Bld
" }}}
" Open corresponding header/implementation file {{{
nmap <Leader>e    :call TBOpenFile()<CR>
nmap <Leader>ve   <C-W><C-V><Bar>:call TBOpenFile()<CR>
" }}}
" }}}
" Menu {{{
" Menu - Substite {{{
nmenu My.Substitute.-SpacesAtTheEnd :%s/\v\s+$//g<CR>                                   " removes spaces at the end of lines
nmenu My.Substitute.-FileLoc :%s/^[^ :]\+:\d\+://<CR>                                   " removes file location (e.g. grep input)
nmenu My.Substitute.-EmptyLines :g/^\s*$/ d<CR>                                         " removes empty lines
nmenu My.Substitute.-Hashes :%s/^\x\{5,\}\~: //                                         " removes hash of a line
nmenu My.Substitute.-HiglightedTexts :%s///g<CR>                                        " removes highlighted text
nmenu My.Substitute.Tab2Spaces :%s/\t/  /<CR>                                           " replaces tabs with 2 spaces: [\t]->[  ]
nmenu My.Substitute.VIS-FirstLetterUpper :`<,`>s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<CR>       " makes First letter in a word uppercase, rest of them lowercase in a visual block
nmenu My.Substitute.ChangeSlashes :%s#\\#/#g<CR>                                        " replaces \ with /: [\]->[/]
" }}}
nmenu My.NewTab.vimrc :tabedit $MYVIMRC<CR>
nmenu My.NewTab.misc_info :tabedit $SCRIPT_PATH/../info/readme.md<CR>
nmenu My.NewTab.bash_history :tabedit $BASH_PHISTORY_FILE<CR>
  nmap <F12>lh :tabedit $BASH_PHISTORY_FILE<CR>
" Menu - Tabedit {{{
nmenu My.NewTab.FileDirectory :tabedit %:p:h<CR>
  nmap <silent> tes :tabedit<BAR>set cursorline<Bar>ScratchBuffer<CR>
  nmap te  :tabedit 
  nmap tee :tabedit 
  nmap ted :tabedit %:p:h<CR>
  nmap <Leader>ed  :edit %:p:h<CR>
if $GREP_LAST_PATH != "" " {{{
  nmenu My.NewTab.GrepDirectory :tabedit $GREP_LAST_PATH/<CR>
    nmap teg :tabedit $GREP_LAST_PATH<CR>
endif " }}}
if $LOG_PATH != "" " {{{
  nmenu My.NewTab.LogDirectory :tabedit $LOG_PATH/<CR>
    nmap tel :tabedit $LOG_PATH/<CR>
endif " }}}
if $TICKET_PATH != "" " {{{
  nmenu My.NewTab.TicketDirectory :tabedit $TICKET_PATH/<CR>
  nmap teJ :tabedit $TICKET_PATH/<CR>
  nmap tej :execute("tabedit " . system("$TICKET_TOOL_PATH/j-cmd.sh cd -v"))<CR>
else
  nmap teJ <NOP>
  nmap tej <NOP>
endif " }}}
nmap ten :execute("tabedit " . system("$ALIASES_SCRIPTS/note.sh --show-note-file"))<CR>
nmap teN :execute("tabedit " . system("$ALIASES_SCRIPTS/note.sh --note-tmux --show-note-file"))<CR>
nmap tegn :execute("tabedit " . system("$ALIASES_SCRIPTS/note.sh --note-gdrive --show-note-file"))<CR>
" }}}
" Menu - Explorer {{{
nmenu My.Explorer.NewTab :Texplore **/*
nmenu My.Explorer.Vert :35 Vexplore!<CR>
nmenu My.Explorer.CurrectDir-NewTab :tabedit %:p:h<CR>
nmenu My.Explorer.CurrentDir :edit %:p:h<CR>
nmenu My.Explorer.CurrentDir-cd :cd %:p:h<CR>
" }}}
" Menu - Find {{{
nmenu My.Find.Merge /^\%(\([<<Bar>>]\)\1\{6\} \)\<Bar>\%(=\{7\}\)<CR>
nmap <F12>d /^\%(\([<<Bar>>]\)\1\{6\} \)\<Bar>^\%(=\{7\}\)$<CR>
nmenu My.Find.Grep :lvimgrep // %<Left><Left><Left>
" }}}
" }}}
" }}}
" Use any other specifics {{{
if filereadable($RUNTIME_PATH."/vimrc")
  source $RUNTIME_PATH/vimrc
endif
if filereadable($HOME."/.vimrc.specific")
  source $HOME/.vimrc.specific
endif
for f in split(glob($PROFILES_PATH . '/*/inits/vim/*.vim'), '\n')
  exe 'source' f
endfor
if filereadable(".vimrc") && getcwd() != $HOME
  source .vimrc
endif
if filereadable("./.vim/vimrc")
  source ./.vim/vimrc
endif
" }}}
" Plugins {{{
" OmniCppComplete {{{
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" set completeopt=menuone,menu,longest,preview
" }}}
" YouCompleteMe # {{{
let g:loaded_youcompleteme = 1
let g:ycm_auto_trigger = 1
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_key_invoke_completion = '<C-f>'
" # }}}
" Clang-Complete {{{
if $VIM_CLANG_LIB != '' && $VIM_CLANG_LIB != '-'
  let g:clang_library_path = $VIM_CLANG_LIB
endif
let g:clang_user_options = '-std=c++11'
let g:clang_snippets = 0
nnoremap <silent> <Leader>cc :silent :call g:ClangUpdateQuickFix() <Bar> :copen<CR>
" }}}
" Jedi # {{{
let g:jedi#auto_initialization = 0
" let g:jedi#completions_command = "<C-N>"
" if has("python3")
"   let g:jedi#force_py_version = "3.7"
" endif
" }}}
" Fugitive {{{
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>ga :execute "Git add " . expand("%")<CR><CR>
" }}}
" Cscope {{{
if has("cscope")
  set csprg=/usr/bin/cscope
  if $IS_MAC == 'true'
    set csprg=/usr/local/bin/cscope
  endif
  set nocsverb
  " searching cscope database firts, then tags
  set csto=0
  " ctrl+] uses cstag
  set cst
  " use quickfix window and clear it first
"   set cscopequickfix=s-,g-,d-,c-,t-,e-,f-,i-
endif
" }}}
" Buffest # {{{
map <Leader>c,l <Plug>Loclistsplit
map <Leader>c,q <Plug>Qflistsplit
map <Leader>c@ <Plug>Regsplit
nnoremap <Leader>c@@ :Regsplit "<cr>
" }}}
" BufExplorer {{{
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowDirectories=0
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerShowNoName=1        " Show 'No Name' buffers.
let g:bufExplorerShowUnlisted=0      " Show unlisted buffers.
let g:bufExplorerSortBy='name'       " Sort by the buffer's name.
nnoremap <silent> <F10>bb :BufExplorerVerticalSplit<CR>
nnoremap <silent> <F10>bt :ToggleBufExplorer<CR>
nnoremap <silent> <F10>bh :BufExplorerHorizontalSplit<CR>
" }}}
" Tagbar {{{
nnoremap <silent> <F10>T :TlistToggle<CR>
nnoremap <silent> <F10>t :TagbarToggle<CR>
let g:tagbar_left=1
let g:tagbar_compact=1
let g:tagbar_autofocus=1
" let g:tagbar_autoclose=1
" }}}
" NERDTreeToggle {{{
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind"
  endif
endfunction
nmap <F10>f :call NERDTreeToggleInCurDir()<CR>
" }}}
" Signature {{{
let g:SignaturePurgeConfirmation=1
" }}}
" FZF {{{
if $FZF_INSTALLED ==? "true"
  let g:loaded_ctrlp = 1 " Disables Ctrl-P
  if $FZF_PATH != "" && $FZF_PATH != $SCRIPT_PATH."/bash/inits/fzf/bin"
    let &runtimepath.=','.fnamemodify($FZF_PATH, ":h")
  endif
  if $VIM_FZF_RUNTIME_PATH != ""
    set runtimepath+=$VIM_FZF_RUNTIME_PATH
  endif
  set runtimepath+=$SCRIPT_PATH/bash/inits/fzf
  nnoremap <silent> <c-p>           :Files<CR>
  nnoremap <silent> ,f              :Files<CR>
  nnoremap <silent> ,g              :GFiles<CR>
  nnoremap          ,L              :Lines<CR>
  nnoremap          ,l              :BLines<CR>
  nnoremap          ,*              :Ag <c-r>=expand("<cword>")<cr><CR>
  nnoremap          ,ag             :Ag <c-r>=expand("<cword>")<cr><CR>
  nnoremap <silent> ,a              :Ag<CR>
  nnoremap <silent> <Leader><c-a>   :Ag<CR>
  nnoremap          ,,bt            :BTags <c-r>=expand("<cword>")<cr><CR>
  nnoremap <silent> ,h              :History<CR>
  nnoremap <silent> ,/              :History/<CR>
  nnoremap <silent> ,:              :History:<CR>
  nnoremap <silent> ,;              :History:<CR>
  nnoremap <silent> ,m              :Marks<CR>
  nnoremap <silent> ,M              :Maps<CR>
  nnoremap <silent> <Leader>t       :Windows<CR>
  nnoremap <silent> ,t              :Windows<CR>
  nnoremap <silent> ,w              :Buffers<CR>
  nnoremap <silent> ,b              :Windows<CR>
  nnoremap          ,,ta            :Tags<space>
  let g:fzf_colors = {
      \ 'hl':      ['fg', 'Search'],
      \ 'fg':      ['fg', 'Normal', 'CursorColumn', 'Normal'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Function'],
      \ 'prompt':  ['fg', 'Function'],
      \ 'pointer': ['fg', 'Identifier'],
      \ 'marker':  ['fg', 'Keyword'],
      \ }
endif
" }}}
" Clever-F {{{
let g:clever_f_fix_key_direction = 1
let g:clever_f_across_no_line = 1
let g:clever_f_mark_cursor = 1
let g:clever_f_mark_char_color = 'IncSearch'
let g:clever_f_repeat_last_char_inputs = ["\<CR>", "\<Tab>"]
" }}}
" Ctrl-P {{{
if ! exists("g:loaded_ctrlp") || g:loaded_ctrlp == 0
  let g:ctrlp_working_path_mode = 'a'
  let g:ctrlp_max_files = 0
  let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:100'
  let g:ctrlp_clear_cache_on_exit = 0
  " let g:ctrlp_show_hidden = 1
  if exists("g:ctrlp_custom_ignore")
    unlet g:ctrlp_custom_ignore
  endif
  let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/](\.(git|hg|svn))|(' . $VIM_CTRLP_IGNORE_DIRS . ')$',
        \ 'file': '\v\.(class|exe|so|dll|o|tar|tgz)$',
        \ }
  " let g:ctrlp_arg_map = 1
  " let g:ctrlp_lazy_update = 50
  " let g:ctrlp_default_input = 1
endif
" }}}
" Scratch {{{
let g:scratch_persistence_file = $VIM_UTILS_PATH . '/scratch.txt'
let g:scratch_filetype = 'default'
let g:scratch_insert_autohide = 1
let g:scratch_no_mappings = 1
nmap <F12>gs  <plug>(scratch-insert-reuse)
nmap <F12>gS  <plug>(scratch-insert-clear)
xmap <F12>gs  <plug>(scratch-selection-reuse)
xmap <F12>gS  <plug>(scratch-selection-clear)
nmap <F12>gSP :ScratchPreview<CR>
" }}}
" Cheat {{{
let g:CheatDoNotReplaceKeywordPrg=1
" }}}
" Ag-Ack {{{
if executable('ag')
  let g:ackprg = 'ag $AG_OPTIONS --follow --vimgrep'
endif
" }}}
" Maximizer {{{
let g:maximizer_set_default_mapping = 1
let g:maximizer_default_mapping_key = '<F3>'
" }}}
" Gundo {{{
if has("python") || has("python3")
  nnoremap <Leader>u :GundoToggle<CR>
  if has("python3")
    let g:gundo_prefer_python3 = 1
  endif
else
  nnoremap <Leader>u :echo "Vim without python support"<CR>
endif
" }}}
" Tabline # {{{
let g:tabline_path='short'
let g:tabline_max=20
" }}}
" VimWiki # {{{
if $VIM_WIKIS != ""
  let g:vimwiki_list = eval( '[' . $VIM_WIKIS . ']' )
endif
" }}}
" Syntastic {{{
let g:loaded_syntastic_plugin = 1 " Disable the plugin
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_cpp_compiler = 'clang++'
" let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
" }}}
" Man # {{{
nnoremap <expr> K ':Man ' . expand('<cword>') . '<CR>'
nnoremap <expr> <Leader>k ':Man 3 ' . expand('<cword>') . '<CR>'
" }}}
" ConqureGdb # {{{
if has("python3")
  let g:ConqueTerm_PyVersion = 3
else
  let g:ConqueGdb_Disable = 1
endif
let g:ConqueGdb_Leader = '<Leader>'
let g:ConqueGdb_Backtrace = g:ConqueGdb_Leader . 'T'
" }}}
" KickFix # {{{
let g:kickfix_zebra=0
" }}}
" Match-up {{{
nmap %       <plug>(matchup-%)
vmap %       <plug>(matchup-%)
nmap <Tab>   <plug>(matchup-%)
vmap <Tab>   <plug>(matchup-%)
nmap g<Tab>  <Plug>(matchup-g%)
vmap g<Tab>  <Plug>(matchup-g%)
nmap z<Tab>  <Plug>(matchup-z%)
vmap z<Tab>  <Plug>(matchup-z%)
nmap cs<Tab> <Plug>(matchup-cs%)
nmap ds<Tab> <Plug>(matchup-ds%)
vmap a<Tab>  <Plug>(matchup-a%)
vmap i<Tab>  <Plug>(matchup-i%)
let g:matchup_matchparen_status_offscreen = 0
let g:matchup_matchparen_scrolloff = 1
" }}}
" CMake " {{{
let g:loaded_cmake = 1
" }}}
" Smooth Scroll " {{{
noremap <silent> <c-u>  :<C-U>call smooth_scroll#up(&scroll, 14, 2)<CR>
noremap <silent> <up>   :<C-U>call smooth_scroll#up(&scroll, 14, 2)<CR>
noremap <silent> <c-d>  :<C-U>call smooth_scroll#down(&scroll, 14, 2)<CR>
noremap <silent> <down> :<C-U>call smooth_scroll#down(&scroll, 14, 2)<CR>
noremap <silent> <c-b>  :<C-U>call smooth_scroll#up(&scroll*2, 14, 4)<CR>
noremap <silent> <c-f>  :<C-U>call smooth_scroll#down(&scroll*2, 14, 4)<CR>
nmap    <Leader><c-f>          100<c-f>
nmap    <Leader><Leader><c-f>  500<c-f>
nmap    <Leader><c-b>          100<c-b>
nmap    <Leader><Leader><c-b>  500<c-b>
nmap    <Leader>j              100j
nmap    <Leader><Leader>j      1000j
nmap    <Leader>k              100k
nmap    <Leader><Leader>k      1000k
" }}}
" }}}
" Akward issue with usage of fzf within vim in some cases {{{
source $HOME/.vim/autoload/fugitive.vim
" }}}

