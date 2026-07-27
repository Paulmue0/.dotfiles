#!/usr/bin/env bash

#############################################
# macOS Bootstrap Script
#############################################
# This script automates the setup of a new macOS machine
# with dotfiles, Homebrew packages, and system configurations.
#
# Usage: ./bootstrap.sh
#############################################

set -e # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory (assuming this runs from .dotfiles/)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

#############################################
# Helper Functions
#############################################

print_header() {
  echo -e "\n${BLUE}===========================================================${NC}"
  echo -e "${BLUE}  $1${NC}"
  echo -e "${BLUE}===========================================================${NC}\n"
}

print_success() {
  echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
  echo -e "${RED}✗ $1${NC}"
}

print_warning() {
  echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
  echo -e "${BLUE}→ $1${NC}"
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

backup_file() {
  local file="$1"
  if [[ -e "$file" ]] && [[ ! -L "$file" ]]; then
    mkdir -p "$BACKUP_DIR"
    print_warning "Backing up existing file: $file"
    mv "$file" "$BACKUP_DIR/"
  fi
}

#############################################
# Prerequisite Checks
#############################################

check_macos() {
  print_header "Checking System Requirements"

  if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is only for macOS!"
    exit 1
  fi

  print_success "Running on macOS"
  print_info "macOS version: $(sw_vers -productVersion)"
}

#############################################
# Xcode Command Line Tools
#############################################

install_xcode_tools() {
  print_header "Installing Xcode Command Line Tools"

  if xcode-select -p &>/dev/null; then
    print_success "Xcode Command Line Tools already installed"
  else
    print_info "Installing Xcode Command Line Tools..."
    xcode-select --install

    print_warning "Please complete the Xcode installation in the dialog"
    print_warning "Press any key after installation completes..."
    read -n 1 -s

    print_success "Xcode Command Line Tools installed"
  fi
}

#############################################
# Homebrew Installation
#############################################

install_homebrew() {
  print_header "Installing Homebrew"

  if command_exists brew; then
    print_success "Homebrew already installed"
    print_info "Updating Homebrew..."
    brew update
  else
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"$HOME/.zprofile"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    print_success "Homebrew installed"
  fi
}

#############################################
# Install Packages from Brewfile
#############################################

install_packages() {
  print_header "Installing Packages from Brewfile"

  if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
    print_info "Installing from Brewfile..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
    print_success "All packages installed"
  else
    print_error "Brewfile not found at $DOTFILES_DIR/Brewfile"
    exit 1
  fi
}

#############################################
# Create Required Directories
#############################################

create_directories() {
  print_header "Creating Required Directories"

  local directories=(
    "$HOME/.config"
    "$HOME/.config/nvim"
    "$HOME/.config/karabiner"
    "$HOME/.config/git"
    "$HOME/Library/Application Support/com.mitchellh.ghostty"
  )

  for dir in "${directories[@]}"; do
    if [[ ! -d "$dir" ]]; then
      mkdir -p "$dir"
      print_success "Created: $dir"
    else
      print_info "Already exists: $dir"
    fi
  done
}

#############################################
# Stow Dotfiles
#############################################

stow_dotfiles() {
  print_header "Setting Up Dotfiles with Stow"

  cd "$DOTFILES_DIR"

  # Backup existing dotfiles if they're not symlinks
  print_info "Checking for existing dotfiles to backup..."
  backup_file "$HOME/.zshrc"
  backup_file "$HOME/.tmux.conf"

  # Stow configurations
  local configs=(
    "zshrc:$HOME"
    "tmux:$HOME"
    "nvim:$HOME/.config/nvim/"
    "karabiner:$HOME/.config/karabiner/"
    "ghostty:$HOME/Library/Application Support/com.mitchellh.ghostty"
    "git:$HOME/.config/git/"
  )

  for config in "${configs[@]}"; do
    local package="${config%%:*}"
    local target="${config#*:}"

    if [[ -d "$DOTFILES_DIR/$package" ]]; then
      print_info "Stowing $package to $target..."

      if [[ "$target" == "$HOME" ]]; then
        stow -v "$package" 2>&1 | grep -v "^BUG in find_stowed_path" || true
      else
        stow -v --target="$target" "$package" 2>&1 | grep -v "^BUG in find_stowed_path" || true
      fi

      print_success "$package stowed successfully"
    else
      print_warning "Package directory not found: $DOTFILES_DIR/$package"
    fi
  done

  if [[ -d "$BACKUP_DIR" ]]; then
    print_info "Backup created at: $BACKUP_DIR"
  fi
}

#############################################
# macOS System Preferences
#############################################

configure_macos() {
  print_header "Configuring macOS System Preferences"

  print_info "These settings will require admin password..."

  # Close System Preferences to prevent conflicts
  osascript -e 'tell application "System Preferences" to quit'

  # Dock settings
  print_info "Configuring Dock..."
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock show-recents -bool false
  defaults write com.apple.dock tilesize -int 48

  # Finder settings
  print_info "Configuring Finder..."
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder ShowStatusBar -bool true
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # Keyboard settings
  print_info "Configuring Keyboard..."
  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 15

  # Screenshot settings
  print_info "Configuring Screenshots..."
  defaults write com.apple.screencapture type -string "png"
  defaults write com.apple.screencapture location -string "$HOME/Desktop"
  defaults write com.apple.screencapture disable-shadow -bool true

  # Restart affected applications
  print_info "Restarting affected applications..."
  killall Dock 2>/dev/null || true
  killall Finder 2>/dev/null || true

  print_success "macOS preferences configured"
}

#############################################
# Setup Zsh as Default Shell
#############################################

setup_zsh() {
  print_header "Setting Up Zsh"

  if [[ "$SHELL" != "$(which zsh)" ]]; then
    print_info "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
    print_success "Zsh set as default shell (will take effect on next login)"
  else
    print_success "Zsh already set as default shell"
  fi
}

#############################################
# Post-Installation Tasks
#############################################

post_install() {
  print_header "Post-Installation Tasks"

  # fzf key bindings
  if command_exists fzf; then
    print_info "Setting up fzf key bindings..."
    if [[ ! -f "$HOME/.fzf.zsh" ]]; then
      $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
      print_success "fzf key bindings installed"
    else
      print_success "fzf already configured"
    fi
  fi

  # tmux plugin manager
  if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    print_info "Installing tmux plugin manager (tpm)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    print_success "tpm installed (run prefix + I in tmux to install plugins)"
  else
    print_success "tmux plugin manager already installed"
  fi
}

#############################################
# Cleanup
#############################################

cleanup() {
  print_header "Cleanup"

  print_info "Running brew cleanup..."
  brew cleanup

  print_success "Cleanup complete"
}

#############################################
# Final Summary
#############################################

print_summary() {
  print_header "Installation Complete!"

  echo -e "${GREEN}Your macOS setup is complete!${NC}\n"

  echo -e "${BLUE}Next steps:${NC}"
  echo -e "  1. Restart your terminal or run: ${YELLOW}source ~/.zshrc${NC}"
  echo -e "  2. Open tmux and press ${YELLOW}prefix + I${NC} to install tmux plugins"
  echo -e "  3. Open Neovim and let plugins install automatically"
  echo -e "  4. Configure Karabiner-Elements (manually launch the app)"
  echo -e "  5. Configure Alfred (manually launch the app)"
  echo -e "  6. Sign in to GitHub CLI: ${YELLOW}gh auth login${NC}"

  if [[ -d "$BACKUP_DIR" ]]; then
    echo -e "\n${YELLOW}Note:${NC} Backed up existing dotfiles to: ${BLUE}$BACKUP_DIR${NC}"
  fi

  echo -e "\n${GREEN}Enjoy your new setup!${NC}\n"
}

#############################################
# Main Execution
#############################################

main() {
  echo -e "${BLUE}"
  cat <<"EOF"
    ╔═══════════════════════════════════════════════════╗
    ║                                                   ║
    ║          macOS Bootstrap Script                  ║
    ║                                                   ║
    ╚═══════════════════════════════════════════════════╝
EOF
  echo -e "${NC}"

  print_warning "This script will set up your macOS environment with:"
  echo "  • Homebrew and packages"
  echo "  • Dotfiles (zsh, tmux, nvim, karabiner, ghostty, git)"
  echo "  • macOS system preferences"
  echo ""
  read -p "Continue? (y/N) " -n 1 -r
  echo

  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_error "Installation cancelled"
    exit 1
  fi

  # Run installation steps
  check_macos
  install_xcode_tools
  install_homebrew
  install_packages
  create_directories
  stow_dotfiles
  setup_zsh
  configure_macos
  post_install
  cleanup
  print_summary
}

# Run main function
main "$@"
