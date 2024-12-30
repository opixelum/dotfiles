#!/bin/bash

echo "Installing packages..."
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

echo "Enforcing Wayland for all applications..."
sudo cp -r usr/share/applications /usr/share/

echo "Setting up Waybar..."
cp -r home/user/.config/waybar ~/.config/

echo "Installing fonts..."
sudo cp -r usr/share/fonts/ArgentumSans /usr/share/fonts/
fc-cache

echo "Done."
