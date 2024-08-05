augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile /tmp/mutt* setfiletype mail
  autocmd BufRead,BufNewFile *.mail setfiletype mail
  autocmd Filetype mail setlocal spell tw=72 colorcolumn=73
  autocmd Filetype mail setlocal fo+=aw
  " Git commit message
  autocmd Filetype gitcommit setlocal spell tw=72 colorcolumn=73
  " nftables
  autocmd BufRead,BufNewFile *.nft setfiletype nftables
  " Shorter columns in text
  autocmd Filetype tex setlocal spell tw=80 colorcolumn=81
  autocmd Filetype text setlocal tw=72 colorcolumn=73
  " autocmd Filetype markdown setlocal nospell tw=72 colorcolumn=73 tabstop=2 shiftwidth=2
  autocmd Filetype markdown setlocal nospell tw=0 colorcolumn=73 tabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.adoc set filetype=asciidoc
  autocmd BufNewFile,BufRead *.log set filetype=log nowrap colorcolumn=0
  autocmd Filetype make set noexpandtab
augroup END
