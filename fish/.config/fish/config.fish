set -g fish_greeting ""
if status is-login
    set TTY1 (tty)
    [ "$TTY1" = /dev/tty1 ] && exec sway &>~/.Wsession.errors
end

function fish_user_key_bindings
    bind \cc 'cancel-commandline'
end
# abbreviations
abbr -a e nvim
abbr -a g git
abbr -a m make
abbr -a o xdg-open
abbr -a c cargo
abbr -a lk 'lookup'
abbr -a lka 'linank -a'
abbr -a ta 'task add'
abbr -a np "hugo new posts/(date +%Y-%m-%d)-"
abbr -a tt 'taskwarrior-tui'
abbr -a zs 'zola serve'
abbr -a mov 'nvim movie-list.txt'
abbr -a reading 'nvim reading-list.md'
abbr -a todo 'nvim ~/nc/todo.txt'
abbr -a ca 'calcurse'
abbr -a irc 'senpai'
abbr -a stb 'sudo systemctl start bluetooth'
abbr -a hexedit 'hexedit -l16'
abbr -a ymd 'date -u +%Y-%m-%d'
abbr -a sb 'sudo systemctl start bluetooth'
abbr -a hb 'sudo systemctl stop bluetooth'
abbr -a ping9 'ping 9.9.9.9'

alias hx="~/.cargo/bin/hx"
alias hxconf="hx ~/.config/helix/config.toml"
alias rgi='rg -i'
alias fishconf='nvim ~/.config/fish/config.fish'
alias sshconf='nvim ~/.ssh/config'
alias nvimconf='nvim ~/.config/nvim/init.lua'
alias swayconf='nvim ~/.config/sway/config'
alias muttconf='nvim ~/.config/neomutt/neomuttrc'
alias dl4='yt-dlp -f mp4 -o "%(title)s.%(ext)s"'
alias dl3='yt-dlp -f "ba" -x --audio-format mp3 -o "%(title)s.%(ext)s"'
alias duh='du -md1 2>/dev/null | sort -g'
alias digx='dig +short -x'
alias tcplisten='netstat -ap tcp | grep LISTEN'
alias cvpn='sudo systemctl start wg-quick@wg0; kill -USR1 i3status'
alias dvpn='sudo systemctl stop wg-quick@wg0; kill -USR1 i3status'
alias chs='sudo systemctl start openvpn-client@hses'
alias dhs='sudo systemctl stop openvpn-client@hses'
alias cair='bluetoothctl connect (bluetoothctl devices | rg AirPods | cut -d" " -f2)'
alias dair='bluetoothctl disconnect (bluetoothctl devices | rg AirPods | cut -d" " -f2)'
alias csony='bluetoothctl connect (bluetoothctl devices | rg WH-1000XM3 | cut -d" " -f2)'
alias dsony='bluetoothctl disconnect (bluetoothctl devices | rg WH-1000XM3 | cut -d" " -f2)'
alias cbose='bluetoothctl connect (bluetoothctl devices | rg "Bose QC45" | cut -d" " -f2)'
alias dbose='bluetoothctl disconnect (bluetoothctl devices | rg "Bose QC45" | cut -d" " -f2)'
alias bld='bluetoothctl devices | cut -f2 -d" " | while read uuid; bluetoothctl info $uuid; end|grep -e "Device\|Connected\|Name"'
alias cls="clear && printf '\e[3J'"
alias fixme='nvim ~/notes/fm/fixme.md'
alias lg='lazygit'
alias news='newsboat'
alias dn='nvim ~/notes/daily-notes/(date +%Y-%m-%d).md'
alias tn='nvim ~/notes/daily-notes/(date --date="tomorrow" +%Y-%m-%d).md'
alias yn='nvim ~/notes/daily-notes/(date --date="yesterday" +%Y-%m-%d).md'
alias uid='head -c30 /dev/urandom | base64 | tr -d "=/"'
alias pandock='docker run --rm -v "$(pwd):/data" -u $(id -u):$(id -g) pandoc/extra'
# alias mmut='mailsync.sh && mut'
alias mmail='mail sync'
alias jour='nvim ~/notes/journal'
#alias man='if test (tput cols) -gt 80; set -gx MANWIDTH 80; else; set -e MANWIDTH; end && man'

# git
alias gss='git status -s'
alias gd='git diff'
alias gds='git diff --cached'
alias gc='git commit -sv'
alias gapa='git add -p'
alias gl='git pull'
alias grv='git remote -v'
alias gcm='git checkout main 2>/dev/null || git checkout master 2>/dev/null || sh -c ">&2 echo Could not find branch main or master"'
alias gco='git checkout'
alias gcb='git checkout -b'
alias glodse='git log --graph --date=short --pretty=\'%Cred%h%C(auto)%d %s %C(blue)(%ad) %C(yellow)[%an]\''
alias gcpr='git fetch upstream && checkout_pr '

function checkout_pr -a pr
    git checkout pr/"$pr"
    # extend this to reset changes of this branch to the commit where this branch started
    # something like. this assumes branch main as parent
    # set base $(git merge-base HEAD main)
    # git reset "$base"
end

# Usage:
# $ reminder 'Tue 14:00' "some message"
function reminder -a message time -d "Sets up a one timer reminder that displays a notification"
    # if time starts with a number, prepend today's day before the time
    # "14:00" -> "Sat 14:00" to make it a valid system calendar time
    if string match -qr '^[0-9]' "$time"
        # get week day of today. e.g. Sat, Sun, ...
        set time "$(date +%a) $time"
    end

    set random_str (head -c10 /dev/urandom | base64 | tr -d '/+=')
    set unit "remind-me-$random_str"

    systemd-run --user \
        --unit="$unit" \
        --on-calendar="$time" \
        /usr/bin/sh -c "notify-send --urgency critical \"Reminder\" \""$message"\" && systemctl --user stop $unit.timer"
