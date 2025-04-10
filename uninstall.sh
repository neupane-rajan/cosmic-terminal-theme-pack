# uninstall.sh
#!/bin/bash
# Cosmic Theme Pack Uninstaller
# This script removes the Cosmic theme pack for Kitty terminal and Fish shell

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
echo -e "${YELLOW}This will remove all Cosmic theme files from your system.${NC}"
read -p "Continue? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${BLUE}Uninstallation cancelled.${NC}"
    exit 0
fi

# Remove Kitty themes
echo -e "${GREEN}Removing Kitty themes...${NC}"
rm -f ~/.config/kitty/themes/nebula.conf
rm -f ~/.config/kitty/themes/solar.conf
rm -f ~/.config/kitty/themes/forest.conf
rm -f ~/.config/kitty/themes/ocean.conf
rm -f ~/.config/kitty/themes/midnight.conf

# Remove theme includes from kitty.conf
if [ -f ~/.config/kitty/kitty.conf ]; then
    echo -e "${GREEN}Cleaning up kitty.conf...${NC}"
    sed -i '/# Cosmic Theme Pack/d' ~/.config/kitty/kitty.conf
    sed -i '/include themes\/nebula.conf/d' ~/.config/kitty/kitty.conf
    sed -i '/include themes\/solar.conf/d' ~/.config/kitty/kitty.conf
    sed -i '/include themes\/forest.conf/d' ~/.config/kitty/kitty.conf
    sed -i '/include themes\/ocean.conf/d' ~/.config/kitty/kitty.conf
    sed -i '/include themes\/midnight.conf/d' ~/.config/kitty/kitty.conf
fi

# Remove Fish prompt and configuration
echo -e "${GREEN}Removing Fish prompt and configuration...${NC}"
rm -f ~/.config/fish/functions/fish_prompt.fish
rm -f ~/.config/fish/functions/fish_right_prompt.fish
rm -f ~/.config/fish/conf.d/theme-colors.fish

# Notify user about manual restoration
echo -e "${YELLOW}Note: If you had custom fish prompts before installation,${NC}"
echo -e "${YELLOW}you may need to restore them manually.${NC}"

# Completion
echo -e "${GREEN}Uninstallation complete!${NC}"
echo -e "${BLUE}Thank you for trying Cosmic Theme Pack!${NC}"
echo -e "${BLUE}To apply changes, please restart your terminal.${NC}"
