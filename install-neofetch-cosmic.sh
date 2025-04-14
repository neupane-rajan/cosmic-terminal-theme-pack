#!/bin/bash
# Cosmic Neofetch Installer
# This script installs custom neofetch configurations with ASCII art for Cosmic Themes

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}       Cosmic Neofetch Installer${NC}"
echo -e "${BLUE}================================================${NC}"

# Check if neofetch is installed
if ! command -v neofetch &> /dev/null; then
    echo -e "${YELLOW}Neofetch is not installed. Would you like to install it?${NC}"
    read -p "Install Neofetch? (y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}Attempting to install Neofetch...${NC}"
        
        # Detect OS and install Neofetch accordingly
        if [ -f /etc/debian_version ]; then
            # Debian/Ubuntu
            sudo apt-get update
            sudo apt-get install -y neofetch
        elif [ -f /etc/fedora-release ]; then
            # Fedora
            sudo dnf install -y neofetch
        elif [ -f /etc/arch-release ]; then
            # Arch Linux
            sudo pacman -S --noconfirm neofetch
        elif [ -f /etc/redhat-release ]; then
            # CentOS/RHEL
            sudo yum install -y epel-release
            sudo yum install -y neofetch
        elif command -v brew &> /dev/null; then
            # macOS with Homebrew
            brew install neofetch
        else
            echo -e "${RED}Could not automatically install Neofetch${NC}"
            echo -e "${YELLOW}Please install Neofetch manually and run this script again.${NC}"
            exit 1
        fi
        
        # Verify installation
        if ! command -v neofetch &> /dev/null; then
            echo -e "${RED}Neofetch installation failed.${NC}"
            exit 1
        else
            echo -e "${GREEN}Neofetch installed successfully!${NC}"
        fi
    else
        echo -e "${YELLOW}Exiting - Neofetch is required for this script.${NC}"
        exit 0
    fi
fi

# Create directory if it doesn't exist
mkdir -p ~/.config/neofetch

# Create the themed neofetch config with custom ASCII art
echo -e "${GREEN}Creating Cosmic Neofetch configuration...${NC}"
cat > ~/.config/neofetch/config.cosmic.conf << 'EOF'
# Cosmic themed neofetch configuration

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
    else
        echo "nebula" # Default
    fi
}

# Set colors based on current theme
theme=$(get_theme)

case $theme in
    nebula)
        # Nebula theme colors
        colors=(4 5 6 4 4 7)
        ascii_colors=(4 5 6 4 5 7)
        ;;
    solar)
        # Solar theme colors
        colors=(4 1 3 4 5 7)
        ascii_colors=(4 1 3 4 5 7)
        ;;
    forest)
        # Forest theme colors
        colors=(2 10 3 4 5 6)
        ascii_colors=(2 10 3 2 10 2)
        ;;
    ocean)
        # Ocean theme colors
        colors=(4 6 4 5 6 7)
        ascii_colors=(4 6 4 5 6 7)
        ;;
    midnight)
        # Midnight theme colors
        colors=(4 5 4 5 4 7)
        ascii_colors=(4 5 4 5 4 7)
        ;;
    dark-neon)
        # Dark Neon theme colors
        colors=(5 13 9 5 13 14)
        ascii_colors=(5 13 9 5 13 14)
        ;;
    *)
        # Default colors
        colors=()
        ascii_colors=()
        ;;
esac

# Custom ASCII art that changes with theme
get_ascii() {
    theme=$(get_theme)
    
    case $theme in
        nebula)
            # Nebula ASCII art
            cat << 'NEBULA'
              .  . '    .
         .  -   -  . ' .
       .  '             
     .  '     ,__  + .  
    .      . /   \    . 
   '     ,  /_ |  \_   '
  .      |/  \___/  \   
  .      |\___|___|_/  .
  .      |/ \|/   \|\ ' 
  .      |\__|_____|/  .
   '     |_/ |___\_.   '
    '    /           . 
     '   \        .     
      ' .|\.     '      
       './|\\  .'       
         '|\\.'
NEBULA
            ;;
        solar)
            # Solar ASCII art
            cat << 'SOLAR'
           ;   :   ;
       .   \_,!,_/   ,
        `.,'     `.,'
         /         \
    ~ -- :         : -- ~
         \         /
        ,':._   _.:';
       '   / `!` \   `
           ;     ;
SOLAR
            ;;
        forest)
            # Forest ASCII art
            cat << 'FOREST'
        _ _
      /|/ \ 
     / | \ \  
    /__|__\ \ 
   /__|____|_\
      /  \    
     / /\ \   
    /_/  \_\  
    /      \  
   / /|  |\ \ 
  /_/ |__| \_\
      |  |    
      |  |    
      |__|    
