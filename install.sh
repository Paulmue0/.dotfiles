# Run this script in .dotfiles/
#
#
#
#
# install stow
brew install stow

#--- stow dotfiles
#--------- MAKE SURE ALL TARGET PATH EXIST
stow nvim
stow tmux
stow zshrc
stow --target="$HOME/.config/karabiner/" karabiner
stow --target="$HOME/Library/Application Support/com.mitchellh.ghostty" ghostty
stow --target="$HOME/.config/git/" git
