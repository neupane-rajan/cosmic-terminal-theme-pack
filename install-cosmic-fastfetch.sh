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

# Function to check and install dependencies
check_dependency() {
    local cmd=$1
    local name=$2
    
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${YELLOW}$name is not installed.${NC}"
        read -p "Would you like to install $name? (y/n): " -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${GREEN}Installing $name...${NC}"
            if [ -f /etc/debian_version ]; then
                sudo apt-get update && sudo apt-get install -y "$cmd"
            elif [ -f /etc/fedora-release ]; then
                sudo dnf install -y "$cmd"
            elif [ -f /etc/arch-release ]; then
                sudo pacman -S --noconfirm "$cmd"
            elif [ -f /etc/redhat-release ]; then
                sudo dnf install -y "$cmd"
            elif command -v brew &> /dev/null; then
                brew install "$cmd"
            else
                echo -e "${RED}Could not automatically install $name. Please install it manually.${NC}"
            fi
        else
            echo -e "${BLUE}Skipping $name installation. Some features may not work.${NC}"
        fi
    else
        echo -e "${GREEN}$name is already installed.${NC}"
    fi
}

# Check for required tools
echo -e "${BLUE}Checking system dependencies...${NC}"

# Check for Git
check_dependency "git" "Git"

# Check for Curl
check_dependency "curl" "cURL"

# Check for Unzip
check_dependency "unzip" "Unzip"

# Check for Kitty
check_dependency "kitty" "Kitty Terminal"

# Check for Fastfetch (Special handling for PPA on Ubuntu)
if ! command -v fastfetch &> /dev/null; then
    echo -e "${YELLOW}Fastfetch is not installed.${NC}"
    read -p "Would you like to install Fastfetch? (y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}Installing Fastfetch...${NC}"
        if [ -f /etc/debian_version ]; then
            if ! grep -q "zhangjianguang/fastfetch" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
                sudo add-apt-repository -y ppa:zhangjianguang/fastfetch
            fi
            sudo apt-get update
            sudo apt-get install -y fastfetch
        elif [ -f /etc/fedora-release ]; then
            sudo dnf install -y fastfetch
        elif [ -f /etc/arch-release ]; then
            sudo pacman -S --noconfirm fastfetch
        elif [ -f /etc/redhat-release ]; then
            sudo dnf install -y fastfetch
        elif command -v brew &> /dev/null; then
            brew install fastfetch
        else
            echo -e "${RED}Could not automatically install Fastfetch.${NC}"
        fi
    else
        echo -e "${RED}Fastfetch is required for this theme pack.${NC}"
        exit 1
    fi
fi

# Create directory if it doesn't exist
mkdir -p ~/.config/fastfetch
mkdir -p ~/.config/fastfetch/logos

# Copy logo files
cp fastfetch/logos/*.txt ~/.config/fastfetch/logos/

# Check if kitty.conf exists, create if not
if [ ! -f ~/.config/kitty/kitty.conf ]; then
    echo -e "${YELLOW}kitty.conf not found. Creating default configuration...${NC}"
    mkdir -p ~/.config/kitty
    echo "# Cosmic Theme Pack" > ~/.config/kitty/kitty.conf
    echo "include themes/nebula.conf" >> ~/.config/kitty/kitty.conf
    # Copy themes if they aren't already there (should be done by main installer, but good to ensure)
    mkdir -p ~/.config/kitty/themes
    cp themes/kitty/*.conf ~/.config/kitty/themes/
    echo -e "${GREEN}Created ~/.config/kitty/kitty.conf with default Nebula theme${NC}"
fi

# Create the shell wrapper to handle themes
echo -e "${GREEN}Creating Cosmic Fastfetch logic...${NC}"

# We will create a wrapper script that determines the theme and runs fastfetch with overrides
# Instead of hardcoding everything in the config, we'll use --logo and --color flags

cat > ~/.config/fastfetch/run-cosmic.sh << 'EOF'
#!/bin/bash

# Get current theme from kitty config
get_theme() {
    if [ -f ~/.config/kitty/kitty.conf ]; then
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
            echo "nebula" # Default if config exists but no theme match
        fi
    else
        echo "nebula" # Default if config doesn't exist (fallback)
    fi
}

theme=$(get_theme)
config_file="$HOME/.config/fastfetch/config.jsonc"
logo_dir="$HOME/.config/fastfetch/logos"

# Define Colors based on theme
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

# Execute fastfetch with custom logo and colors
# We use --logo to point to the text file
fastfetch --config "$config_file" --color "$color" --logo-color "$logo_color" --logo "$logo_dir/${theme}.txt" --logo-type file

EOF

chmod +x ~/.config/fastfetch/run-cosmic.sh

# Copy the config file
cp fastfetch-config.jsonc ~/.config/fastfetch/config.jsonc

# Install shell function for cosmic-fetch
echo -e "${GREEN}Configuring shell integration...${NC}"



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