FOREST
            ;;
        ocean)
            # Ocean ASCII art
            cat << 'OCEAN'
      _.====.._
    ,:._       ~-_
        `\        ~-_
          |          ~-_
        ,-|             ~-_
       /  |                 ~-_
      |    \                   ~-_
      |     |                     ~-_
      |     |                        ~-_
     /      |                           ~-_
    |       |                              ~-_
    |       |                                 ~-_
    |       |                                    ~-_
    |       |                                       ~-_
    |       |                                          ~-.
OCEAN
            ;;
        midnight)
            # Midnight ASCII art
            cat << 'MIDNIGHT'
           *       *
        *      *      
    *  .    *   .   *  
     '. * .  * .'   
    *  '  * *  '  * 
     * .  * * .  * 
      |     |      
   .--+-----+--.   
  /  /|     |\  \  
 |  | |     | |  | 
 |  | |     | |  | 
 |  | |     | |  | 
 |  | |     | |  | 
 |  | |     | |  | 
 |__|_|     |_|__| 
MIDNIGHT
            ;;
        dark-neon)
            # Dark Neon ASCII art
            cat << 'DARKNEON'
       _____
     _/     \_
    / |     | \
   |  |     |  |
   |  |     |  |
    \  \___/  /
     \_______/
      |  |  |
  ____|__|__|____
 /    |  |  |    \
|     |__|__|     |
|_____|     |_____|
|     |     |     |
|_____|_____|_____|
DARKNEON
            ;;
        *)
            # Default ASCII art
            echo "           "
            ;;
    esac
}

# Neofetch configuration
print_info() {
    info title
    info underline
    
    info "OS" distro
    info "Host" model
    info "Kernel" kernel
    info "Uptime" uptime
    info "Packages" packages
    info "Shell" shell
    info "Terminal" term
    info "CPU" cpu
    info "Memory" memory
    
    info cols
}

# Output config
title_fqdn="off"
kernel_shorthand="on"
distro_shorthand="off"
os_arch="on"
uptime_shorthand="on"
memory_percent="on"
memory_unit="gib"
package_managers="on"
shell_path="off"
shell_version="on"
cpu_brand="on"
cpu_speed="on"
cpu_cores="logical"
cpu_temp="off"
gpu_brand="on"
gpu_type="all"
refresh_rate="off"
gtk_shorthand="off"
bold="on"
separator=" ➜"
block_range=(0 15)
color_blocks="on"
block_width=3
block_height=1
bar_char_elapsed="-"
bar_char_total="="
bar_border="on"
bar_length=15
bar_color_elapsed="distro"
bar_color_total="distro"
cpu_display="off"
memory_display="off"
battery_display="off"
disk_display="off"
image_backend="ascii"
image_source="auto"
ascii="$(get_ascii)"
ascii_distro="auto"
ascii_bold="on"
gap=3
EOF

# Install fish function if Fish shell is available
if command -v fish &> /dev/null; then
    echo -e "${GREEN}Creating Fish shell function for cosmic-fetch...${NC}"
    mkdir -p ~/.config/fish/functions
    
    cat > ~/.config/fish/functions/cosmic-fetch.fish << EOF
function cosmic-fetch
    neofetch --config ~/.config/neofetch/config.cosmic.conf \$argv
end
EOF

    # Make it executable
    chmod +x ~/.config/fish/functions/cosmic-fetch.fish
    
    echo -e "${GREEN}Fish function created successfully!${NC}"
    echo -e "${BLUE}Use 'cosmic-fetch' command in Fish to run themed neofetch.${NC}"
else
    echo -e "${YELLOW}Fish shell not detected. Creating bash function instead...${NC}"
    
    # Create bash function in .bashrc if it exists
    if [ -f ~/.bashrc ]; then
        if ! grep -q "function cosmic-fetch" ~/.bashrc; then
            echo -e "\n# Cosmic Theme Pack" >> ~/.bashrc
            echo "function cosmic-fetch() {" >> ~/.bashrc
            echo "    neofetch --config ~/.config/neofetch/config.cosmic.conf \$@" >> ~/.bashrc
            echo "}" >> ~/.bashrc
            echo "export -f cosmic-fetch" >> ~/.bashrc
            
            echo -e "${GREEN}Bash function added to .bashrc${NC}"
            echo -e "${BLUE}Use 'cosmic-fetch' command in Bash to run themed neofetch.${NC}"
        else
            echo -e "${BLUE}cosmic-fetch function already exists in .bashrc${NC}"
        fi
    else
        echo -e "${YELLOW}Cannot find .bashrc, creating alias in new file...${NC}"
        echo "function cosmic-fetch() {" > ~/.cosmic-fetch
        echo "    neofetch --config ~/.config/neofetch/config.cosmic.conf \$@" >> ~/.cosmic-fetch
        echo "}" >> ~/.cosmic-fetch
        echo "export -f cosmic-fetch" >> ~/.cosmic-fetch
        
        echo -e "${GREEN}Created ~/.cosmic-fetch${NC}"
        echo -e "${BLUE}Source it with: source ~/.cosmic-fetch${NC}"
    fi
fi

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${BLUE}Use 'cosmic-fetch' command to see your themed neofetch display.${NC}"