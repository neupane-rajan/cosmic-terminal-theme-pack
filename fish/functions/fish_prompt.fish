## fish/functions/fish_prompt.fish
# Cosmic Fish Prompt (save as ~/.config/fish/functions/fish_prompt.fish)

function fish_prompt
    set -l last_status $status
    set -g __fish_git_prompt_showdirtystate 'yes'
    set -g __fish_git_prompt_showuntrackedfiles 'yes'
    
    # Define symbols
    set -l symbol_prompt '❯'
    set -l symbol_git_branch ''
    set -l symbol_git_dirty '*'
    set -l symbol_git_ahead '↑'
    set -l symbol_git_behind '↓'
    
    # Define colors
    set -l color_user '#29d398'
    set -l color_host '#26bbd9'
    set -l color_pwd '#fab795'
    set -l color_git '#ee64ae'
    set -l color_success '#29d398'
    set -l color_error '#e95678'
    
    # Display username and hostname
    set_color $color_user
    echo -n (whoami)
    set_color normal
    echo -n "@"
    set_color $color_host
    echo -n (hostname -s)
    set_color normal
    echo -n " "
    
    # Display current directory
    set_color $color_pwd
    echo -n (prompt_pwd)
    set_color normal
    
    # Display git information if we're in a git repository
    if command -sq git && git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l git_branch (git branch --show-current 2>/dev/null)
        set_color $color_git
        echo -n " $symbol_git_branch $git_branch"
        
        # Check for dirty state
        if git status --porcelain | grep -q '^.'
            set_color $color_error
            echo -n "$symbol_git_dirty"
        end
        
        # Check for ahead/behind state
        set -l git_status (git status -sb 2>/dev/null)
        if string match -q '*ahead*' $git_status
            set_color $color_success
            echo -n "$symbol_git_ahead"
        end
        if string match -q '*behind*' $git_status
            set_color $color_error
            echo -n "$symbol_git_behind"
        end
    end
    
    # Add a new line for the prompt
    echo
    
    # Display prompt symbol based on last command status
    if test $last_status -eq 0
        set_color $color_success
    else
        set_color $color_error
    end
    echo -n "$symbol_prompt "
    set_color normal
end
