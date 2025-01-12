#!/bin/bash

echo "Installing Yay..."
sudo pacman -Syu --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
rm -rf yay-bin
yay -Y --gendb --noconfirm
yay -Syu --devel --noconfirm
yay -Y --devel --save --noconfirm
yay -Fy --noconfirm

echo "Configuring mirrors..."
yay -S --needed --noconfirm reflector
sudo cp etc/xdg/reflector/reflector.conf /etc/xdg/reflector/
sudo systemctl start reflector.service
sudo systemctl enable --now reflector.timer

echo "Installing packages..."
packages=(
    alacritty
    brave-bin
    btop
    discord-canary
    dunst  # Notiications manager
    eza  # Blazing fast `ls`
    fzf  # Zoxide auto-completion dependency
    gdm  # Login screen
    gimp
    hypridle  # Idle management daemon
    hyprland
    hyprlock  # Lock screen
    hyprpaper  # Wallpaper manager
    hyprsunset  # Blue light filter
    jetbrains-toolbox
    jq  # For volume control
    nautilus  # File explorer
    neofetch
    obsidian
    pamixer  # For volume control
    parallel  # For volume control
    signal-desktop
    tree
    unzip
    uwsm  # Universal Wayland Session Manager
    vim
    vlc
    wget
    wofi  # Application launcher
    youtube-music-bin
    zoxide  # Blazing fast `cd`
    zsh
    zsh-completions
)
yay -Syu --needed --noconfirm "${packages[@]}"

# echo "Enforcing Wayland for all applications..."
# sudo cp -r usr/share/applications /usr/share/

echo "Setting up UWSM..."
cp -r home/user/.config/uwsm ~/.config

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
chsh -s /usr/bin/zsh

echo "Setting up Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp home/user/.zshrc ~/
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Setting up Powerlevel10k..."
cp home/user/.p10k.zsh ~/
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Setting up Vim..."
cp home/user/.vimrc ~/
cp -r home/user/.vim/ ~/

echo "Setting up GDM..."
sudo cp gnome-shell-theme.gresource /usr/share/gnome-shell

echo "Done. Restarting session..."
sudo systemctl enable --now gdm.service
