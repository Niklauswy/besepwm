if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export PATH="/opt/nvim/bin:$PATH"
#export PATH="$HOME/.local/share/JetBrains/Toolbox/apps:$PATH"
export PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"

export ZSH="$HOME/.oh-my-zsh"

export JAVA_HOME=/opt/TemurinJDK-21
export PATH=$JAVA_HOME/bin:$PATH



ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )


plugins=(
	sudo copypath copybuffer zsh-autosuggestions 
	zsh-syntax-highlighting aliases web-search dirhistory
	fancy-ctrl-z
) 

source $ZSH/oh-my-zsh.sh
source $HOME/.gh-completion.zsh
source ~/.config/zsh/fzf.zsh

alias zshconfig="nano ~/.zshrc"
alias cpath="copypath"
alias cfile="clipcopy $1"
alias ls='lsd'
alias vim='nvim'
alias cat='batcat'
alias ghs="gh copilot suggest"
alias ghe="gh copilot explain"


#---------------------------------------------------------------------------------

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


source ~/.gh-completion.zsh


alias gacp='gitAddCommitPush'

function gitAddCommitPush() {
    git add .
    commitMessage=$1
    git commit -m "$commitMessage"
    git push
}



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#Esto va en ./config/bat/themes https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme

export BAT_THEME=tokyonight_night



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/klaus/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/klaus/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/klaus/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/klaus/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

