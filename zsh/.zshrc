# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo 
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Some other plugins that could be useful can be found here:
# https://github.com/ohmyzsh/ohmyzsh/wiki/plugins
plugins=(
  vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting
  git
  fzf
  asdf
  aws
  fluxcd
  terraform
)

source "$HOME/.oh-my-zsh/oh-my-zsh.sh"

# core env
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=nvim

# configs
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true

# alias
alias ll='ls -alh'
alias vim='nvim'
alias v='nvim'

# Source all .zsh files in the conf.d directory
for file in $HOME/.config/zsh/conf.d/*.zsh(N); do
    source "$file"
done

