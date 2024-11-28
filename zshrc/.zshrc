# Shell integrations
# if [[ $(uname -m) == 'arm64' ]]; then  # Other way to check macos
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  # If you're using brew in linux, you'll want this enabled
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Terminal configs for kitty
if test -n "$KITTY_INSTALLATION_DIR"; then
  export KITTY_SHELL_INTEGRATION="enabled"
  autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
  kitty-integration
  unfunction kitty-integration
fi

if [[ "$(uname)" == "Linux" ]]; then
  # Nix Troubleshooting
  export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
fi

# Nix!
export NIX_CONF_DIR=$HOME/.config/nix

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

if [ -n "$TTY" ]; then
  export GPG_TTY=$(tty)
else
  export GPG_TTY="$TTY"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

if [ ! -d "$HOME/.cache/zinit/completions" ]; then
  mkdir -p "$HOME/.cache/zinit/completions"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::dotenv
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::rust
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# dotenv settings
ZSH_DOTENV_FILE=.dev.env
ZSH_DOTENV_PROMPT=false

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^ ' autosuggest-accept

# History
HISTSIZE=15000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always -1 --color=always $realpath'
zstyle ':fzf-tab:complete:code:*' fzf-preview 'eza --icons=always -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons=always -1 --color=always $realpath'

# Aliases
# ---- Eza (better ls) -----
alias ls="eza --icons=always"
# alias ls="ls --color"
alias la="ls -lAhg"
# alias vim='nvim'
alias c='clear'
alias cat='bat'
alias lg='lazygit'
alias ld='lazydocker'
alias md='mkdir'
alias my_tmux="
tmux new -s labs -d
tmux new-window -a -t labs:1
tmux new-window -a -t labs:2
tmux new-window -a -t labs:3
tmux new-window -a -t labs:4
tmux rename-window -t labs:3 turn
tmux rename-window -t labs:4 dakr
tmux send-key -t labs:2 'btop' enter
tmux attach -t labs"
alias work_tmux="
tmux new -s work -d
tmux new-window -a -t work:1
tmux split-window -v -t work:1.1
tmux split-window -h -t work:1.1
tmux split-window -h -t work:1.3
tmux send-key -t work:2.1 'btop' enter
tmux new-window -a -t work:2
tmux attach -t work"

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# autoconfig fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

PATH=~/.console-ninja/.bin:$PATH

# Shell integrations
if [[ ! "$shell" == /nix/store/* ]]; then
  eval "$(pyenv init -)"
fi
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/like_p10k.toml)"
