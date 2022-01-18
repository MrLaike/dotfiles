#  ______                   
# (____  \                  
#  ____)  )_____  ___ _____ 
# |  __  ((____ |/___) ___ |
# | |__)  ) ___ |___ | ____|
# |______/\_____(___/|_____)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

#  _______ _  _
# (_______) |(_)
#  _______| | _ _____  ___
# |  ___  | || (____ |/___)
# | |   | | || / ___ |___ |
# |_|   |_|\_)_\_____(___/

# Быстрый поиск по директориям
alias fcd='cd $(find -type d | fzf)'


#  ______  _              _            
# (_____ \| |            (_)           
#  _____) ) | _   _  ____ _ ____   ___ 
# |  ____/| || | | |/ _  | |  _ \ /___)
# | |     | || |_| ( (_| | | | | |___ |
# |_|      \_)____/ \___ |_|_| |_(___/ 
#                  (_____|             

[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# zsh-users
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", 	defer:2

# zsh
zplug "plugins/adb",				from:oh-my-zsh
zplug "plugins/common-aliases",			from:oh-my-zsh
zplug "plugins/colorize", 			from:oh-my-zsh
zplug "plugins/colored-man-pages",		from:oh-my-zsh
zplug "plugins/command-not-found",		from:oh-my-zsh
zplug "plugins/cp",				from:oh-my-zsh
zplug "plugins/extract",			from:oh-my-zsh
zplug "plugins/urltools",			from:oh-my-zsh
zplug "plugins/vi-mode",			from:oh-my-zsh
zplug "plugins/web-search",			from:oh-my-zsh
zplug "plugins/git",				from:oh-my-zsh

# git
zplug "arzzen/calc.plugin.zsh"
zplug "seebi/dircolors-solarized",		ignore:"*", as:plugin



########
# Install plugins if there are plugins that have not been installed
if ! zplug check; then
	printf "Install plugins? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

# Then, source plugins and add commands to $PATH
zplug load
if zplug check "seebi/dircolors-solarized"; then
	if which gdircolors &> /dev/null; then
		alias dircolors='() { $(whence -p gdircolors) }'
	fi
	if which dircolors &> /dev/null;
	then
		scheme="dircolors.ansi-universal"
		eval $(dircolors ~/.zplug/repos/seebi/dircolors-solarized/$scheme)
	fi
fi


#  _     _             _     _           _      
# (_)   | |           | |   (_)         | |     
#  _____| |_____ _   _| |__  _ ____   __| | ___ 
# |  _   _) ___ | | | |  _ \| |  _ \ / _  |/___)
# | |  \ \| ____| |_| | |_) ) | | | ( (_| |___ |
# |_|   \_)_____)\__  |____/|_|_| |_|\____(___/ 
#               (____/                          






#  ______                        _                    _  ___   _____  _     
# (_____ \                      | |                  | |(___) (_____)| |    
#  _____) )__  _ _ _ _____  ____| | _____ _   _ _____| |   _  _  __ _| |  _ 
# |  ____/ _ \| | | | ___ |/ ___) || ___ | | | | ___ | |  | || |/ /| | |_/ )
# | |   | |_| | | | | ____| |   | || ____|\ V /| ____| | _| ||   /_| |  _ ( 
# |_|    \___/ \___/|_____)_|    \_)_____) \_/ |_____)\_|_____)_____/|_| \_)
#
 
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
 [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

