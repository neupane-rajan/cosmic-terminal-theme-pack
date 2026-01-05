#!/bin/bash

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}       Cosmic Theme Pack Installer${NC}"
echo -e "${BLUE}================================================${NC}"



# Check for Nerd Fonts
echo -e "${BLUE}Checking for Nerd Fonts...${NC}"
found_nerd_font=false

# List of common Nerd Font names to check
nerd_fonts=("Hack Nerd Font" "FiraCode Nerd Font" "JetBrainsMono Nerd Font" "UbuntuMono Nerd Font")

for font in "${nerd_fonts[@]}"; do
    if fc-list | grep -i "$font" > /dev/null; then
        found_nerd_font=true
        echo -e "${GREEN}Found Nerd Font: $font${NC}"
        break
    fi
done

if [ "$found_nerd_font" = false ]; then
    echo -e "${YELLOW}No Nerd Font detected. For best appearance, we recommend installing a Nerd Font.${NC}"
    echo -e "${BLUE}Would you like to install a Nerd Font now?${NC}"
    read -p "Install Nerd Font? (y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Create temp directory for font installation
        mkdir -p ~/nerd-font-temp
        cd ~/nerd-font-temp
        
        echo -e "${GREEN}Downloading JetBrainsMono Nerd Font...${NC}"
        curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
        
        echo -e "${GREEN}Extracting font files...${NC}"
        unzip -q JetBrainsMono.zip -d ./JetBrainsMono
        
        # Create user font directory if it doesn't exist
        mkdir -p ~/.local/share/fonts
        
        echo -e "${GREEN}Installing fonts...${NC}"
        cp -f ./JetBrainsMono/*.ttf ~/.local/share/fonts/
        
        # Update font cache
        echo -e "${GREEN}Updating font cache...${NC}"
        fc-cache -f
        
        # Clean up
        cd ~
        rm -rf ~/nerd-font-temp
        
        echo -e "${GREEN}JetBrainsMono Nerd Font installed successfully!${NC}"
    else
        echo -e "${YELLOW}Continuing without Nerd Font...${NC}"
        echo -e "${BLUE}Note: Some prompt icons may not display correctly.${NC}"
    fi
fi

# Create directories if they don't exist
echo -e "${GREEN}Creating directories...${NC}"
mkdir -p ~/.config/kitty/themes
mkdir -p ~/.config/neofetch



# Install Kitty themes
echo -e "${GREEN}Installing Kitty themes...${NC}"
cp -v ./themes/kitty/*.conf ~/.config/kitty/themes/ || {
    echo -e "${RED}Failed to copy Kitty themes. Check path and permissions.${NC}"
    exit 1
}

# Check if include line exists in kitty.conf
if [ -f ~/.config/kitty/kitty.conf ]; then
    if ! grep -q "include themes/nebula.conf" ~/.config/kitty/kitty.conf; then
        echo -e "\n# Cosmic Theme Pack" >> ~/.config/kitty/kitty.conf
        echo "include themes/nebula.conf" >> ~/.config/kitty/kitty.conf
        echo -e "${GREEN}Added theme include to kitty.conf${NC}"
    else
        echo -e "${BLUE}Theme include already exists in kitty.conf${NC}"
    fi
else
    echo "# Cosmic Theme Pack" > ~/.config/kitty/kitty.conf
    echo "include themes/nebula.conf" >> ~/.config/kitty/kitty.conf
    echo -e "${GREEN}Created kitty.conf with theme include${NC}"
fi

# Add font configuration to kitty.conf
if [ "$found_nerd_font" = true ] || [[ $REPLY =~ ^[Yy]$ ]]; then
    if ! grep -q "font_family" ~/.config/kitty/kitty.conf; then
        echo -e "\n# Font configuration" >> ~/.config/kitty/kitty.conf
        echo "font_family JetBrainsMono Nerd Font" >> ~/.config/kitty/kitty.conf
        echo "bold_font auto" >> ~/.config/kitty/kitty.conf
        echo "italic_font auto" >> ~/.config/kitty/kitty.conf
        echo "bold_italic_font auto" >> ~/.config/kitty/kitty.conf
        echo "font_size 12.0" >> ~/.config/kitty/kitty.conf
        echo -e "${GREEN}Added font configuration to kitty.conf${NC}"
    fi
fi



# Check if neofetch installation is desired
echo -e "${BLUE}Would you like to install the themed neofetch configuration?${NC}"
read -p "Install themed neofetch? (y/n): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Starting neofetch installer...${NC}"
    
    # Check if install-neofetch-cosmic.sh exists and is executable
    if [ -f ./install-neofetch-cosmic.sh ] && [ -x ./install-neofetch-cosmic.sh ]; then
        # Run the neofetch installer
        ./install-neofetch-cosmic.sh
    else
        echo -e "${YELLOW}Neofetch installer script not found or not executable.${NC}"
        echo -e "${BLUE}You can run it later with: ./install-neofetch-cosmic.sh${NC}"
    fi
else
    echo -e "${BLUE}Skipping neofetch installation.${NC}"
fi

# Completion
echo -e "${GREEN}Installation complete!${NC}"
echo -e "${BLUE}To apply the theme:${NC}"
echo "  1. Restart Kitty terminal"



echo -e "${BLUE}Enjoy your new Cosmic theme pack!${NC}"

# Offer to set Fish as default shell if installed but not default