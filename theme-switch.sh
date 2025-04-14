#!/bin/bash
# Cosmic Theme Switcher
# This script allows easy switching between Cosmic themes for Kitty terminal

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}       Cosmic Theme Switcher${NC}"
echo -e "${BLUE}================================================${NC}"

# Check if Kitty config exists
if [ ! -f ~/.config/kitty/kitty.conf ]; then
    echo -e "${YELLOW}Error: Kitty config not found. Is Kitty installed?${NC}"
    exit 1
fi

# List available themes
echo -e "${BLUE}Available themes:${NC}"
echo "1) Nebula (Space-inspired dark theme)"
echo "2) Solar (Light theme with warm accents)"
echo "3) Forest (Green nature-inspired theme)"
echo "4) Ocean (Blue oceanic theme)"
echo "5) Midnight (Deep dark theme)"
echo "6) Dark Neon (Cyberpunk-inspired neon theme)"
echo

# Get user selection
read -p "Enter theme number (1-6): " theme_number
echo

# Set theme file based on selection
case $theme_number in
    1)
        theme_file="nebula.conf"
        theme_name="Nebula"
        ;;
    2)
        theme_file="solar.conf"
        theme_name="Solar"
        ;;
    3)
        theme_file="forest.conf"
        theme_name="Forest"
        ;;
    4)
        theme_file="ocean.conf"
        theme_name="Ocean"
        ;;
    5)
        theme_file="midnight.conf"
        theme_name="Midnight"
        ;;
    6)
        theme_file="dark-neon.conf"
        theme_name="Dark Neon"
        ;;
    *)
        echo -e "${YELLOW}Invalid selection. Exiting.${NC}"
        exit 1
        ;;
esac

# Update kitty.conf to use selected theme
sed -i '/include themes\/nebula.conf/d' ~/.config/kitty/kitty.conf
sed -i '/include themes\/solar.conf/d' ~/.config/kitty/kitty.conf
sed -i '/include themes\/forest.conf/d' ~/.config/kitty/kitty.conf
sed -i '/include themes\/ocean.conf/d' ~/.config/kitty/kitty.conf
sed -i '/include themes\/midnight.conf/d' ~/.config/kitty/kitty.conf
sed -i '/include themes\/dark-neon.conf/d' ~/.config/kitty/kitty.conf

# Ensure Cosmic Theme Pack marker exists
if ! grep -q "# Cosmic Theme Pack" ~/.config/kitty/kitty.conf; then
    echo -e "\n# Cosmic Theme Pack" >> ~/.config/kitty/kitty.conf
fi

# Add new theme include
echo "include themes/${theme_file}" >> ~/.config/kitty/kitty.conf

echo -e "${GREEN}Theme switched to ${theme_name}!${NC}"
echo -e "${BLUE}Restart Kitty terminal to apply changes.${NC}"