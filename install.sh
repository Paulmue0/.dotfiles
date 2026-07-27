#!/usr/bin/env bash
# Run this script in .dotfiles/

# Create target directories
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/karabiner"
mkdir -p "$HOME/.config/git"
mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"

# Stow dotfiles
stow zshrc
stow tmux
stow --target="$HOME/.config/nvim/" nvim
stow --target="$HOME/.config/karabiner/" karabiner
stow --target="$HOME/Library/Application Support/com.mitchellh.ghostty" ghostty
stow --target="$HOME/.config/git/" git
