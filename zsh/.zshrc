# Antibody
source ~/.zsh_plugins.sh


# Set LANG
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


# PATH settings
export PATH="/usr/local/sbin:$PATH"
export PATH="/Users/pavshn/.local/bin:$PATH"


# Save history and specify the number of entries to store
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell


# Configure completion system
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || \
stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

#  Add menu list from where we can highlight and select completion results
zmodload -i zsh/complist

setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
# enable approximate matches for completion
zstyle ':completion:::::' completer _expand _complete _ignored _approximate 
setopt auto_cd # cd by typing directory name if it's not a command


# Go settings
export GOPATH=$HOME/dev/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export GOBIN=$GOPATH/bin


# Aliases
alias sz='source ~/.zshrc'
alias brewuu='brew update && brew upgrade'
alias brewcu='brew cask upgrade'
alias brewll='brew list && printf %"$COLUMNS"s |tr " " "-"  && brew cask list'
alias gitr='git clone --recursive'
alias swift='PATH="/usr/bin:$PATH" swift'
alias lldb='PATH="/usr/bin:$PATH" lldb'
alias vi='nvim'


# Functions
# Update antibody plugins
uz(){
  antibody bundle <~/.zsh_plugins.txt >~/.zsh_plugins.sh
  antibody update
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fh - search in your command history and execute selected command
fh() {
  eval $( \
    ([ -n "$ZSH_NAME" ] && fc -l 1 || history) \
    | fzf +s --tac | sed 's/ *[0-9]* *//' \
    )
}


# iTerm Shell Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && \
source "${HOME}/.iterm2_shell_integration.zsh"

