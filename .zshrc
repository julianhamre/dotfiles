# Aliases
alias gg="git log --all --decorate --oneline --graph" 
alias pi="ssh julianhamre@pi.local"
alias p3="/usr/local/bin/python3"
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# openjdk
export PATH="/opt/homebrew/opt/openjdk@25/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@25/libexec/openjdk.jdk/Contents/Home"

# matlab
export PATH="/Applications/MATLAB_R2024b.app/bin:$PATH"
export MATLAB_JAVA="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"

# flick
export FLICK_PATH=/Users/julianhamre/code/flick
export FLICK_COMPILER="clang++ -std=c++20"
export PATH=$FLICK_PATH/main:$PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Vim commands in terminal
source $(brew --prefix zsh-vi-mode)/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# Starship
eval "$(starship init zsh)"
