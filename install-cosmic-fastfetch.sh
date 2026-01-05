#!/bin/bash
# Cosmic Fastfetch Installer
# This script installs custom fastfetch configurations with ASCII art for Cosmic Themes

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}       Cosmic Fastfetch Installer${NC}"
echo -e "${BLUE}================================================${NC}"

# Check if fastfetch is installed
if ! command -v fastfetch &> /dev/null; then
    echo -e "${YELLOW}Fastfetch is not installed. Would you like to install it?${NC}"
    read -p "Install Fastfetch? (y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}Attempting to install Fastfetch...${NC}"
        
        # Detect OS and install Fastfetch accordingly
        if [ -f /etc/debian_version ]; then
            # Debian/Ubuntu (requires adding PPA or downloading deb, depending on version)
            # This is a basic attempt
            sudo add-apt-repository -y ppa:zhangjianguang/fastfetch
            sudo apt-get update
            sudo apt-get install -y fastfetch
        elif [ -f /etc/fedora-release ]; then
            # Fedora
            sudo dnf install -y fastfetch
        elif [ -f /etc/arch-release ]; then
            # Arch Linux
            sudo pacman -S --noconfirm fastfetch
        elif [ -f /etc/redhat-release ]; then
            # CentOS/RHEL
            sudo dnf install -y fastfetch
        elif command -v brew &> /dev/null; then
            # macOS with Homebrew
            brew install fastfetch
        else
            echo -e "${RED}Could not automatically install Fastfetch${NC}"
            echo -e "${YELLOW}Please install Fastfetch manually and run this script again.${NC}"
            exit 1
        fi
        
        # Verify installation
        if ! command -v fastfetch &> /dev/null; then
            echo -e "${RED}Fastfetch installation failed.${NC}"
            exit 1
        else
            echo -e "${GREEN}Fastfetch installed successfully!${NC}"
        fi
    else
        echo -e "${YELLOW}Exiting - Fastfetch is required for this script.${NC}"
        exit 0
    fi
fi

# Create directory if it doesn't exist
mkdir -p ~/.config/fastfetch

# Create the shell wrapper to handle themes
echo -e "${GREEN}Creating Cosmic Fastfetch logic...${NC}"

# We will create a wrapper script that determines the theme and runs fastfetch with overrides
# Instead of hardcoding everything in the config, we'll use --logo and --color flags

cat > ~/.config/fastfetch/run-cosmic.sh << 'EOF'
#!/bin/bash

# Get current theme from kitty config
get_theme() {
    if grep -q "include themes/nebula.conf" ~/.config/kitty/kitty.conf; then
        echo "nebula"
    elif grep -q "include themes/solar.conf" ~/.config/kitty/kitty.conf; then
        echo "solar"
    elif grep -q "include themes/forest.conf" ~/.config/kitty/kitty.conf; then
        echo "forest"
    elif grep -q "include themes/ocean.conf" ~/.config/kitty/kitty.conf; then
        echo "ocean"
    elif grep -q "include themes/midnight.conf" ~/.config/kitty/kitty.conf; then
        echo "midnight"
    elif grep -q "include themes/dark-neon.conf" ~/.config/kitty/kitty.conf; then
        echo "dark-neon"
    elif grep -q "include themes/cyberpunk.conf" ~/.config/kitty/kitty.conf; then
        echo "cyberpunk"
    else
        echo "nebula" # Default
    fi
}

theme=$(get_theme)
config_file="$HOME/.config/fastfetch/config.jsonc"

# Define ASCII art and Colors based on theme
case $theme in
    nebula)
        color="blue"
        logo_color="blue"
        ;;
    solar)
        color="yellow"
        logo_color="yellow"
        ;;
    forest)
        color="green"
        logo_color="green"
        ;;
    ocean)
        color="cyan"
        logo_color="cyan"
        ;;
    midnight)
        color="magenta"
        logo_color="magenta"
        ;;
    dark-neon)
        color="red"
        logo_color="red"
        ;;
    cyberpunk)
        color="magenta"
        logo_color="magenta"
        ;;
    *)
        color="blue"
        logo_color="blue"
        ;;
esac

# Execute fastfetch with overrides
# Note: We are running simple fastfetch command here. 
# For advanced ASCII art similar to the neofetch script, we'd need to create text files or print raw.
# Fastfetch supports printing raw text files as logos.

fastfetch --config "$config_file" --color "$color" --logo-color "$logo_color"

EOF

chmod +x ~/.config/fastfetch/run-cosmic.sh

# Copy the config file
cp fastfetch-config.jsonc ~/.config/fastfetch/config.jsonc

# Install shell function for cosmic-fetch
echo -e "${GREEN}Configuring shell integration...${NC}"

# Fish Shell
if command -v fish &> /dev/null; then
    mkdir -p ~/.config/fish/functions
    cat > ~/.config/fish/functions/cosmic-fetch.fish << EOF
function cosmic-fetch
    ~/.config/fastfetch/run-cosmic.sh \$argv
end
EOF
    chmod +x ~/.config/fish/functions/cosmic-fetch.fish
    echo -e "${GREEN}Fish function updated!${NC}"
fi

# Bash Shell
if [ -f ~/.bashrc ]; then
    if ! grep -q "function cosmic-fetch" ~/.bashrc; then
        echo -e "\n# Cosmic Theme Pack" >> ~/.bashrc
        echo "function cosmic-fetch() {" >> ~/.bashrc
        echo "    ~/.config/fastfetch/run-cosmic.sh \$@" >> ~/.bashrc
        echo "}" >> ~/.bashrc
        echo "export -f cosmic-fetch" >> ~/.bashrc
        echo -e "${GREEN}Bash function added to .bashrc${NC}"
    else
        echo -e "${BLUE}cosmic-fetch function already exists in .bashrc.${NC}"
    fi
else
    # Create ~/.cosmic-fetch if not exists or update it (Bash fallback)
    echo "function cosmic-fetch() {" > ~/.cosmic-fetch
    echo "    ~/.config/fastfetch/run-cosmic.sh \$@" >> ~/.cosmic-fetch
    echo "}" >> ~/.cosmic-fetch
    echo "export -f cosmic-fetch" >> ~/.cosmic-fetch
    echo -e "${GREEN}Created ~/.cosmic-fetch for manual sourcing${NC}"
fi

# Zsh Shell
if [ -f ~/.zshrc ]; then
    if ! grep -q "function cosmic-fetch" ~/.zshrc; then
        echo -e "\n# Cosmic Theme Pack" >> ~/.zshrc
        echo "cosmic-fetch() {" >> ~/.zshrc
        echo "    ~/.config/fastfetch/run-cosmic.sh \"\$@\"" >> ~/.zshrc
        echo "}" >> ~/.zshrc
        echo -e "${GREEN}Zsh function added to .zshrc${NC}"
    else
        echo -e "${BLUE}cosmic-fetch function already exists in .zshrc.${NC}"
    fi
elif command -v zsh &> /dev/null; then
    # If zsh is installed but no .zshrc found (unlikely for active users, but possible)
    touch ~/.zshrc
    echo -e "\n# Cosmic Theme Pack" >> ~/.zshrc
    echo "cosmic-fetch() {" >> ~/.zshrc
    echo "    ~/.config/fastfetch/run-cosmic.sh \"\$@\"" >> ~/.zshrc
    echo "}" >> ~/.zshrc
    echo -e "${GREEN}Created .zshrc and added function${NC}"
fi


echo -e "${GREEN}Installation complete!${NC}"
echo -e "${BLUE}Use 'cosmic-fetch' to run the new fastfetch implementation.${NC}"
