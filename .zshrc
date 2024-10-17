# Lines configured by zsh-newuser-install
export HISTFILE=~/.histfile
export HISTSIZE=10000
export SAVEHIST=10000
setopt autocd nomatch
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/alex/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"
eval "$(pyenv init -)"
source /usr/share/nvm/init-nvm.sh
source /etc/profile.d/debuginfod.sh
autoload -U edit-command-line
zle -N edit-command-line

export GPG_TTY=$(tty)
export EDITOR="code -w"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias bell='echo -e "\a"'
alias pbcopy='wl-copy'
alias pbpaste='wl-paste'
alias please='sudo $(fc -ln -1)'
alias open='xdg-open'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vg="valgrind --leak-check=full --track-origins=yes --show-reachable=yes"
alias ls="exa"
alias ll="exa -l"
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
