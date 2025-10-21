" Quit when a syntax file was already loaded.
" if exists("b:current_syntax")
"     finish
" endif

syntax match Priority /^[ABC] /
highlight Priority guifg=orange guibg=default

syntax match Done /^X /
highlight Done guifg=purple

syntax match Info /\v<MORE>|<WAIT>/
highlight Info guifg=black guibg=khaki

syntax match Doing /\v<DOING>/
highlight Doing guifg=purple guibg=white


syntax match Person /@[a-zA-Z]\+[ .]/
highlight Person guifg=cyan

syntax match Date /\d\d\d\d.\d\d.\d\d/
highlight Date guifg=grey

