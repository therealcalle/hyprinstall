#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

# Update the system
echo -e "${GREEN}Updating the system...${NC}"
sudo pacman -Syu --noconfirm

# Check if paru is installed, if not, install it
if ! command -v paru &> /dev/null; then
    echo -e "${RED}paru is not installed. Installing paru...${NC}"
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
    cd ..
    rm -rf paru
else
    echo -e "${GREEN}paru is already installed.${NC}"
fi

# Install required packages with paru
echo -e "${GREEN}Installing required packages with paru...${NC}"
paru -S --noconfirm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg fuse2 python311 cmake pyqt5 openrgb zen-browser-bin discord visual-studio-code-bin spotify-launcher nemo nemo-fileroller hyprpaper eog vlc
echo -e "${GREEN}Required packages have been installed.${NC}"

# Clone the dotfiles repository
DOTFILES_REPO="https://github.com/therealcalle/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${GREEN}Cloning dotfiles repository...${NC}"
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    echo -e "${GREEN}Dotfiles repository already exists at $DOTFILES_DIR.${NC}"
fi

# Move the Bilder folder to the home directory
BILDER_SRC="$DOTFILES_DIR/Bilder"
BILDER_DEST="$HOME/Bilder"

if [ -d "$BILDER_SRC" ]; then
    echo -e "${GREEN}Copying Bilder folder to $HOME...${NC}"
    cp -r "$BILDER_SRC/"* "$BILDER_DEST/"
    echo -e "${GREEN}Bilder folder has been updated.${NC}"
else
    echo -e "${RED}Bilder folder does not exist in the repository.${NC}"
fi

# Move the fastfetch folder to the .config directory
FASTFETCH_SRC="$DOTFILES_DIR/fastfetch"
FASTFETCH_DEST="$HOME/.config/fastfetch"

if [ -d "$FASTFETCH_SRC" ]; then
    echo -e "${GREEN}Copying fastfetch folder to .config...${NC}"
    mkdir -p "$FASTFETCH_DEST"
    cp -r "$FASTFETCH_SRC/"* "$FASTFETCH_DEST/"
    echo -e "${GREEN}fastfetch folder has been updated.${NC}"
else
    echo -e "${RED}fastfetch folder does not exist in the repository.${NC}"
fi

# Move the hypr folder to the .config directory
HYPR_SRC="$DOTFILES_DIR/hypr"
HYPR_DEST="$HOME/.config/hypr"

if [ -d "$HYPR_SRC" ]; then
    echo -e "${GREEN}Copying hypr folder to .config...${NC}"
    mkdir -p "$HYPR_DEST"
    cp -r "$HYPR_SRC/"* "$HYPR_DEST/"
    echo -e "${GREEN}hypr folder has been updated.${NC}"
else
    echo -e "${RED}hypr folder does not exist in the repository.${NC}"
fi

# Move the rofi folder to the .config directory
ROFI_SRC="$DOTFILES_DIR/rofi"
ROFI_DEST="$HOME/.config/rofi"

if [ -d "$ROFI_SRC" ]; then
    echo -e "${GREEN}Copying rofi folder to .config...${NC}"
    mkdir -p "$ROFI_DEST"
    cp -r "$ROFI_SRC/"* "$ROFI_DEST/"
    echo -e "${GREEN}rofi folder has been updated.${NC}"
else
    echo -e "${RED}rofi folder does not exist in the repository.${NC}"
fi

# Move the waybar folder to the .config directory
WAYBAR_SRC="$DOTFILES_DIR/waybar"
WAYBAR_DEST="$HOME/.config/waybar"

if [ -d "$WAYBAR_SRC" ]; then
    echo -e "${GREEN}Copying waybar folder to .config...${NC}"
    mkdir -p "$WAYBAR_DEST"
    cp -r "$WAYBAR_SRC/"* "$WAYBAR_DEST/"
    echo -e "${GREEN}waybar folder has been updated.${NC}"

    # Make cpun.sh and gpu.sh executable
    MODULES_DIR="$WAYBAR_DEST/modules"
    if [ -d "$MODULES_DIR" ]; then
        echo -e "${GREEN}Making cpun.sh and gpu.sh executable...${NC}"
        chmod +x "$MODULES_DIR/cpun.sh" "$MODULES_DIR/gpu.sh"
        echo -e "${GREEN}cpun.sh and gpu.sh are now executable.${NC}"
    else
        echo -e "${RED}Modules folder does not exist in waybar directory.${NC}"
    fi
