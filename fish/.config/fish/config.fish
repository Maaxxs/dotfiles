# abbreviations
abbr -a e nvim
abbr -a g git
abbr -a m make
abbr -a o xdg-open
abbr -a c cargo


alias hx="~/.cargo/bin/hx"
alias hxconf="hx ~/.config/helix/config.toml"
alias rgi='rg -i'
alias fishconf='nvim ~/.config/fish/config.fish'
alias sshconf='nvim ~/.ssh/config'
alias nvimconf='nvim ~/.config/nvim/init.lua'
alias dl4='yt-dlp -f mp4 -o "%(title)s.%(ext)s"'
alias dl3='yt-dlp -f "ba" -x --audio-format mp3 -o "%(title)s.%(ext)s"'
alias duh='du -md1 2>/dev/null | sort -g'
alias digx='dig +short -x'
alias tcplisten='netstat -ap tcp | grep LISTEN'
alias cvpn='sudo systemctl start wg-quick@wg0'
alias dvpn='sudo systemctl stop wg-quick@wg0'
alias cair='bluetoothctl connect (bluetoothctl devices | rg AirPods | cut -d" " -f2)'
alias dair='bluetoothctl disconnect (bluetoothctl devices | rg AirPods | cut -d" " -f2)'
alias csony='bluetoothctl connect (bluetoothctl devices | rg WH-1000XM3 | cut -d" " -f2)'
alias dsony='bluetoothctl disconnect (bluetoothctl devices | rg WH-1000XM3 | cut -d" " -f2)'
alias cls="clear && printf '\e[3J'"
alias dn='nvim ~/notes/daily-notes/(date +%Y-%m-%d).md'
alias fixme='nvim ~/notes/fm/fixme.md'
alias lg='lazygit'
alias news='newsboat'

# git
alias gss='git status -s'
alias gd='git diff'
alias gds='git diff --cached'
alias gc='git commit -v'
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


if command -v ip  > /dev/null
    alias ipa='ip -c addr'
    alias ipr='ip -c route'
    alias ipr6='ip -c -6 route'
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
	alias l 'eza'
	alias ll 'eza -lg'
	alias la 'eza -lga --git'
else
	alias l 'ls'
	alias ll 'ls -l'
	alias la 'ls -la'
end


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
set -gx PAGER less
set -gx EDITOR nvim
# X = leave content on-screen
# F = quit automatically if less than one screenfull
# R = raw terminal characters (fixes git diff)
#     see http://jugglingbits.wordpress.com/2010/03/24/a-better-less-playing-nice-with-git/
set -gx LESS '-FXR'
set -gx DIRENV_LOG_FORMAT ''

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'


# Color manpage
# 30 = black
# 31m = red
# 32m = green
# 33m = yellow
# 34 = blue
# 35 = Magenta
# 36 = cyan
setenv LESS_TERMCAP_mb \e'[1;32m'               # begin blinking
setenv LESS_TERMCAP_md \e'[1;32m'               # begin bold
setenv LESS_TERMCAP_me \e'[0m'                  # end mode
setenv LESS_TERMCAP_se \e'[0m'                  # end standout-mode
setenv LESS_TERMCAP_so \e'[01;33m'              # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'                  # end underline
setenv LESS_TERMCAP_us \e'[1;36m'               # begin underline

setenv MANWIDTH 80

# FZF environment vars
setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 30%'

# do not shorten pwd
set -g fish_prompt_pwd_dir_length 0

function fish_prompt
	#set_color blue
	#echo -n (hostname)
	echo -ns (set_color brblack) '['(date "+%H:%M")'] ' (set_color yellow) (prompt_pwd) (set_color green) (__fish_git_prompt) (set_color red) ' | '
end

function fish_greeting
end

[ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish

# enable direnv
direnv hook fish | source

# only start ssh-agent if not running already
if test -z (pgrep ssh-agent)
    eval (ssh-agent -c | sed 's/^echo.*//')
    # export vars accross all fish shells (-U)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end


# enable vim keybindings. breaks Ctrl+f for autocompletion
# fish_vi_key_bindings
