## Step 1: Update arch
```bash
sudo pacman -Syu
```
## Step 2: Install yay
```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
## Step 3: Install essential packages
```bash
yay -S eww-wayland 
```
