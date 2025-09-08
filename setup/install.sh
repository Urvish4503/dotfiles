#!/bin/bash

sudo pacman -Syu
sudo pacman -S git stow 

cd /home/urvish
git clone https://github.com/Urvish4503/dotfiles.git

cd dotfiles
stow .

cd ~


echo "Installing packages via pacman..."
sudo pacman -S --needed \
    waybar \
    neovim \
    zsh \
    rofi \
    cliphist \
    kitty \
    eza \
    hyprland \
    socat \
    jq \
    awk \
    perl \
    curl \
    upower \
    brightnessctl \
    auto-cpufreq \
    cava \
    python \
    python-pywayland \
    cantarell-fonts \
    noto-fonts-cjk \
    ttf-jetbrains-mono-nerd \
    ttf-nerd-fonts-symbols-common \
    ttf-nerd-fonts-symbols \
    ttf-nerd-fonts-symbols-mono \
    ttf-dosis

echo "Installing AUR packages via yay..."
yay -S --needed \
    eww-wayland \
    eww-git \
    matugen \
    python-pywal

echo "Package installation complete!"
