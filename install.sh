# Run this script in .dotfiles/
#
#
#
#
# install stow
brew install stow

#--- stow dotfiles
#--------- MAKE SURE ALL TARGET PATH EXIST
stow zshrc
stow tmux
stow --target="$HOME/.config/nvim/" nvim
stow --target="$HOME/.config/karabiner/" karabiner
stow --target="$HOME/Library/Application Support/com.mitchellh.ghostty" ghostty
stow --target="$HOME/.config/git/" git
