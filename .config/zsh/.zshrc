#!/usr/bin/zsh

# vim: ft=zsh
#
# The individual per-interactive-shell startup file. Loaded everytime you start
# a shell, but is not loaded when you login the first time.
#
# https://wiki.archlinux.org/index.php/Zsh
# http://zsh.sourceforge.net/FAQ/
# http://zsh.sourceforge.net/Doc/Release/
# https://grml.org/zsh
# See 'man zshoptions' for more info.

# Load aliases and shortcuts if existent.
for file in ${XDG_CONFIG_HOME:-$HOME/.config}/shell/{aliasrc,shortcutrc,functionrc,zshnameddirrc,localrc}; do
	[[ -f "$file" ]] && source "$file"
done
unset file

if [[ $TERM == *termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

# Display usage statistics for commands running > 5 sec.
REPORTTIME=5

# Report login/logout events
# 'all'		all login/logout events are reported.
# 'notme'	for everybody except ourself.
watch=(notme)

# Time (seconds) between checks for login/logout activity using the watch parameter.
LOGCHECK=60

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
mkdir -p "${HISTFILE%/*}"
setopt inc_append_history

# Basic auto/tab complete:
# Enable autocompletion with an arrow-key driven interface.
# To activate the menu, press tab twice.
autoload -U compinit promptinit
compinit
promptinit

setopt interactive_comments

zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

# vi mode
# https://dougblack.io/words/zsh-vi-mode.html
bindkey -v
export KEYTIMEOUT=1

# Zsh help command is called run-help. Zsh does not enable it by default.
# https://wiki.archlinux.org/index.php/Zsh#Help_command
autoload -Uz run-help
alias help='run-help'

# Completion
zstyle :compinstall filename "$ZDOTDIR/.zshrc"

# Automatically find new executables in the $PATH
zstyle ':completion:*' rehash true completer _expand_alias _complete _ignored

# case-insensitive (all), partial-word and then substring completion
zstyle ":completion:*" matcher-list \
  "m:{a-zA-Z}={A-Za-z}" \
  "r:|[._-]=* r:|=*" \
  "l:|=* r:|=*"

zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}

setopt appendhistory autocd extendedglob nomatch
unsetopt beep

# Do not enter command lines into the history list if they are duplicates
# of the previous event.
setopt HIST_IGNORE_DUPS

# Append history list to the history file (for multiple parallel zsh sessions)
setopt append_history

# Other setopt options
setopt extended_history		# Also record time and duration of commands.
setopt share_history		# Share history between multiple shells
setopt hist_expire_dups_first	# Clear duplicates when trimming internal hist.
setopt hist_find_no_dups	# Dont display duplicates during searches.
setopt hist_ignore_dups		# Ignore consecutive duplicates.
setopt hist_ignore_all_dups	# Remember only one unique copy of the command.
setopt hist_reduce_blanks	# Remove superfluous blanks.
setopt hist_save_no_dups	# Omit older commands in favor of newer ones.
setopt COMPLETE_ALIASES		# autocompletion of command line switches for aliases
setopt completeinword		# Complete not just at the end

# Changing directories
setopt pushd_ignore_dups	# Dont push copies of the same dir on stack.
setopt pushd_minus		# Reference stack entries with "-".
setopt extended_glob		# Enable extended globbing

# Common CTRL bindings.
bindkey "^u" backward-kill-line
bindkey "^k" kill-line

# Do not require a space when attempting to tab-complete.
bindkey "^i" expand-or-complete-prefix

# Move up and down in history
bindkey '^P' up-history
bindkey '^N' down-history

# ctrl-r starts searching history backward. ctrl-f forward
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^F" history-incremental-pattern-search-forward

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^o' '^ulfcd\n' # Ctrl+O to launch file manager.
bindkey -s '^a' '^ubc -lq\n' # Ctrl+A to launch calculator.
bindkey -s '^f' '^ucd -- "$(dirname -- "$(fzf)")"\n' # Ctrl+F to search directory with fzf.
bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# ESC-v (or simply v if already in command mode) opens EDITOR
bindkey -M vicmd V edit-command-line

bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# Load powerlevel10k
# https://github.com/romkatv/powerlevel10k
[[ $TERM != "$TERMINAL" ]] && return

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Powerlvel9k mode
# https://github.com/bhilburn/powerlevel9k/wiki/About-Fonts
# https://github.com/gabrielelana/awesome-terminal-fonts
# https://github.com/ryanoasis/nerd-fonts
#POWERLEVEL9K_MODE=""

# Left and right prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=('background_jobs' 'root_indicator' 'context' 'dir_writable' 'dir' 'vcs')
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=('vi_mode' 'command_execution_time' 'status' 'todo' 'time' 'ssh')

# Separators
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\UE0BC"
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\UE0BA"
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=""
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=""

# Icons
# /usr/share/zsh-theme-powerlevel10k/internal/icons.zsh
POWERLEVEL9K_HOME_ICON="\UF015"
POWERLEVEL9K_SUB_ICON="\UF07C"
POWERLEVEL9K_FOLDER_ICON="\UF07B"
POWERLEVEL9K_BATTERY_ICON="\UF1E6"
POWERLEVEL9K_BATTERY_CHARGING_ICON="/UF1E6"
POWERLEVEL9K_BATTERY_CHARGED_ICON="/UF240"
POWERLEVEL9K_BATTERY_LOW_ICON="/UF240"
POWERLEVEL9K_VCS_STASH_ICON='\u235F ' # ⍟

# Context
POWERLEVEL9K_CONTEXT_TEMPLATE="%n@%m"
POWERLEVEL9K_ALWAYS_SHOW_CONTEXT="true"
POWERLEVEL9K_ALWAYS_SHOW_USER="false"

# Prompt position
POWERLEVEL9K_PROMPT_ON_NEWLINE="true"
POWERLEVEL9K_RPROMPT_ON_NEWLINE="false"

# Multiline prompt prefix
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" %F{cyan}❯ %f"

# Truncate directories
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_unique"
POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER="false"

# Add a newline after each prompt / print loop
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Misc
POWERLEVEL9K_RAM_ELEMENTS="ram_free"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_CHANGESET_HASH_LENGTH="12"
POWERLEVEL9K_DIR_SHOW_WRITABLE="false"
POWERLEVEL9K_STATUS_CROSS="false"
POWERLEVEL9K_STATUS_VERBOSE="true"
POWERLEVEL9K_STATUS_OK="false"
#POWERLEVEL9K_STATUS_HIDE_SIGNAME
#POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE
#POWERLEVEL9K_STATUS_SHOW_PIPESTATUS
#POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE
#POWERLEVEL9K_DIR_PATH_SEPARATOR
#POWERLEVEL9K_DISK_USAGE_CRITICAL_LEVEL
#POWERLEVEL9K_DISK_USAGE_ONLY_WARNING
#POWERLEVEL9K_DISK_USAGE_WARNING_LEVEL
#POWERLEVEL9K_HOME_FOLDER_ABBREVIATION
#POWERLEVEL9K_HOST_TEMPLATE
#POWERLEVEL9K_USER_TEMPLATE
#POWERLEVEL9K_VCS_ACTIONFORMAT_FOREGROUND
#POWERLEVEL9K_VCS_GIT_HOOKS
#POWERLEVEL9K_VCS_HG_HOOKS
#POWERLEVEL9K_VCS_HIDE_TAGS
#POWERLEVEL9K_VCS_INTERNAL_HASH_LENGTH
#POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY
#POWERLEVEL9K_VCS_SVN_HOOKS
#POWERLEVEL9K_VI_COMMAND_MODE_STRING
#POWERLEVEL9K_VI_INSERT_MODE_STRING
#POWERLEVEL9K_VPN_IP_INTERFACE
#POWERLEVEL9K_WHITESPACE_BETWEEN_LEFT_SEGMENTS
#POWERLEVEL9K_WHITESPACE_BETWEEN_RIGHT_SEGMENTS

# Colors
POWERLEVEL9K_COLOR_SCHEME='dark'
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="black"
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="green"

POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="black"

POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND="red"
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="black"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="red"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="black"

POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="red"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="black"
POWERLEVEL9K_DIR_NOT_WRITABLE_BACKGROUND="red"
POWERLEVEL9K_DIR_NOT_WRITABLE_FOREGROUND="black"
POWERLEVEL9K_DIR_HOME_BACKGROUND="blue"
POWERLEVEL9K_DIR_HOME_FOREGROUND="black"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="blue"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="black"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="black"

POWERLEVEL9K_VCS_CLEAN_BACKGROUND="green"
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="black"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="yellow"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="black"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="magenta"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="black"
POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS='0.05'

POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="black"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="cyan"

POWERLEVEL9K_STATUS_OK_BACKGROUND="black"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"

POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="black"

POWERLEVEL9K_RAM_BACKGROUND="black"
POWERLEVEL9K_RAM_FOREGROUND="green"

POWERLEVEL9K_HISTORY_BACKGROUND="black"
POWERLEVEL9K_HISTORY_FOREGROUND="blue"

POWERLEVEL9K_TODO_BACKGROUND="clear"
POWERLEVEL9K_TODO_FOREGROUND="green"

POWERLEVEL9K_TIME_FOREGROUND="cyan"
POWERLEVEL9K_TIME_BACKGROUND="black"

POWERLEVEL9K_SSH_FOREGROUND="yellow"
POWERLEVEL9K_SSH_BACKGROUND="black"

POWERLEVEL9K_HOST_LOCAL_FOREGROUND="cyan"
POWERLEVEL9K_HOST_LOCAL_BACKGROUND="black"
POWERLEVEL9K_HOST_REMOTE_FOREGROUND="cyan"
POWERLEVEL9K_HOST_REMOTE_BACKGROUND="black"

POWERLEVEL9K_USER_DEFAULT_FOREGROUND="cyan"
POWERLEVEL9K_USER_DEFAULT_BACKGROUND="black"
POWERLEVEL9K_USER_ROOT_FOREGROUND="cyan"
POWERLEVEL9K_USER_ROOT_BACKGROUND="black"

POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="black"
POWERLEVEL9K_LOAD_WARNING_BACKGROUND="black"
POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="black"
POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="red"
POWERLEVEL9K_LOAD_WARNING_FOREGROUND="yellow"
POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="green"
POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_LOAD_WARNING_VISUAL_IDENTIFIER_COLOR="yellow"
POWERLEVEL9K_LOAD_NORMAL_VISUAL_IDENTIFIER_COLOR="green"

POWERLEVEL9K_BATTERY_CHARGING="yellow"
POWERLEVEL9K_BATTERY_CHARGED="blue"
POWERLEVEL9K_BATTERY_LOW_THRESHOLD="20"
POWERLEVEL9K_BATTERY_LOW_COLOR="red"
POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND="46"
POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND="235"
POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND="178"
POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND="235"
POWERLEVEL9K_BATTERY_LOW_BACKGROUND="88"
POWERLEVEL9K_BATTERY_LOW_FOREGROUND="235"
POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND="195"
POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND="009"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null || true
