# Cosmic Theme Pack - Development Guide

This guide explains how to create new themes or modify existing ones for the Cosmic Terminal Theme Pack.

## Theme Structure

The Cosmic Terminal Theme Pack uses a structured approach to themes with two main components:

1. **Kitty Terminal Themes** - Control the colors of the terminal application
2. **Fish Shell Themes** - Control the colors and appearance of the shell prompt

## Creating a New Kitty Theme

Kitty themes are defined in `.conf` files located in `~/.config/kitty/themes/`.

### Basic Structure

Create a new file called `mytheme.conf` with the following structure:

```conf
# MyTheme for Kitty Terminal
# Part of the Cosmic Terminal Theme Pack

# Base colors
foreground           #c7ccd1  # Text color
background           #1c1e26  # Background color
selection_foreground #1c1e26  # Text color in selections
selection_background #c7ccd1  # Background color in selections

# Cursor colors
cursor            #c7ccd1  # Cursor color
cursor_text_color #1c1e26  # Text color under cursor

# URL underline color when hovering
url_color #5fb3b3  # Color for URL underlines

# Regular colors (Color0 through Color7)
color0  #1c1e26  # Black
color1  #e95678  # Red
color2  #29d398  # Green
color3  #fab795  # Yellow
color4  #26bbd9  # Blue
color5  #ee64ae  # Magenta
color6  #59e3e3  # Cyan
color7  #c7ccd1  # White

# Bright colors (Color8 through Color15)
color8  #6c6f93  # Bright Black
color9  #ec6a88  # Bright Red
color10 #3fdaa4  # Bright Green
color11 #fbc3a7  # Bright Yellow
color12 #3fc6de  # Bright Blue
color13 #f075b7  # Bright Magenta
color14 #6be6e6  # Bright Cyan
color15 #ffffff  # Bright White

# Tab bar
active_tab_foreground   #1c1e26  # Text on active tab
active_tab_background   #29d398  # Background on active tab
inactive_tab_foreground #c7ccd1  # Text on inactive tabs
inactive_tab_background #1c1e26  # Background on inactive tabs

# The tab bar style
tab_bar_style           powerline
tab_powerline_style     slanted
tab_bar_edge            bottom

# Window settings
window_padding_width    8
```

### Color Selection Tips

When creating a new theme, consider these tips for a cohesive color palette:

1. **Choose a base color** - Start with a primary color that defines the theme
2. **Create a cohesive palette** - Use color theory to select complementary colors
3. **Ensure proper contrast** - Maintain readable text with sufficient contrast
4. **Test in different lighting** - Check your theme in both bright and dark environments

### Color Meaning in Terminal Applications

Understanding the conventional use of colors:

- **color0/color8** (Black) - Background elements, sometimes used for UI
- **color1/color9** (Red) - Errors, warnings, destructive actions
- **color2/color10** (Green) - Success messages, confirmations
- **color3/color11** (Yellow) - Warnings, highlights, special information
- **color4/color12** (Blue) - Information, links, primary actions
- **color5/color13** (Magenta) - Special text, variables in programming
- **color6/color14** (Cyan) - Secondary information, alternate highlighting
- **color7/color15** (White) - Regular text, UI elements

## Modifying Fish Shell Colors

Fish colors are defined in `~/.config/fish/conf.d/theme-colors.fish`.

### Basic Structure

```fish
# Set Fish shell colors to match our terminal theme
set -U fish_color_normal normal
set -U fish_color_command '#26bbd9'  # Color for commands
set -U fish_color_quote '#fab795'    # Color for quoted text
set -U fish_color_redirection '#ee64ae'  # Color for redirections (> >>)
set -U fish_color_end '#59e3e3'      # Color for end tokens
set -U fish_color_error '#e95678'    # Color for errors
set -U fish_color_param '#c7ccd1'    # Color for parameters
set -U fish_color_comment '#6c6f93'  # Color for comments
# ... additional color settings
```

### Key Fish Color Variables

These are the most important color variables to modify:

- **fish_color_command** - Color for valid commands
- **fish_color_error** - Color for error messages and invalid commands
- **fish_color_param** - Color for command parameters
- **fish_color_quote** - Color for quoted strings
- **fish_color_comment** - Color for comments
- **fish_color_cwd** - Color for current working directory
- **fish_color_user** - Color for username
- **fish_color_host** - Color for hostname

## Customizing the Fish Prompt

The prompt appearance is defined in `~/.config/fish/functions/fish_prompt.fish`.

### Key Elements to Customize

```fish
function fish_prompt
    # Define symbols - change these to customize prompt appearance
    set -l symbol_prompt '❯'
    set -l symbol_git_branch ''
    set -l symbol_git_dirty '*'
    
    # Define colors - match these to your theme
    set -l color_user '#29d398'
    set -l color_host '#26bbd9'
    set -l color_pwd '#fab795'
    set -l color_git '#ee64ae'
    set -l color_success '#29d398'
    set -l color_error '#e95678'
    
    # ... prompt display logic
end
```

### Customization Tips

1. **Icons** - Replace the symbols with any character, including Nerd Font icons
2. **Colors** - Match colors to your Kitty theme for consistency
3. **Layout** - Modify the echo statements to change prompt structure
4. **Information** - Add or remove information elements as needed

## Testing Your Theme

To test your new theme:

1. Save your Kitty theme file in `~/.config/kitty/themes/`
2. Update your Fish color settings to match
3. Switch to your theme with:
   ```bash
   sed -i '/include themes\/.*\.conf/d' ~/.config/kitty/kitty.conf
   echo "include themes/mytheme.conf" >> ~/.config/kitty/kitty.conf
   ```
4. Restart Kitty terminal or reload with Ctrl+Shift+F5

## Adding Your Theme to the Theme Pack

To make your theme selectable via the theme switcher:

1. Add your theme to `theme-switch.sh` by editing the script:
   ```bash
   # Add to the available themes list
   echo "6) MyTheme (Your theme description)"
   
   # Add to the case statement
   case $theme_number in
       # ... existing cases
       6)
           theme_file="mytheme.conf"
           theme_name="MyTheme"
           ;;
       *)
   ```

2. Update the `cosmic_functions.fish` file to include your theme:
   ```fish
   function theme
       switch $argv[1]
           # ... existing cases
           case mytheme
               sed -i '/include themes\/.*\.conf/d' ~/.config/kitty/kitty.conf
               echo "include themes/mytheme.conf" >> ~/.config/kitty/kitty.conf
               echo "Theme switched to MyTheme! Restart Kitty to apply."
           case '*'
               echo "Usage: theme [nebula|solar|forest|ocean|midnight|mytheme]"
       end
   end
   ```

## Color Tools and Resources

These tools can help you create harmonious color palettes:

- [Coolors](https://coolors.co/) - Color scheme generator
- [Adobe Color](https://color.adobe.com/) - Create color themes
- [Paletton](https://paletton.com/) - Color palette designer
- [Color Hunt](https://colorhunt.co/) - Curated color palettes
- [Terminal.sexy](https://terminal.sexy/) - Terminal color scheme designer

## Best Practices

1. **Maintain Contrast** - Ensure text remains readable
2. **Be Consistent** - Use similar hues for related functions
3. **Consider Color Blindness** - Test with color blindness simulators
4. **Document Your Theme** - Include a description and color rationale
5. **Test Extensively** - Check with different terminal content

## Contributing Your Theme

If you'd like to contribute your theme to the main project:

1. Fork the repository
2. Add your theme files
3. Test thoroughly
4. Submit a pull request with:
   - Theme files
   - Screenshots
   - Brief description

Happy theme creating!
