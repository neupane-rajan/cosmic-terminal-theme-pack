# Cosmic Terminal Theme Pack

A beautiful collection of terminal themes for Kitty terminal emulator and Fish shell, designed to enhance your Linux terminal experience with modern aesthetics and powerful functionality.

![Cosmic Themes Preview](screenshots/cosmic-themes-preview.png)

## Features

### Beautiful Themes

Each theme features a carefully crafted color palette to create a cohesive visual experience:

- **Nebula** - Space-inspired dark theme with vibrant accent colors and high contrast
- **Solar** - Light theme with warm amber accents for comfortable daytime usage
- **Forest** - Nature-inspired dark theme with soothing green tones
- **Ocean** - Deep blue/teal theme evoking tranquil ocean depths
- **Midnight** - Deep dark theme with rich purples for late-night coding sessions

### Enhanced Shell Experience

- **Two-line Fish Prompt**
  - Stylish two-line prompt with decorative frames
  - Git branch and status integration with visual indicators
  - Command execution status with color coding
  - Nerd Font icons for visual enhancement

- **Informative Right Prompt**
  - Command execution time display
  - Current time indicator
  - Auto-scaling time format (seconds/minutes/hours)

- **Utility Functions**
  - `theme` - Quick theme switching from the command line
  - `sysinfo` - Beautifully formatted system information display
  - `ll` - Enhanced directory listing with decorative elements
  - `gstat` - Comprehensive git repository status view

### Simple Management

- One-command installation with automatic dependency detection
- Interactive Nerd Font installation
- Simple theme switching via command or utility script
- Clean uninstallation option that preserves your original configuration

## Screenshots

### Nebula Theme
![Nebula Theme](screenshots/nebula-theme.png)

### Solar Theme
![Solar Theme](screenshots/solar-theme.png)

### Forest Theme
![Forest Theme](screenshots/forest-theme.png)

## Requirements

- [Kitty Terminal Emulator](https://sw.kovidgoyal.net/kitty/) - A fast, feature-rich GPU-based terminal
- [Fish Shell](https://fishshell.com/) - A smart and user-friendly command line shell
- A [Nerd Font](https://www.nerdfonts.com/) - Required for prompt icons (automatically installed if desired)

## Installation

### Quick Install

1. Clone or download the repository:
   ```bash
   git clone https://github.com/yourusername/cosmic-terminal-theme-pack.git
   # or unzip the downloaded zip file
   unzip cosmic-terminal-theme-pack.zip
   ```

2. Navigate to the project directory:
   ```bash
   cd cosmic-terminal-theme-pack
   ```

3. Make the installation script executable and run it:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

4. Follow the on-screen prompts to complete installation.

5. Restart your terminal or run:
   ```bash
   fish
   ```

### Manual Installation

If you prefer to install components individually:

1. Copy theme files:
   ```bash
   mkdir -p ~/.config/kitty/themes
   cp themes/kitty/*.conf ~/.config/kitty/themes/
   ```

2. Add the theme to your Kitty configuration:
   ```bash
   echo "include themes/nebula.conf" >> ~/.config/kitty/kitty.conf
   ```

3. Install Fish prompt files:
   ```bash
   mkdir -p ~/.config/fish/functions ~/.config/fish/conf.d
   cp fish/functions/*.fish ~/.config/fish/functions/
   cp fish/conf.d/*.fish ~/.config/fish/conf.d/
   ```

## Usage

### Switching Themes

#### Using the Theme Script

Run the theme switcher utility:
```bash
./theme-switch.sh
```

Follow the interactive prompts to select your desired theme.

#### Using the Fish Function

If you're using Fish shell, simply type:
```bash
theme nebula    # Switch to Nebula theme
theme solar     # Switch to Solar theme
theme forest    # Switch to Forest theme
theme ocean     # Switch to Ocean theme
theme midnight  # Switch to Midnight theme
```

### Utility Functions

The Cosmic Theme Pack includes several useful utility functions for Fish shell:

- **System Information**:
  ```bash
  sysinfo
  ```
  Displays formatted system information including OS, hostname, uptime, and hardware details.

- **Enhanced Directory Listing**:
  ```bash
  ll
  ```
  Provides a visually enhanced version of the standard `ls -la` command.

- **Git Status**:
  ```bash
  gstat
  ```
  Shows comprehensive git repository information including branch, commit, changes, and sync status.

## Customization

### Modifying Theme Colors

You can customize any theme by editing the corresponding `.conf` file in `~/.config/kitty/themes/`:

```bash
nano ~/.config/kitty/themes/nebula.conf
```

Changes will take effect when you restart Kitty or reload the configuration with `ctrl+shift+F5`.

### Adjusting the Fish Prompt

Modify the Fish prompt appearance by editing:

```bash
nano ~/.config/fish/functions/fish_prompt.fish
```

You can change colors, symbols, and layout to match your preferences.

### Adding Custom Functions

Create your own Fish functions to extend the theme pack:

```bash
nano ~/.config/fish/functions/my_function.fish
```

## Uninstallation

To remove the Cosmic Theme Pack:

```bash
./uninstall.sh
```

This will remove all theme files but preserve your original configurations.

## Troubleshooting

### Missing Icons

If prompt icons appear as boxes or question marks:
- Ensure you have a Nerd Font installed and configured in Kitty
- Run the installer again and select "Yes" when asked to install Nerd Fonts

### Theme Not Applying

If the theme doesn't change after switching:
- Restart Kitty terminal completely
- Check your kitty.conf file to ensure the theme include line exists
- Verify that theme files are present in ~/.config/kitty/themes/

## Contributing

Contributions are welcome! If you'd like to add features, fix bugs, or improve documentation:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## Credits

Created by Rajan with love for the terminal community.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you enjoy this theme pack, consider:
- Starring the repository on GitHub
- Sharing with friends and colleagues
- Reporting any issues you encounter
- Contributing improvements or additional themes

For questions or support:
- Email: rajanneupane202@gmail.com
- GitHub Issues: [Report an issue](https://github.com/yourusername/cosmic-terminal-theme-pack/issues)
