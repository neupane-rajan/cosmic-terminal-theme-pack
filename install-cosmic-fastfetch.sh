#!/bin/bash
# Cosmic Fastfetch Installer - Refined Version

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}       Cosmic Fastfetch Installer${NC}"
echo -e "${BLUE}================================================${NC}"

# Check if source directories exist before starting
if [ ! -d "fastfetch" ] || [ ! -d "themes" ]; then
    echo -e "${RED}Error: Source folders 'fastfetch' or 'themes' not found in current directory.${NC}"
    echo "Please run this script from the root of the Cosmic Theme Pack folder."
    exit 1
fi

# Function to check and install dependencies
check_dependency() {
    local cmd=$1
    local name=$2
    
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${YELLOW}$name is not installed.${NC}"
        read -p "Would you like to install $name? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if [ -f /etc/debian_version ]; then
                sudo apt-get update && sudo apt-get install -y "$cmd"
            elif [ -f /etc/fedora-release ] || [ -f /etc/redhat-release ]; then
                sudo dnf install -y "$cmd"
            elif [ -f /etc/arch-release ]; then
                sudo pacman -S --noconfirm "$cmd"
            elif command -v brew &> /dev/null; then
                brew install "$cmd"
            fi
        fi
    else
        echo -e "${GREEN}$name is already installed.${NC}"
    fi
}

# 1. Install Dependencies
check_dependency "git" "Git"
check_dependency "curl" "cURL"
check_dependency "kitty" "Kitty Terminal"

# 2. Specialized Fastfetch Installation
if ! command -v fastfetch &> /dev/null; then
    echo -e "${YELLOW}Fastfetch not found.${NC}"
    read -p "Install Fastfetch now? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [ -f /etc/debian_version ]; then
            sudo apt-get update && sudo apt-get install -y software-properties-common
            sudo add-apt-repository -y ppa:zhangjianguang/fastfetch
            sudo apt-get update && sudo apt-get install -y fastfetch
        elif [ -f /etc/fedora-release ]; then sudo dnf install -y fastfetch
        elif [ -f /etc/arch-release ]; then sudo pacman -S --noconfirm fastfetch
        else echo -e "${RED}Manual installation of Fastfetch required.${NC}"; exit 1
        fi
    fi
fi

# 3. Setup Directories and Files
mkdir -p ~/.config/fastfetch/logos
mkdir -p ~/.config/kitty/themes

echo -e "${BLUE}Copying theme assets...${NC}"
cp fastfetch/logos/*.txt ~/.config/fastfetch/logos/ 2>/dev/null
cp themes/kitty/*.conf ~/.config/kitty/themes/ 2>/dev/null
cp fastfetch-config.jsonc ~/.config/fastfetch/config.jsonc 2>/dev/null

# 4. Create the Logic Wrapper
# Note the quoted 'EOF' to prevent local variable expansion
cat > ~/.config/fastfetch/run-cosmic.sh << 'EOF'
#!/bin/bash

get_theme() {
    local config="$HOME/.config/kitty/kitty.conf"
    if [ -f "$config" ]; then
        # Extracts theme name from the include line
        theme_name=$(grep "include themes/" "$config" | sed 's/.*themes\/\(.*\)\.conf/\1/')
        echo "${theme_name:-nebula}"
    else
        echo "nebula"
    fi
}

theme=$(get_theme)
logo_dir="$HOME/.config/fastfetch/logos"
config_file="$HOME/.config/fastfetch/config.jsonc"

# Fallback if specific logo file doesn't exist
if [ ! -f "$logo_dir/${theme}.txt" ]; then
    theme="nebula"
fi

case $theme in
    nebula)    color="blue" ;;
    solar)     color="yellow" ;;
    forest)    color="green" ;;
    ocean)     color="cyan" ;;
    midnight)  color="magenta" ;;
    dark-neon) color="red" ;;
    cyberpunk) color="magenta" ;;
    *)         color="blue" ;;
esac

fastfetch --config "$config_file" --color "$color" --logo-color "$color" --logo "$logo_dir/${theme}.txt" --logo-type file "$@"
EOF

chmod +x ~/.config/fastfetch/run-cosmic.sh

# 5. Shell Integration (Clean Append)
setup_shell() {
    local shell_rc=$1
    if [ -f "$shell_rc" ]; then
        if ! grep -q "cosmic-fetch" "$shell_rc"; then
            echo -e "\n# Cosmic Theme Pack\nalias cosmic-fetch='~/.config/fastfetch/run-cosmic.sh'" >> "$shell_rc"
            echo "alias cosmic-theme='~/.config/fastfetch/theme-switch.sh'" >> "$shell_rc"
            echo -e "${GREEN}Added aliases to $shell_rc${NC}"
        fi
    fi
}

setup_shell ~/.bashrc
setup_shell ~/.zshrc

# 6. Copy Switcher Script
if [ -f "theme-switch.sh" ]; then
    cp theme-switch.sh ~/.config/fastfetch/theme-switch.sh
    chmod +x ~/.config/fastfetch/theme-switch.sh
fi

echo -e "${GREEN}================================================${NC}"
echo -e "${GREEN}   Installation Complete! Restart your terminal.${NC}"
echo -e "${GREEN}   Usage: cosmic-fetch or cosmic-theme${NC}"
echo -e "${GREEN}================================================${NC}"