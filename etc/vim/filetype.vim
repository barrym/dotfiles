augroup filetypedetect
  au! BufRead,BufNewFile *.rhtml setfiletype eruby
augroup END

augroup markdown
   au! BufRead,BufNewFile *.mkd   setfiletype mkd
 augroup END
