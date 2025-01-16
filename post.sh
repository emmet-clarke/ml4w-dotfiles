#!/bin/bash
# ------------------------------------------------------
# Don't edit this section
# Include scripts.sh with helper functions
source library/scripts.sh
# ------------------------------------------------------

# Show Current version
echo ":: Running hook for ML4W Dotfiles $version"

echo ":: Getting latest version and copying dotfiles from ~/ml4w-dotfiles to ~/dotfiles"
cd /home/emmet/ml4w-dotfiles
git pull
cp -r nvim ~/dotfiles/.config/
cp -r zshrc ~/dotfiles/.config/
cp -r kitty ~/dotfiles/.config/
cp -r windowrules ~/dotfiles/.config/hypr/conf/
