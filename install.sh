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
    wget
    youtube-music-bin
    zoxide
)

yay -Syu --noconfirm "${packages[@]}"
