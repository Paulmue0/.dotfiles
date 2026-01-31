# ============================================================================
# Oh My Zsh Configuration
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git)

# ============================================================================
# Aliases
# ============================================================================
# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias cd="z"

# Utilities
alias ll="ls -la -G"
alias zshconfig="nvim ~/.zshrc"
alias fzfmove="~/Documents/GitHub/fzf-move/fzfmove.sh"
alias stop="~/Documents/GitHub/stop/stop.sh"
alias slide-diff="python3 ~/Documents/GitHub/slide-diff/slide_cleaner.py"
alias y="yazi"

# Git
alias gundo="git reset --soft HEAD~"
alias gamend="git commit -av --amend --no-edit"

# ============================================================================
# macOS Settings
# ============================================================================
if [[ $OSTYPE == darwin* ]]; then
  # 15 is lowest setting on UI
  # 8 was too fast causing duplicate keystrokes
  # 10 i think this causes issues in bash cli when editing commands, not sure
  defaults write -g InitialKeyRepeat -int 12

  # 2 is lowest setting on UI
  defaults write -g KeyRepeat -int 2

  # allow holding key instead of mac default holding key to choose alternate key
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
fi

# ============================================================================
# Shell Enhancements
# ============================================================================
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(fzf --zsh)
eval "$(zoxide init zsh)"

# ============================================================================
# Oh My Zsh Initialization
# ============================================================================
source $ZSH/oh-my-zsh.sh

# ============================================================================
# PATH Configuration
# ============================================================================
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/dev/flutter/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/paul/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ============================================================================
# Conda Initialize
# ============================================================================
__conda_setup="$('/Users/paul/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/paul/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/paul/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/paul/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# ============================================================================
# Local Configuration
# ============================================================================
. "$HOME/.local/bin/env"
