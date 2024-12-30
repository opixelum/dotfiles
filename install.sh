#!/bin/bash

packages=(
    alacritty
    brave-bin
    discord-canary
    fzf  # Zoxide auto-completion dependency
    gimp
    hypridle
    hyprlock
    hyprsunset
    jetbrains-toolbox
    neofetch
    obsidian
    signal-desktop
    swaybg
    tree
    unzip
    wget
    youtube-music-bin
    zoxide
)
yay -Syu --noconfirm "${packages[@]}"

echo "Enforcing Wayland for all applications..."
sudo cp -r usr/share/applications /usr/share/

echo "Copying wallpapers..."
mkdir ~/Pictures/
cp -r home/user/Pictures/Wallpapers/ ~/Pictures/

echo "Installing fonts..."
sudo cp -r usr/share/fonts/ /usr/share/
fc-cache

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

echo "Done."
