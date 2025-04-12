# Cosmic Terminal Theme Pack - Installation Guide

This document provides detailed instructions for installing and configuring the Cosmic Terminal Theme Pack on different systems.

## Prerequisites

Before installing, ensure you have:

- **Kitty Terminal Emulator**: A GPU-based terminal emulator
- **Fish Shell**: A user-friendly command line shell (optional but recommended)
- **Git**: For cloning the repository (optional)
- **Nerd Font**: For proper display of prompt icons (can be installed during setup)

## System Requirements

- **Operating Systems**: Linux (all major distributions), macOS
- **Disk Space**: Approximately 5MB
- **Dependencies**: curl, unzip (for Nerd Font installation)

## Installation Methods

### Automatic Installation (Recommended)

The included installation script will handle all setup tasks, including:
- Detecting and installing dependencies
- Creating required directories
- Installing theme files
- Configuring Kitty and Fish shell
- Installing Nerd Fonts if needed

To use the automatic installer:

1. Open a terminal window
2. Navigate to the unpacked theme directory:
   ```bash
   cd path/to/cosmic-terminal-theme-pack
   ```
3. Make the script executable:
   ```bash
   chmod +x install.sh
   ```
4. Run the installation script:
   ```bash
   ./install.sh
   ```
5. Follow the on-screen prompts

The installer will guide you through any necessary decisions and display progress information.

### Manual Installation

If you prefer to install components individually:

#### 1. Install Kitty Terminal (if not already installed)

**Debian/Ubuntu**:
```bash
sudo apt update
sudo apt install kitty
```

**Fedora**:
```bash
sudo dnf install kitty
```

**Arch Linux**:
```bash
sudo pacman -S kitty
```

**macOS (with Homebrew)**:
```bash
brew install --cask kitty
```

#### 2. Install Fish Shell (if not already installed)

**Debian/Ubuntu**:
```bash
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish
```

**Fedora**:
```bash
sudo dnf install fish
```

**Arch Linux**:
```bash
sudo pacman -S fish
```

**macOS (with Homebrew)**:
```bash
brew install fish
```

#### 3. Install a Nerd Font

**Download JetBrainsMono Nerd Font**:
```bash
mkdir -p ~/nerd-font-temp
cd ~/nerd-font-temp
curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip -q JetBrainsMono.zip -d ./JetBrainsMono
mkdir -p ~/.local/share/fonts
cp -f ./JetBrainsMono/*.ttf ~/.local/share/fonts/
fc-cache -f
cd ~
rm -rf ~/nerd-font-temp
```

#### 4. Install Cosmic Theme Files

**Create directories**:
```bash
mkdir -p ~/.config/kitty/themes
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/fish/conf.d
```

**Copy theme files**:
```bash
cp ./themes/kitty/*.conf ~/.config/kitty/themes/
```

**Configure Kitty**:
```bash
echo "# Cosmic Theme Pack" >> ~/.config/kitty/kitty.conf
echo "include themes/nebula.conf" >> ~/.config/kitty/kitty.conf
echo "font_family JetBrainsMono Nerd Font" >> ~/.config/kitty/kitty.conf
echo "font_size 12.0" >> ~/.config/kitty/kitty.conf
```

**Install Fish configuration**:
```bash
cp ./fish/functions/fish_prompt.fish ~/.config/fish/functions/
cp ./fish/functions/fish_right_prompt.fish ~/.config/fish/functions/
cp ./fish/conf.d/theme-colors.fish ~/.config/fish/conf.d/
cp ./fish/functions/cosmic_functions.fish ~/.config/fish/functions/
```

## Post-Installation

After installation, you should:

1. Restart your terminal application
2. Launch Fish shell if it's not your default:
   ```bash
   fish
   ```
3. Try the built-in commands:
   ```bash
   theme nebula    # Try the Nebula theme
   sysinfo         # Display system information
   ll              # Enhanced directory listing
   ```

## Setting Fish as Default Shell

To make Fish your default shell:

```bash
chsh -s $(which fish)
```

You will need to log out and back in for this change to take effect.

## Troubleshooting

### Icons Not Displaying Correctly

If prompt icons appear as boxes or question marks:

1. Verify Nerd Font installation:
   ```bash
   fc-list | grep "Nerd"
   ```

2. Ensure Kitty is configured to use a Nerd Font:
   ```bash
   grep "font_family" ~/.config/kitty/kitty.conf
   ```

3. Try reinstalling the Nerd Font:
   ```bash
   curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
   # (follow extraction steps as above)
   ```

### Theme Not Applying

If the theme doesn't change after switching:

1. Check your Kitty configuration:
   ```bash
   cat ~/.config/kitty/kitty.conf
   ```

2. Verify theme files exist:
   ```bash
   ls -la ~/.config/kitty/themes/
   ```

3. Manually reload Kitty configuration:
   - Press Ctrl+Shift+F5 in Kitty
   - Or restart Kitty completely

### Fish Functions Not Working

If the Fish functions are not working:

1. Check if functions are installed:
   ```bash
   ls -la ~/.config/fish/functions/
   ```

2. Reload Fish configuration:
   ```bash
   source ~/.config/fish/config.fish
   ```

## Uninstallation

To completely remove the Cosmic Theme Pack:

```bash
./uninstall.sh
```

For manual uninstallation:

```bash
rm -f ~/.config/kitty/themes/nebula.conf
rm -f ~/.config/kitty/themes/solar.conf
rm -f ~/.config/kitty/themes/forest.conf
rm -f ~/.config/kitty/themes/ocean.conf
rm -f ~/.config/kitty/themes/midnight.conf
rm -f ~/.config/fish/functions/fish_prompt.fish
rm -f ~/.config/fish/functions/fish_right_prompt.fish
rm -f ~/.config/fish/conf.d/theme-colors.fish
rm -f ~/.config/fish/functions/cosmic_functions.fish
```

Then remove theme include lines from `~/.config/kitty/kitty.conf`.
