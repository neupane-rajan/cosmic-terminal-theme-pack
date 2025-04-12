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

# Check if Fish shell is installed
if ! command -v fish &> /dev/null; then
    echo -e "${YELLOW}Fish shell is not installed on your system.${NC}"
    echo -e "${BLUE}Fish shell is recommended for the full Cosmic Theme experience.${NC}"
    echo -e "${BLUE}Would you like to install Fish shell?${NC}"
    read -p "Install Fish shell? (y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}Attempting to install Fish shell...${NC}"
        
        # Detect OS and install Fish accordingly
        if [ -f /etc/debian_version ]; then
            # Debian/Ubuntu
            echo -e "${BLUE}Detected Debian/Ubuntu system${NC}"
            sudo apt-get update
            sudo apt-get install -y fish
        elif [ -f /etc/fedora-release ]; then
            # Fedora
            echo -e "${BLUE}Detected Fedora system${NC}"
            sudo dnf install -y fish
        elif [ -f /etc/arch-release ]; then
            # Arch Linux
            echo -e "${BLUE}Detected Arch Linux system${NC}"
            sudo pacman -S --noconfirm fish
        elif [ -f /etc/redhat-release ]; then
            # CentOS/RHEL
            echo -e "${BLUE}Detected CentOS/RHEL system${NC}"
            sudo yum install -y fish
        elif command -v brew &> /dev/null; then
            # macOS with Homebrew
            echo -e "${BLUE}Detected macOS with Homebrew${NC}"
            brew install fish
        else
            echo -e "${RED}Could not automatically install Fish shell${NC}"
            echo -e "${YELLOW}Please install Fish shell manually:${NC}"
            echo -e "${BLUE}Visit: https://fishshell.com/docs/current/index.html#installation${NC}"
            echo -e "${BLUE}After installing Fish, run this script again.${NC}"
            exit 1
        fi
        
        # Verify installation
        if ! command -v fish &> /dev/null; then
            echo -e "${RED}Fish shell installation failed.${NC}"
            echo -e "${YELLOW}Please install Fish shell manually:${NC}"
            echo -e "${BLUE}Visit: https://fishshell.com/docs/current/index.html#installation${NC}"
            echo -e "${BLUE}After installing Fish, run this script again.${NC}"
            exit 1
        else
            echo -e "${GREEN}Fish shell installed successfully!${NC}"
        fi
    else
        echo -e "${YELLOW}Continuing without Fish shell...${NC}"
        echo -e "${BLUE}Note: Some features will be limited to Kitty terminal only.${NC}"
    fi
fi

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

# For Fish shell features, create directories if Fish is installed
if command -v fish &> /dev/null; then
    mkdir -p ~/.config/fish/functions
    mkdir -p ~/.config/fish/conf.d
fi

# Install Kitty themes
echo -e "${GREEN}Installing Kitty themes...${NC}"
cp ./themes/kitty/*.conf ~/.config/kitty/themes/

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

# Install Fish prompt and configuration if Fish is installed
if command -v fish &> /dev/null; then
    echo -e "${GREEN}Installing Fish prompt and configuration...${NC}"
    cp ./fish/functions/fish_prompt.fish ~/.config/fish/functions/
    cp ./fish/functions/fish_right_prompt.fish ~/.config/fish/functions/
    cp ./fish/conf.d/theme-colors.fish ~/.config/fish/conf.d/
    cp ./fish/functions/cosmic_functions.fish ~/.config/fish/functions/
    
    # Update Fish greeting
    cat > ~/.config/fish/functions/fish_greeting.fish << EOF
function fish_greeting
    set_color '#29d398'
    echo "╭───── Welcome to Cosmic Terminal ─────╮"
    set_color '#26bbd9'
    echo "  Type 'theme' to change themes"
    echo "  Type 'sysinfo' to see system info"
    echo "  Type 'gstat' to see git status"
    set_color '#29d398'
    echo "╰─────────────────────────────────────╯"
    set_color normal
end
EOF
    
    echo -e "${GREEN}Fish prompt and functions installed!${NC}"
else
    echo -e "${YELLOW}Skipping Fish shell configuration (Fish not installed)${NC}"
fi

# Completion
echo -e "${GREEN}Installation complete!${NC}"
echo -e "${BLUE}To apply the theme:${NC}"
echo "  1. Restart Kitty terminal"

if command -v fish &> /dev/null; then
    echo "  2. Start Fish shell with: fish"
else
    echo "  2. Consider installing Fish shell for enhanced experience"
    echo "     Visit: https://fishshell.com/docs/current/index.html#installation"
fi

echo -e "${BLUE}Enjoy your new Cosmic theme pack!${NC}"

# Offer to set Fish as default shell if installed but not default
if command -v fish &> /dev/null && [ "$SHELL" != "$(which fish)" ]; then
    echo
    echo -e "${BLUE}Would you like to set Fish as your default shell?${NC}"
    read -p "Set Fish as default shell? (y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Get Fish shell path
        FISH_PATH=$(which fish)
        
        # Check if Fish is in /etc/shells
        if ! grep -q "$FISH_PATH" /etc/shells; then
            echo -e "${YELLOW}Adding Fish to /etc/shells...${NC}"
            echo "$FISH_PATH" | sudo tee -a /etc/shells > /dev/null
        fi
        
        # Change default shell
        echo -e "${GREEN}Changing default shell to Fish...${NC}"
        chsh -s "$FISH_PATH"
        
        echo -e "${GREEN}Fish is now your default shell!${NC}"
        echo -e "${BLUE}Please log out and log back in for changes to take effect.${NC}"
    else
        echo -e "${BLUE}You can manually switch to Fish shell by typing 'fish' in your terminal.${NC}"
    fi
fi