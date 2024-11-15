#### DPENDENCY

```
# APT PACKAGES
sudo apt install xserver-xorg xinit libpangocairo-1.0-0 python3-pip python3-xcffib python3-cairocffi feh picom dunst zsh playerctl brightnessctl kitty thunar rofi ranger pulseaudio alsa-utils vim git xsel

# SNAP PACKAGES
sudo snap install nvim classic

# STARSHIP
curl -sS https://starship.rs/install.sh | sh

```

```
# PYTHON PACKAGES
pip install qtile dbus-next psutil

```

```
# SETUP ENVIRONMENT
chsh -s $(which zsh)

# OH MY ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cd ~/Downloads/
git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git
cd pokemon-colorscripts
sudo ./install.sh


git clone https://github.com/dot-ASH/my-linux-machine.git
cd ./my-linux-machine/qtile/
cp config-sync.sh .vimrc .zshrc ~/.
rsync -av dotfiles/* ~/.config/

```

```
# QTILE

cd /usr/share/xsessions/
sudo vim qtile.desktop

[Desktop Entry]
Name=Qtile
Comment=Qtile Session
Exec=qtile start
Type=Application
Keywords=wm;tiling

```

```
# FONTS

- CaskadiyanCove Nerd
- FiraCode Nerd
- Liga SFMono Nerd Font SemiBold
# https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized

```

```
# VENCORD (DISCORD)
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"

```

