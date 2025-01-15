#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 [--noapps] [--minimal] [--help]"
    echo
    echo "Options:"
    echo "  --noapps   Skip the installation of desktop applications."
    echo "  --minimal         Skip the installation of both desktop environment packages (Hyprland) and desktop applications."
    echo "  --help            Display this help message."
    exit 0
}

# Parse arguments
INSTALL_DESKTOP_ENV=true
INSTALL_APPS=true

for arg in "$@"; do
    case $arg in
        --noapps)
            INSTALL_APPS=false
            ;;
        --minimal)
            INSTALL_DESKTOP_ENV=false
            INSTALL_APPS=false
            ;;
        --help)
            usage
            ;;
        *)
            echo "Invalid option: $arg"
            usage
            ;;
    esac
    shift
done

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

echo "Installing minimal packages..."
minimal_packages=(
    btop
    eza  # Blazing fast `ls`
    fzf  # Zoxide auto-completion dependency
    neofetch
    tree
    unzip
    vim
    wget
    zoxide  # Blazing fast `cd`
    zsh
    zsh-completions
)
yay -Syu --needed --noconfirm "${minimal_packages[@]}"

echo "Setting up Zsh..."
chsh -s /usr/bin/zsh

echo "Setting up Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp home/user/.zshrc ~/
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Setting up Vim..."
cp home/user/.vimrc ~/
cp -r home/user/.vim/ ~/

if [ "$INSTALL_DESKTOP_ENV" = true ]; then
    echo "Installing desktop environment packages..."
    desktop_environment_packages=(
        alacritty
        dunst  # Notifications manager
        gdm  # Login screen
        hypridle  # Idle management daemon
        hyprland
        hyprlock  # Lock screen
        hyprpaper  # Wallpaper manager
        hyprsunset  # Blue light filter
        jq  # For volume control
        nautilus  # File explorer
        pamixer  # For volume control
        parallel  # For volume control
        uwsm  # Universal Wayland Session Manager
        vlc
        wofi  # Application launcher
    )
    yay -Syu --needed --noconfirm "${desktop_environment_packages[@]}"

    echo "Setting up UWSM..."
    cp -r home/user/.config/uwsm ~/.config

    echo "Copying wallpapers..."
    mkdir -p ~/Pictures/
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

    echo "Setting up Powerlevel10k..."
    cp home/user/.p10k.zsh ~/
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    echo "Setting up GDM..."
    sudo cp gnome-shell-theme.gresource /usr/share/gnome-shell
fi

if [ "$INSTALL_APPS" = true ]; then
    echo "Installing desktop applications packages..."
    apps_packages=(
        brave-bin
        discord-canary
        gimp
        jetbrains-toolbox
        obsidian
        signal-desktop
    )
    yay -Syu --needed --noconfirm "${apps_packages[@]}"

    echo "Fixing scaling for Electron apps..."
    cp home/user/.local/share/applications ~/.local/share/

    # Fix scaling on JetBrains apps
fi

echo "Done. Restarting session..."
sudo systemctl enable --now gdm.service
