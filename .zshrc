
export ZSH="$HOME/.oh-my-zsh"


autoload -U promptinit; promptinit
prompt pure

plugins=( 
    git
    dnf
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# check the dnf plugins commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dnf


# fastfetch. Will be disabled if above colorscript was chosen to install
#fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


fpath+=($HOME/.zsh/pure)

# Set-up icons for files/folders in terminal using eza
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'

alias e='exit'
alias c='clear'
alias v='nvim'
alias get='sudo dnf install'
alias U='sudo dnf update && sudo dnf upgrade'
alias ..='cd ..'
alias ...='cd ../..'

export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/.cabal/bin:$PATH"

[ -f "/home/babaji/.ghcup/env" ] && . "/home/babaji/.ghcup/env" # ghcup-env
