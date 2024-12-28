#!/bin/bash

packages=(
    brave-bin
    discord-canary
    fzf  # Zoxide auto-completion dependency
    neofetch
    signal-desktop
    tree
    wget
    zoxide
)

yay -Syu --noconfirm "${packages[@]}"
