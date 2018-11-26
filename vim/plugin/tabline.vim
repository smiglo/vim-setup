" File:        tabline.vim
" Maintainer:  Matthew Kitt <http://mkitt.net/>
" Description: Configure tabs within Terminal Vim.
" Last Change: 2012-10-21
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
" Based On:    http://www.offensivethinking.org/data/dotfiles/vimrc

" Bail quickly if the plugin was loaded, disabled or compatible is set
if (exists("g:loaded_tabline_vim") && g:loaded_tabline_vim) || &cp
  finish
endif
let g:loaded_tabline_vim = 1
if !exists("g:tabline_path")
  let g:tabline_path = 'full'
endif

function! s:get_entry(tab)
  let winnr = tabpagewinnr(a:tab)
  let wincnt = tabpagewinnr(a:tab, '$')
  let buflist = tabpagebuflist(a:tab)
  let bufnr = buflist[winnr - 1]
  let bufname = bufname(bufnr)
  let bufmodified = getbufvar(bufnr, "&mod")

  let e = ' ' . a:tab
  if wincnt > 1
    let e .= '|' . wincnt
  endif
  if bufmodified
    let e .= '+'
  else
    let e .= ':'
  endif
  if bufname != ''
    let max_len = 17
    if exists("g:tabline_max")
      let max_len = g:tabline_max
    endif
    let filename = fnamemodify(bufname, ':t')
    if max_len > 3 && strlen(filename) > max_len
      if $TERMINAL_HAS_EXTRA_CHARS != 'false'
        let filename = filename[: max_len - 1] . '…'
      else
        let filename = filename[: max_len - 3] . '...'
      endif
    endif
    if exists("g:tabline_path") && g:tabline_path == 'short'
      let e .= fnamemodify(filename, ':gs/%/%%/')
    else
      let path = pathshorten(fnamemodify(bufname, ':h:~:.:gs/%/%%/'))
      let e .= path . '/' . fnamemodify(filename, ':gs/%/%%/')
    endif
  else
    let e .= '[New]'
  endif
  let e .= ' '
  return l:e
endfunction

function! Tabline()
  let s = ''
  let len = 2
  let start = tabpagenr()
  let cnt = tabpagenr('$')
  let end_l = ' '
  let end_r = ' '
  " Selected entry {{{
  let e = s:get_entry(l:start)
  let len += strlen(l:e)
  let s .= '%' . l:start . 'T' . '%#TabLineSel#' . l:e
  let lasttab = start
  if exists("g:LastTab")
    let lasttab = g:LastTab
  endif
  " }}}
  " Sides  {{{
  let offset=1
  while l:len < &co && l:offset < l:cnt
    " Left side {{{
    let i = l:start - l:offset
    if l:i >= 1
      let e = s:get_entry(l:i)
      let len += strlen(l:e)
      if l:len >= &co " {{{
        if l:start - l:offset > 1
          let end_l = '<'
        endif
        if l:start + l:offset < l:cnt
          let end_r = '>'
        endif
        break
      endif " }}}
      let s = '%' . l:i . 'T' . (l:i == l:lasttab ? '%#TabLineLast#' : '%#TabLine#') . l:e . l:s
    endif " }}}
    " Right side {{{
    let i = l:start + l:offset
    if l:i <= l:cnt
      let e = s:get_entry(l:i)
      let len += strlen(l:e)
      let s = l:s . '%' . l:i . 'T' . (l:i == l:lasttab ? '%#TabLineLast#' : '%#TabLine#') . l:e
      if l:len >= &co " {{{
        if l:start - l:offset > 1
          let end_l = '<'
        endif
        if l:start + l:offset < l:cnt
          let end_r = '>'
        endif
        break
      endif " }}}
    endif " }}}
    let offset = l:offset + 1
  endwhile " }}}
  let s = l:end_l . l:s . "%#TabLineFill#%=" . l:end_r
  return l:s
endfunction
set tabline=%!Tabline()
