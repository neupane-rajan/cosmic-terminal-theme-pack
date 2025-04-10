# install.sh

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}       Cosmic Theme Pack Installer${NC}"
echo -e "${BLUE}================================================${NC}"

# Create directories if they don't exist
echo -e "${GREEN}Creating directories...${NC}"
mkdir -p ~/.config/kitty/themes
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/fish/conf.d

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

# Install Fish prompt and configuration
echo -e "${GREEN}Installing Fish prompt and configuration...${NC}"
cp ./fish/functions/fish_prompt.fish ~/.config/fish/functions/
cp ./fish/functions/fish_right_prompt.fish ~/.config/fish/functions/
cp ./fish/conf.d/theme-colors.fish ~/.config/fish/conf.d/

# Notify user about font requirements
echo -e "${BLUE}Note: For best experience, install a Nerd Font from:${NC}"
echo -e "${BLUE}https://www.nerdfonts.com/font-downloads${NC}"

# Completion
echo -e "${GREEN}Installation complete!${NC}"
echo -e "${BLUE}To apply the theme:${NC}"
echo "  1. Restart Kitty terminal"
echo "  2. Start Fish shell with: fish"
echo -e "${BLUE}Enjoy your new Cosmic theme pack!${NC}"