end

# list reminders
function reminder-ls
    systemctl --user list-timers | rg 'remind-me-[^\s]+\.service'
end

function reminder-stop-all
    for reminder in (systemctl --user list-timers | rg -o 'remind-me-[^\s]+\.timer')
        systemctl --user stop $reminder
    end
end

function rebuild -a file -d "Watch the given Markdown file for modications and rebuild with pandoc template eisvogel"
    set filestem (basename -s ".md" "$file")
    set fileout "$filestem.pdf"
    while true
	inotifywait -e modify "$file" 2>/dev/null
	echo "Rebuilding '$fileout'"
	pandock --template eisvogel --listings -o "$fileout" "$file"
    end
end


if command -v ip  > /dev/null
    alias ipa='ip -c addr show'
    alias ipr='ip -c route show'
    alias ipr6='ip -c -6 route show'
end

if command -v yay > /dev/null
	alias up='yay -Syu'
	alias s='yay -Ss'
	alias si='yay -Si'
	alias i='yay -S'
	alias u='yay -Runs'
	alias q='yay -Qi'
	alias pacs='pacman -Ss'
else
	alias up='sudo pacman -Syu'
	alias s='pacman -Ss'
	alias si='pacman -Si'
	alias i='sudo pacman -S'
	alias u='sudo pacman -Runs'
	alias q='pacman -Qi'
end


if command -v eza > /dev/null
	abbr -a l 'eza'
	abbr -a ll 'eza -lg --git'
	abbr -a la 'eza -lag --git'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a la 'ls -la'
end

# email settings
if command -v neomutt > /dev/null
    abbr -a mutt 'neomutt'
end

# function mut
#     alacritty msg config -w $ALACRITTY_WINDOW_ID  'font.normal = { family="Hermit" }'
#     alacritty msg config -w $ALACRITTY_WINDOW_ID  'window.padding = { x = 12, y = 0 }'
#     neomutt
#     alacritty msg config -w $ALACRITTY_WINDOW_ID --reset
# end


# Type d to move up to top parent dir which is a repository
function d
	while test $PWD != "/"
		if test -d .git
			break
		end
		cd ..
	end
end


# Environment variables
#set -gx MOAR "--style=gruvbox"
#set -gx PAGER moar
set -gx EDITOR nvim
set -gx DIFFPROG 'nvim -d'
set -gx BROWSER firefox
set -gx SUDO_PROMPT "$(tput setaf 2 bold)Say Please:$(tput sgr0) "
# X = leave content on-screen
# F = quit automatically if less than one screenfull
# R = raw terminal characters (fixes git diff)
#     see http://jugglingbits.wordpress.com/2010/03/24/a-better-less-playing-nice-with-git/
set -gx LESS '-i -j .25 -R'
set -gx DIRENV_LOG_FORMAT ''
set -gx GPG_TTY (tty)

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'


# Color manpage
# 1=red, 2=green, 4=blue
# 3=foreground, 4=background
# 38,39 special cases
# 30 = black
# 31 = red
# 32 = green
# 33 = yellow
# 34 = blue
# 35 = Magenta
# 36 = cyan
# 43 = yellow

# setenv LESS_TERMCAP_md \e'[1;32m' # start bold
# setenv LESS_TERMCAP_me \e'[0m' # end bold
# setenv LESS_TERMCAP_us \e'[1;36m' # start underline
# setenv LESS_TERMCAP_ue \e'[0m' # end underline
# setenv LESS_TERMCAP_so \e'[01;30;43m' # start stand out. (search) black text, yellow background.
# setenv LESS_TERMCAP_se \e'[0m' # end stand out
# setenv LESS_TERMCAP_mb \e'[1;32m' # begin blinking

# function set_man_width
#     set -x MANWIDTH (if test (tput cols) -gt 80; echo -n 80; else; echo -n 0; end)
# end

setenv MANWIDTH 80

# FZF environment vars
setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 30%'

# do not shorten pwd
set -g fish_prompt_pwd_dir_length 0

function fish_prompt
	set last_status $status
	#set_color blue
	#echo -n (hostname)
	echo -ns (set_color brblack) '['(date "+%H:%M")'] ' (set_color yellow) (prompt_pwd) (set_color green) (__fish_git_prompt) (if test $last_status -eq 0; set_color green; else; set_color red; end) ' | ' (set_color normal)
end

# function fish_greeting
# end

# [ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish
zoxide init fish | source

# enable direnv
direnv hook fish | source

# only start ssh-agent if not running already
# if test -z (pgrep ssh-agent)
#     eval (ssh-agent -c | sed 's/^echo.*//')
#     # export vars accross all fish shells (-U)
#     set -gx SSH_AUTH_SOCK $SSH_AUTH_SOCK
#     set -gx SSH_AGENT_PID $SSH_AGENT_PID
# end

#starship init fish | source
set -x PATH "$PATH:$HOME/.cargo/bin"
set -x PATH "$PATH:$HOME/.local/bin"
set -x PATH "$PATH:$HOME/go/bin"
set -x PATH "$PATH:$HOME/context/tex/texmf-linux-64/bin"

# function syscall_nr
#     cat /usr/src/linux/arch/x86/syscalls/syscall_64.tbl | \
#     awk '$2 != "x32" && $3 == "'$1'" { print $1 }'
# end

# base16 colors
# Base16 Shell
# if status --is-interactive
#     set BASE16_SHELL "$HOME/.config/base16-shell/"
#     source "$BASE16_SHELL/profile_helper.fish"
# end
# base16_materia


# enable vim keybindings. breaks Ctrl+f for autocompletion
# fish_vi_key_bindings
