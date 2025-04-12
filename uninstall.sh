#!/bin/bash
# Cosmic Theme Pack Uninstaller
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
    fi
fi

# Restore Fish prompt
if [ -f ~/.config/fish/functions/fish_prompt.fish.cosmic.bak ]; then
    echo -e "${GREEN}Restoring original fish_prompt.fish...${NC}"
    mv ~/.config/fish/functions/fish_prompt.fish.cosmic.bak ~/.config/fish/functions/fish_prompt.fish
fi

# Restore Fish right prompt
if [ -f ~/.config/fish/functions/fish_right_prompt.fish.cosmic.bak ]; then
    echo -e "${GREEN}Restoring original fish_right_prompt.fish...${NC}"
    mv ~/.config/fish/functions/fish_right_prompt.fish.cosmic.bak ~/.config/fish/functions/fish_right_prompt.fish
fi

# Remove Fish theme color configuration
if [ -f ~/.config/fish/conf.d/theme-colors.fish ]; then
    echo -e "${GREEN}Removing Fish theme color configuration...${NC}"
    rm -f ~/.config/fish/conf.d/theme-colors.fish
fi

# Remove custom functions
echo -e "${GREEN}Removing cosmic functions...${NC}"
rm -f ~/.config/fish/functions/cosmic_functions.fish

# Remove theme directories
echo -e "${GREEN}Removing theme directories...${NC}"
rm -rf ~/.config/kitty/themes/cosmic
# If themes directory is empty after removal, remove it too
if [ -d ~/.config/kitty/themes ] && [ -z "$(ls -A ~/.config/kitty/themes)" ]; then
    rmdir ~/.config/kitty/themes
fi

# Remove individual theme files that might be outside the cosmic directory
echo -e "${GREEN}Removing individual theme files...${NC}"
rm -f ~/.config/kitty/themes/nebula.conf
rm -f ~/.config/kitty/themes/solar.conf
rm -f ~/.config/kitty/themes/forest.conf
rm -f ~/.config/kitty/themes/ocean.conf
rm -f ~/.config/kitty/themes/midnight.conf

# Check if fish has any cosmic-specific settings in config.fish
if [ -f ~/.config/fish/config.fish ]; then
    echo -e "${GREEN}Cleaning cosmic references from fish config...${NC}"
    sed -i '/# Cosmic Theme Pack/d' ~/.config/fish/config.fish
    sed -i '/source.*cosmic/d' ~/.config/fish/config.fish
fi

# Remove any empty directories created by the installation
echo -e "${GREEN}Cleaning up empty directories...${NC}"
find ~/.config/fish/conf.d -type d -empty -delete 2>/dev/null
find ~/.config/fish/functions -type d -empty -delete 2>/dev/null

# Final message
echo -e "${GREEN}Uninstallation complete!${NC}"
echo -e "${BLUE}Your original configuration has been restored where possible.${NC}"
echo -e "${BLUE}Thank you for trying Cosmic Theme Pack!${NC}"
echo -e "${YELLOW}Please restart your terminal to apply all changes.${NC}"
