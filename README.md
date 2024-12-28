# Dotfiles

Config files of my superuser OS (I use Arch btw).

## Packages

- Alacritty (Rust terminal);
- Conda (package & environment manager);
- Hadoop & Spark zsh config (for school);
- JetBrains Toolbox & PyCharm
- NVM (Node version manager);
- Obsidian
- Oh My Zsh (better Zsh):
- Powerlevel10k (beautiful command line);
- Youtube Music
- Zoxide (smarter `cd` command).

## Wrong scaling per application

Electron-based and Chromium-based applications don't use Wayland by default.
In order to have the same scaling as the global setting, enforce each
application to do so:

1. Edit the `.desktop` file of the application.
   You can your applications in either `/opt/` or `~/.local/share/applications`.
2. Add `--enable-features=UseOzonePlatform --ozone-platform=wayland` at the end
   of the `Exec` line.
   Example for Discord Canary:

   ```text
   [Desktop Entry]
   Name=Discord Canary
   ...
   Exec=/usr/bin/discord-canary --enable-features=UseOzonePlatform --ozone-platform=wayland
   ...
   ```
If you don't find the .desktop file, it can maybe be edited in the settings of
the application.
Look up on internet how you can enforce Wayland for your application.
