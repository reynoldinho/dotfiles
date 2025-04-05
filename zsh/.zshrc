export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/dinho.toml)"
fi

# Auto-start SSH agent only if not running and load keys from Keychain
if [ -z "$SSH_AUTH_SOCK" ]; then
  # Start the SSH agent
  eval "$(ssh-agent -s)" >/dev/null
  # Add keys from Keychain (no need to specify key paths)
  ssh-add --apple-load-keychain >/dev/null 2>&1
fi

bindkey -v

# Bind Ctrl-L to clear screen in vi insert mode
bindkey -M viins '^L' clear-screen

# Bind 'dd' to delete line in vi command mode (like in vim)
bindkey -M vicmd 'dd' kill-whole-line

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

HISTSIZE=2000
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

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

alias ls='ls --color -a'

if [[ $- == *i* ]]; then
    fastfetch
fi
