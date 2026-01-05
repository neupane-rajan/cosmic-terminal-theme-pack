#!/bin/bash
# Enhanced Cosmic Theme Pack Uninstaller
# This script completely removes the Cosmic theme pack and restores original configurations

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}       Cosmic Theme Pack Uninstaller${NC}"
echo -e "${BLUE}================================================${NC}"

# Ask for confirmation
echo -e "${YELLOW}This will completely remove all Cosmic theme files from your system.${NC}"
read -p "Continue? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${BLUE}Uninstallation cancelled.${NC}"
    exit 0
fi

# Check for backups and restore them
echo -e "${GREEN}Checking for configuration backups...${NC}"

# Restore Kitty configuration
if [ -f ~/.config/kitty/kitty.conf.cosmic.bak ]; then
    echo -e "${GREEN}Restoring original kitty.conf...${NC}"
    mv ~/.config/kitty/kitty.conf.cosmic.bak ~/.config/kitty/kitty.conf
else
    echo -e "${YELLOW}No kitty.conf backup found. Cleaning existing configuration...${NC}"
    if [ -f ~/.config/kitty/kitty.conf ]; then
        # Remove theme includes from kitty.conf
        sed -i '/# Cosmic Theme Pack/d' ~/.config/kitty/kitty.conf
        sed -i '/include themes\/nebula.conf/d' ~/.config/kitty/kitty.conf
        sed -i '/include themes\/solar.conf/d' ~/.config/kitty/kitty.conf
        sed -i '/include themes\/forest.conf/d' ~/.config/kitty/kitty.conf
        sed -i '/include themes\/ocean.conf/d' ~/.config/kitty/kitty.conf
        sed -i '/include themes\/midnight.conf/d' ~/.config/kitty/kitty.conf
        sed -i '/include themes\/dark-neon.conf/d' ~/.config/kitty/kitty.conf
        
        # Remove font configuration added by cosmic
        sed -i '/# Font configuration/d' ~/.config/kitty/kitty.conf
        sed -i '/font_family JetBrainsMono Nerd Font/d' ~/.config/kitty/kitty.conf
        sed -i '/bold_font auto/d' ~/.config/kitty/kitty.conf
        sed -i '/italic_font auto/d' ~/.config/kitty/kitty.conf
        sed -i '/bold_italic_font auto/d' ~/.config/kitty/kitty.conf
        sed -i '/font_size 12.0/d' ~/.config/kitty/kitty.conf
    fi
fi



# Remove theme files and directories
echo -e "${GREEN}Removing theme files...${NC}"
rm -rf ~/.config/kitty/themes/nebula.conf
rm -rf ~/.config/kitty/themes/solar.conf
rm -rf ~/.config/kitty/themes/forest.conf
rm -rf ~/.config/kitty/themes/ocean.conf
rm -rf ~/.config/kitty/themes/midnight.conf
rm -rf ~/.config/kitty/themes/dark-neon.conf
rm -rf ~/.config/kitty/themes/cyberpunk.conf

# If themes directory is empty, remove it
if [ -d ~/.config/kitty/themes ] && [ -z "$(ls -A ~/.config/kitty/themes)" ]; then
    rmdir ~/.config/kitty/themes
fi

# Clean up Neofetch configuration
echo -e "${GREEN}Cleaning up Neofetch configurations...${NC}"
rm -f ~/.config/neofetch/config.cosmic.conf

# Remove bash function for cosmic-fetch if it exists
if [ -f ~/.cosmic-fetch ]; then
    rm -f ~/.cosmic-fetch
fi

# Remove from .bashrc if present
if [ -f ~/.bashrc ]; then
    sed -i '/# Cosmic Theme Pack/d' ~/.bashrc
    sed -i '/function cosmic-fetch()/d' ~/.bashrc
    sed -i '/cosmic-fetch()/d' ~/.bashrc
    sed -i '/~\/.config\/fastfetch\/run-cosmic.sh/d' ~/.bashrc
    sed -i '/neofetch --config ~\/.config\/neofetch\/config.cosmic.conf/d' ~/.bashrc
    sed -i '/export -f cosmic-fetch/d' ~/.bashrc
fi

# Remove from .zshrc if present
if [ -f ~/.zshrc ]; then
    sed -i '/# Cosmic Theme Pack/d' ~/.zshrc
    sed -i '/cosmic-fetch()/d' ~/.zshrc
    sed -i '/~\/.config\/fastfetch\/run-cosmic.sh/d' ~/.zshrc
fi

# Clean up Fastfetch configurations
echo -e "${GREEN}Cleaning up Fastfetch configurations...${NC}"
rm -rf ~/.config/fastfetch/config.jsonc
rm -rf ~/.config/fastfetch/run-cosmic.sh
rm -rf ~/.config/fastfetch/logos

# If fastfetch directory is empty, remove it
if [ -d ~/.config/fastfetch ] && [ -z "$(ls -A ~/.config/fastfetch)" ]; then
    rmdir ~/.config/fastfetch
fi

# Clean up empty directories
echo -e "${GREEN}Cleaning up empty directories...${NC}"


# Final message
echo -e "${GREEN}Uninstallation complete!${NC}"
echo -e "${BLUE}Your original configuration has been restored where possible.${NC}"
echo -e "${BLUE}Thank you for trying Cosmic Theme Pack!${NC}"
echo -e "${YELLOW}Please restart your terminal to apply all changes.${NC}"