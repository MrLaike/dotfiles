# export PATH=$HOME/bin:/usr/local/bin:/snap/bin:/opt/bin:$PATH

export ZSH=$HOME/.config/zsh
export EDITOR=nvim
export PET_PROJECTS_DIR="$HOME/Space/PetProjects/"

source ~/.cache/wal/colors.sh

### QUICK DIR
alias edu='cd ~/Space/EducationSSTU'
alias notes='nvim ${NOTE_DIR:-~/Notes}'


### HISTORY
export HISTFILE=$ZSH/.zsh_history

export HISTSIZE=10000

export SAVEHIST=10000

setopt HIST_IGNORE_ALL_DUPS

setopt HIST_FIND_NO_DUPS

#ALIAS
alias clipboard='xclip -selection clipboard'
alias fcd='cd $(find -type d | fzf)'
alias cat='bat'
alias ls='exa --icons --group-directories-first'
alias la='exa --icons -a'
alias ll='exa --icons --git --long -a --sort=newest'
alias llt="eza -h -lag -F --git -T -L 2 --group-directories-first"
alias lllt="eza -h -lag -F --git -T -L 3 --group-directories-first"
alias llllt="eza -h -lag -F --git -T -L 4 --group-directories-first"
alias ga='git add'
alias gl='git log --pretty=format:"%C(#ff0000)%h%Creset - %C(#11ff00)%an%Creset, %C(#11aaff)%ad%Creset : %s" --date=format:"%d-%m-%Y %H:%M:%S"'
alias gb='git branch'
alias gf='git fetch'
alias gs='git status'
alias gst='git stash'
alias gstp='git stash pop'
alias gstp0='git stash pop stash@\{0\}'
alias gm='git merge'
alias gmc='git merge --continue'
alias gma='git merge --abort'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gchp='git cherry-pick'
alias gchpc='git cherry-pick --continue'
alias gchpa='git cherry-pick --abort'
alias gc='git checkout'
alias gcm='git commit'
alias gcmm='git commit -m'
alias gpl='git pull'
alias gplo='git pull origin "$(git rev-parse --symbolic-full-name HEAD)"'
alias gpsh='git push'
alias gpsho='git push origin "$(git rev-parse --symbolic-full-name HEAD)"'
alias t='smug'
alias ts='smug start'
alias tl='smug list'
alias v='vim'
alias vim='nvim'

if [ -f ~/.config/zsh/.ssh_alias/stroys.zsh ]; then
    source ~/.config/zsh/.ssh_alias/stroys.zsh
fi

#alias find='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'


#PLUGINS

source $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

source $ZSH/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

fpath=($ZSH/plugins/zsh-completions/src $fpath)
autoload -U compinit; compinit

#THEME
source $ZSH/themes/spaceship-prompt/spaceship.zsh-theme

SPACESHIP_PROMPT_ORDER=(
  user          
  dir           
  host          
  git           
  hg            
  exec_time     
  line_sep      
  jobs          
  exit_code     
  char          
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

#KEYBINDS
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

eval "$(zoxide init zsh)"


# FZF
export FZF_DEFAULT_COMMAND="rg --files --follow --hidden -g '!.git' -g '!.cache' -g '!.steam' -g '!.docker-data' -g '!.wine' -g '!.local'"

export FZF_COMPLETION_TRIGGER="*"

_fzf_compgen_path() {
  rg --files --hidden -g "!.java" -g "!.git" -g "!.docker-data" -g "!.cache" -g "!.steam"  -g "!.wine" -g "!.local" . "$1"
}

_fzf_compgen_dir() {
  find -L "$1" -name .wine -prune -o -name .git -prune -o -type d
}

compdef _gnu_generic fzf

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

eval "$(fzf --zsh)"


# AUTOSTART TMUX
if [[ ! -n $TMUX  ]]; then
  session_ids="$(tmux list-sessions)"

  if [[ -z "$session_ids" ]]; then
    tmux new-session
  fi

  create_new_session="Create new session"
  start_without_tmux="Start without tmux"
  choices="${start_without_tmux}\n${create_new_session}\n$session_ids"
  choice="$(echo $choices | fzf | cut -d: -f1)"

  if expr "$choice" : "[0-9]*$" >&/dev/null; then
    tmux attach-session -t "$choice"
  elif [[ "$choice" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ "$choice" = "${start_without_tmux}" ]]; then
    :
  fi
fi


# FUNCTIONS

cd() { z "$@" && ls; }
