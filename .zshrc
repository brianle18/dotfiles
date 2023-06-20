# vim mode
#source "$HOME/zsh-vim-mode/zsh-vim-mode.plugin.zsh"
export PATH="/opt/homebrew/bin:$PATH"
# define widget function
function cursor-after-first-word {
    zle up-history
    zle beginning-of-line
    zle forward-word
    RBUFFER=" $RBUFFER"
}

plugins=(
    fzf-tab
    fzf
)

# create widget from function
zle -N cursor-after-first-word

# bind widget to ESC-o
bindkey '^[o' cursor-after-first-word
set -o vi
bindkey -v
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"


### Search stuff
bindkey "^R" history-incremental-search-backward
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

###### VIM STUFF
bindkey '\e' vi-cmd-mode

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
#eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
# Enable FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# source antidote
source /usr/local/opt/antidote/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

eval "$(starship init zsh)"

zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/Users/user/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/Users/user/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/Users/user/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/Users/user/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
## <<< conda initialize <<<


