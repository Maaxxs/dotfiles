augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile /tmp/mutt* setfiletype mail
  autocmd Filetype mail setlocal spell tw=72 colorcolumn=73
  autocmd Filetype mail setlocal fo+=w
  " Git commit message
  autocmd Filetype gitcommit setlocal spell tw=72 colorcolumn=73
  " nftables
  autocmd BufRead,BufNewFile *.nft setfiletype nftables
  " Shorter columns in text
  autocmd Filetype tex setlocal spell tw=80 colorcolumn=81
  autocmd Filetype text setlocal spell tw=72 colorcolumn=73
  autocmd Filetype markdown setlocal spell tw=72 colorcolumn=73
  " asciidco
  au BufNewFile,BufRead *.adoc set filetype=asciidoc
augroup END
