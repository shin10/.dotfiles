# https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet

LANGUAGE=de_DE
LC_ALL=de_DE.UTF-8
LANG=de_DE.UTF-8
export LESSCHARSET=utf-8


if [ ! "$DISPLAY" ]; then
    # screenfetch has to be run BEFORE setting DISPLAY - otherwise it won't run without an X11 server

    # only output in interactive mode (https://stackoverflow.com/questions/54758822/how-to-rsync-with-a-non-standard-port-and-two-factor-2fa-authentication)
    if echo "$-" | grep i > /dev/null; then
        # source ~/.bashrc
        screenfetch -d -display

        if [[ $(grep -i Microsoft /proc/version) ]]; then
            echo "Zsh is running on WSL"
        
            # X11 settings
            export HOST=$(hostname -I | awk '{print $1}')
            export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
            export LIBGL_ALWAYS_INDIRECT=1
            echo '\nHOST set to' $HOST
            echo 'DISPLAY set to' $DISPLAY '- ready for X11\n'
        fi
    fi
fi


export PATH=$PATH:~/.imagick
export PATH=$PATH:~/.local/bin

#export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
#export PATH=/mnt/c/Windows/System32/WindowsPowerShell/v1.0:$PATH
#export PATH=/mnt/c/WINDOWS/system32:$PATH
#export VAGRANT_DEFAULT_PROVIDER="hyperv"
#export PATH=/mnt/c/ProgramData/Microsoft/Windows/Hyper-V:$PATH

# windows PATH have been disabled and manual paths cherry picked to speed up syntax highlighting plugin
export PATH="$PATH:/mnt/c/Users/shin10/AppData/Local/Microsoft/WindowsApps"
export PATH="$PATH:/mnt/c/Users/shin10/AppData/Local/Programs/Microsoft VS Code/bin"
export PATH="$PATH:/mnt/c/WINDOWS"

# cht.sh autocomplete
fpath=(~/.zsh.d/ $fpath)


# autojump

[[ -s /root/.autojump/etc/profile.d/autojump.sh ]] && source /root/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u




# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

HIST_IGNORE_SPACE="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
#  autojump
  git
  git-flow
  docker
  docker-compose
  zsh-aliases-exa
  zsh-autosuggestions
  zsh-interactive-cd
  zsh-syntax-highlighting
  fzf-tab
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



### NVM super slows down zsh start up!! (currently it's not installed in wsl, but as a reminder: comment out the following rules helps to speed up starting zsh :) )
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# forgit
[ -f ~/.forgit/forgit.plugin.zsh ] && source ~/.forgit/forgit.plugin.zsh



agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

if [ "$SSH_AUTH_SOCK" ]; then
else
    # init ssh-agent
    env=~/.ssh/agent.env

    agent_load_env

    # agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
    agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

    if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
        agent_start
        ssh-add
    elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
        ssh-add
    fi

    unset env
fi
