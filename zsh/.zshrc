
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    vscode
    web-search
    copyfile
    copybuffer
    history
)

source $ZSH/oh-my-zsh.sh

# init oh-my-posh
eval "$(oh-my-posh init zsh --config ~/.dotfiles/omptheme.json)"
eval $(thefuck --alias fuck)