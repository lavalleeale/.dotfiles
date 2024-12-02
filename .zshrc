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
if command -v nixos-version >/dev/null; then
else
    eval "$(pyenv init -)"
    source /usr/share/nvm/init-nvm.sh
fi
if [ -f /etc/profile.d/debuginfod.sh ]; then
    source /etc/profile.d/debuginfod.sh
fi
autoload -U edit-command-line
zle -N edit-command-line

export GPG_TTY=$(tty)
export EDITOR="code -w"
export DIRENV_LOG_FORMAT=

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias bell='echo -e "\a"'
alias pbcopy=wl-copy
alias pbpaste=wl-paste
alias please='sudo $(fc -ln -1)'
alias open=xdg-open
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vg="valgrind --leak-check=full --track-origins=yes --show-reachable=yes"
alias ls=eza
alias ll="eza -l"
alias jodie=yarn
alias config='pushd ~/.config;nvim;popd'
alias zshrc='nvim ~/.zshrc'
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

if [ -d "$HOME/.atuin" ]; then
    . "$HOME/.atuin/bin/env"
fi

eval "$(direnv hook zsh)"

nixify() {
    if [ ! -e ./.envrc ]; then
        echo "use nix" >.envrc
        direnv allow
    fi
    if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
        cat >default.nix <<'EOF'
with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [
    bashInteractive
  ];
}
EOF
    fi
}
flakify() {
    if [ ! -e flake.nix ]; then
        nix flake new -t github:nix-community/nix-direnv .
    elif [ ! -e .envrc ]; then
        echo "use flake" >.envrc
        direnv allow
    fi
}

wal -Rq
eval "$(atuin init zsh)"
