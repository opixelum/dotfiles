#!/bin/bash

packages=(
    alacritty
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

echo "Setting up Hyprland..."
cp -r home/user/.config/hypr ~/.config/

echo "Setting up Alacritty..."
cp -r home/user/.config/alacritty ~/.config/

echo "Setting up Zsh..."
cp home/user/.zshrc ~/

echo "Setting up Powerlevel10k..."
cp home/user/.p10k.zsh ~/

echo "Setting up Vim..."
cp home/user/.vimrc ~/
cp -r home/user/.vim/ ~/

echo "Installing fonts..."
sudo cp -r usr/share/fonts/ArgentumSans /usr/share/fonts/
fc-cache

echo "Done."
