
## fish/conf.d/theme-colors.fish
# Cosmic Theme Fish Colors (save as ~/.config/fish/conf.d/theme-colors.fish)

# Set Fish shell colors to match our terminal theme
# These will apply to syntax highlighting, completion, and other UI elements  
# in the Fish shell
# You can customize these colors to match your preferred theme
# The colors are defined in the format: set -U fish_color_<element> <color>
# Apply Nebula theme colors by default
# You can adjust these colors to match whichever theme you're using

set -U fish_color_normal normal
set -U fish_color_command '#26bbd9'
set -U fish_color_quote '#fab795'
set -U fish_color_redirection '#ee64ae'
set -U fish_color_end '#59e3e3'
set -U fish_color_error '#e95678'
set -U fish_color_param '#c7ccd1'
set -U fish_color_comment '#6c6f93'
set -U fish_color_match --background='#6c6f93'
set -U fish_color_selection 'white' --bold --background='#6c6f93'
set -U fish_color_search_match 'bryellow' --background='#6c6f93'
set -U fish_color_history_current --bold
set -U fish_color_operator '#59e3e3'
set -U fish_color_escape '#59e3e3'
set -U fish_color_cwd '#fab795'
set -U fish_color_cwd_root '#e95678'
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion '#6c6f93'
set -U fish_color_user '#29d398'
set -U fish_color_host '#26bbd9'
set -U fish_color_cancel -r
set -U fish_pager_color_prefix '#26bbd9' --bold
set -U fish_pager_color_completion normal
set -U fish_pager_color_description '#6c6f93'
set -U fish_pager_color_progress 'brwhite' '--background=#6c6f93'
set -U fish_pager_color_selected_background -r