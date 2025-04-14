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

# Clean up Fish shell configurations
if command -v fish &> /dev/null; then
    echo -e "${GREEN}Cleaning up Fish shell configurations...${NC}"
    
    # Remove custom Fish prompt files
    rm -f ~/.config/fish/functions/fish_prompt.fish
    rm -f ~/.config/fish/functions/fish_right_prompt.fish
    rm -f ~/.config/fish/functions/fish_greeting.fish
    rm -f ~/.config/fish/functions/cosmic_functions.fish
    rm -f ~/.config/fish/functions/cosmic-fetch.fish
    
    # Remove theme color configurations
    rm -f ~/.config/fish/conf.d/theme-colors.fish
    rm -f ~/.config/fish/conf.d/cosmic_loader.fish
    
    # Restore backups if they exist
    if [ -f ~/.config/fish/functions/fish_prompt.fish.cosmic.bak ]; then
        mv ~/.config/fish/functions/fish_prompt.fish.cosmic.bak ~/.config/fish/functions/fish_prompt.fish
    fi
    
    if [ -f ~/.config/fish/functions/fish_right_prompt.fish.cosmic.bak ]; then
        mv ~/.config/fish/functions/fish_right_prompt.fish.cosmic.bak ~/.config/fish/functions/fish_right_prompt.fish
    fi
    
    if [ -f ~/.config/fish/functions/fish_greeting.fish.cosmic.bak ]; then
        mv ~/.config/fish/functions/fish_greeting.fish.cosmic.bak ~/.config/fish/functions/fish_greeting.fish
    fi
    
    # If no backup exists, create a simple default prompt for fish
    if [ ! -f ~/.config/fish/functions/fish_prompt.fish ]; then
        echo -e "${YELLOW}Creating default Fish prompt...${NC}"
        echo 'function fish_prompt
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal
    echo -n " > "
end' > ~/.config/fish/functions/fish_prompt.fish
    fi
    
    # Clear Fish universal variables related to colors
    echo -e "${GREEN}Resetting Fish color variables...${NC}"
    # This needs to be run in a fish shell instance
    fish -c "
    set -U fish_color_normal normal
    set -U fish_color_command blue
    set -U fish_color_quote yellow
    set -U fish_color_redirection cyan
    set -U fish_color_end green
    set -U fish_color_error red
    set -U fish_color_param cyan
    set -U fish_color_comment red
    set -U fish_color_match --background=brblue
    set -U fish_color_selection white --bold --background=brblack
    set -U fish_color_search_match bryellow --background=brblack
    set -U fish_color_history_current --bold
    set -U fish_color_operator brcyan
    set -U fish_color_escape brcyan
    set -U fish_color_cwd green
    set -U fish_color_cwd_root red
    set -U fish_color_valid_path --underline
    set -U fish_color_autosuggestion 555
    set -U fish_color_user brgreen
    set -U fish_color_host normal
    set -U fish_color_cancel -r
    set -U fish_pager_color_prefix normal --bold --underline
    set -U fish_pager_color_completion normal
    set -U fish_pager_color_description B3A06D
    set -U fish_pager_color_progress brwhite --background=cyan
    set -U fish_pager_color_selected_background -r"
    
    echo -e "${GREEN}Fish shell configurations restored to defaults!${NC}"
fi

# Remove theme files and directories
echo -e "${GREEN}Removing theme files...${NC}"
rm -rf ~/.config/kitty/themes/nebula.conf
rm -rf ~/.config/kitty/themes/solar.conf
rm -rf ~/.config/kitty/themes/forest.conf
rm -rf ~/.config/kitty/themes/ocean.conf
rm -rf ~/.config/kitty/themes/midnight.conf
rm -rf ~/.config/kitty/themes/dark-neon.conf

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
    sed -i '/neofetch --config ~\/.config\/neofetch\/config.cosmic.conf/d' ~/.bashrc
    sed -i '/}/d' ~/.bashrc
    sed -i '/export -f cosmic-fetch/d' ~/.bashrc
fi

# Clean up empty directories
echo -e "${GREEN}Cleaning up empty directories...${NC}"
find ~/.config/fish/conf.d -type d -empty -delete 2>/dev/null
find ~/.config/fish/functions -type d -empty -delete 2>/dev/null

# Final message
echo -e "${GREEN}Uninstallation complete!${NC}"
echo -e "${BLUE}Your original configuration has been restored where possible.${NC}"
echo -e "${BLUE}Thank you for trying Cosmic Theme Pack!${NC}"
echo -e "${YELLOW}Please restart your terminal to apply all changes.${NC}"