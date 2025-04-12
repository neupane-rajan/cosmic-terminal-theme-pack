## README.md
# Cosmic Terminal Theme Pack

A beautiful collection of terminal themes for Kitty terminal emulator and Fish shell, designed to enhance your Linux terminal experience.

![Cosmic Themes Preview](screenshots/cosmic-themes-preview.png)

## Features

- **5 Beautiful Themes** - Each with carefully crafted color palettes:
  - **Nebula** - Space-inspired dark theme with vibrant accents
  - **Solar** - Light theme with warm amber accents
  - **Forest** - Nature-inspired dark theme with soothing greens
  - **Ocean** - Blue/teal theme evoking deep ocean waters
  - **Midnight** - Deep dark theme for late-night coding sessions

- **Enhanced Fish Shell Prompt**
  - Username and hostname display
  - Current directory path
  - Git integration (branch, status, ahead/behind)
  - Command status indicator

- **Easy Installation and Switching**
  - One-command installation
  - Simple theme switching utility
  - Clean uninstallation option

## Screenshots

### Nebula Theme
![Nebula Theme](screenshots/nebula-theme.png)

### Solar Theme
![Solar Theme](screenshots/solar-theme.png)

### Forest Theme
![Forest Theme](screenshots/forest-theme.png)

## Requirements

- [Kitty Terminal Emulator](https://sw.kovidgoyal.net/kitty/)
- [Fish Shell](https://fishshell.com/)
- A [Nerd Font](https://www.nerdfonts.com/) (recommended for proper icons)

## Installation

1. Extract the downloaded zip file:
   ```bash
   unzip cosmic-terminal-theme-pack.zip
   cd cosmic-terminal-theme-pack
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

3. Restart your Kitty terminal and launch Fish shell:
   ```bash
   fish
   ```

## Switching Themes

Use the included theme switcher to change between themes:

```bash
./theme-switch.sh
```

Follow the prompts to select your desired theme.

## Customization

### Modifying Themes

You can customize any theme by editing the corresponding `.conf` file in `~/.config/kitty/themes/`.

### Adjusting Fish Prompt

Modify the Fish prompt by editing `~/.config/fish/functions/fish_prompt.fish`.

## Uninstallation

To remove all Cosmic Theme Pack components:

```bash
./uninstall.sh
```

## Credits

Created by [Your Name]

## License

[License Type] - See LICENSE file for details

## Support

If you enjoy this theme pack, please consider:
- Leaving a review
- Sharing with friends
- [Your support links/contact]