" Quit when a syntax file was already loaded.
" if exists("b:current_syntax")
"     finish
" endif

syntax match Priority /^[ABC] /
highlight Priority guifg=orange guibg=default

syntax match CAPSWORD /[A-Z]\+\s/
highlight CAPSWORD guifg=white guibg=default

syntax match Priority /^\s*[ABCX] /
highlight Priority guifg=orange guibg=default

syntax match URL /\vhttps?\S+/
highlight URL guifg=lightgreen

syntax match Info /\v<MORE>|<WAIT>/
highlight Info guifg=black guibg=khaki

syntax match Doing /\v<DOING>/
highlight Doing guifg=purple guibg=white


syntax match Person /@[a-zA-Z]\+[ .]/
highlight Person guifg=cyan

syntax match Date /\d\d\d\d.\d\d.\d\d/
highlight Date guifg=orange

