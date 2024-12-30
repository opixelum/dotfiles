#!/bin/bash

packages=(
    brave-bin
    discord-canary
    fzf  # Zoxide auto-completion dependency
    gimp
    jetbrains-toolbox
    neofetch
    obsidian
    signal-desktop
    tree
    unzip
    wget
    youtube-music-bin
    zoxide
)

yay -Syu --noconfirm "${packages[@]}"

# Install fonts
echo "Installing fonts..."
sudo cp -r usr/share/fonts/ArgentumSans /usr/share/fonts/
fc-cache

echo "Done."