else
    echo -e "${RED}waybar folder does not exist in the repository.${NC}"
fi

# Move the OpenRGB folder to the .config directory
OPENRGB_SRC="$DOTFILES_DIR/OpenRGB"
OPENRGB_DEST="$HOME/.config/OpenRGB"

if [ -d "$OPENRGB_SRC" ]; then
    echo -e "${GREEN}Copying OpenRGB folder to .config...${NC}"
    mkdir -p "$OPENRGB_DEST"
    cp -r "$OPENRGB_SRC/"* "$OPENRGB_DEST/"
    echo -e "${GREEN}OpenRGB folder has been updated.${NC}"
else
    echo -e "${RED}OpenRGB folder does not exist in the repository.${NC}"
fi

# Move the input-remapper-2 folder to the .config directory
INPUT_REMAPPER_SRC="$DOTFILES_DIR/input-remapper-2"
INPUT_REMAPPER_DEST="$HOME/.config/input-remapper-2"

if [ -d "$INPUT_REMAPPER_SRC" ]; then
    echo -e "${GREEN}Copying input-remapper-2 folder to .config...${NC}"
    mkdir -p "$INPUT_REMAPPER_DEST"
    cp -r "$INPUT_REMAPPER_SRC/"* "$INPUT_REMAPPER_DEST/"
    echo -e "${GREEN}input-remapper-2 folder has been updated.${NC}"
else
    echo -e "${RED}input-remapper-2 folder does not exist in the repository.${NC}"
fi

# Move the settings.json file to the .config/Code/User directory
SETTINGS_SRC="$DOTFILES_DIR/settings.json"
SETTINGS_DEST="$HOME/.config/Code/User/settings.json"

if [ -f "$SETTINGS_SRC" ]; then
    echo -e "${GREEN}Copying settings.json to .config/Code/User...${NC}"
    mkdir -p "$(dirname "$SETTINGS_DEST")"
    cp "$SETTINGS_SRC" "$SETTINGS_DEST"
    echo -e "${GREEN}settings.json has been updated.${NC}"
else
    echo -e "${RED}settings.json does not exist in the repository.${NC}"
fi

# Move the sddm.conf file to /etc/
SDDM_CONF_SRC="$DOTFILES_DIR/sddm/etc/sddm.conf"
SDDM_CONF_DEST="/etc/sddm.conf"

if [ -f "$SDDM_CONF_SRC" ]; then
    echo -e "${GREEN}Copying sddm.conf to /etc/...${NC}"
    sudo cp "$SDDM_CONF_SRC" "$SDDM_CONF_DEST"
    echo -e "${GREEN}sddm.conf has been updated.${NC}"
else
    echo -e "${RED}sddm.conf does not exist in the repository.${NC}"
fi

# Copy the entire sugar-candy folder to /usr/share/sddm/themes/sugar-candy
SUGAR_CANDY_SRC="$DOTFILES_DIR/sddm/usr/share/sddm/themes/sugar-candy"
SUGAR_CANDY_DEST="/usr/share/sddm/themes/sugar-candy"

if [ -d "$SUGAR_CANDY_SRC" ]; then
    echo -e "${GREEN}Copying the entire sugar-candy folder to /usr/share/sddm/themes/sugar-candy/...${NC}"
    sudo mkdir -p "$SUGAR_CANDY_DEST"
    sudo cp -r "$SUGAR_CANDY_SRC/"* "$SUGAR_CANDY_DEST/"
    echo -e "${GREEN}sugar-candy theme has been updated.${NC}"
else
    echo -e "${RED}sugar-candy theme folder does not exist in the repository.${NC}"
fi

# Cleanup the dotfiles repository
echo -e "${GREEN}Cleaning up the dotfiles repository...${NC}"
rm -rf "$DOTFILES_DIR"
echo -e "${GREEN}Setup script completed successfully.${NC}"
