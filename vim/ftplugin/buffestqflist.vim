augroup buffestqflist
  autocmd!
  autocmd BufWritePost <buffer> call buffest#writeqflist()
  autocmd BufEnter <buffer> call buffest#readqflist()
augroup END

setlocal bufhidden=delete
setlocal nobuflisted
