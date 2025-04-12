# Cosmic Fish Prompt

function fish_prompt
    set -l last_status $status
    set -g __fish_git_prompt_showdirtystate 'yes'
    set -g __fish_git_prompt_showuntrackedfiles 'yes'
    
    # Define cool symbols (requires Nerd Font)
    set -l symbol_prompt '⚡'
    set -l symbol_arrow ''
    set -l symbol_dir ''
    set -l symbol_git ''
    set -l symbol_git_dirty '✗'
    set -l symbol_git_clean '✓'
    set -l symbol_git_ahead '↑'
    set -l symbol_git_behind '↓'
    set -l symbol_user ''
    set -l symbol_host ''
    
    # Define colors
    set -l color_user '#29d398'
    set -l color_host '#26bbd9'
    set -l color_pwd '#fab795'
    set -l color_git '#ee64ae'
    set -l color_success '#29d398'
    set -l color_error '#e95678'
    set -l color_arrow '#59e3e3'
    
    # Display decorative line
    set_color $color_arrow
    echo -n "╭─"
    
    # Display username with cool icon
    set_color $color_user
    echo -n "$symbol_user "
    echo -n (whoami)
    
    # Display arrow separator
    set_color $color_arrow
    echo -n " $symbol_arrow "
    
    # Display hostname with cool icon
    set_color $color_host
    echo -n "$symbol_host "
    echo -n (hostname -s)
    
    # Display arrow separator
    set_color $color_arrow
    echo -n " $symbol_arrow "
    
    # Display current directory with cool icon
    set_color $color_pwd
    echo -n "$symbol_dir "
    echo -n (prompt_pwd)
    
    # Display git information if we're in a git repository
    if command -sq git && git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l git_branch (git branch --show-current 2>/dev/null)
        
        # Display arrow separator
        set_color $color_arrow
        echo -n " $symbol_arrow "
        
        # Display git branch with icon
        set_color $color_git
        echo -n "$symbol_git $git_branch "
        
        # Check for dirty state
        if git status --porcelain | grep -q '^.'
            set_color $color_error
            echo -n "$symbol_git_dirty"
        else
            set_color $color_success
            echo -n "$symbol_git_clean"
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
    
    # Add a new line and start the second line of the prompt
    echo
    set_color $color_arrow
    echo -n "╰─"
    
    # Display prompt symbol based on last command status
    if test $last_status -eq 0
        set_color $color_success
    else
        set_color $color_error
    end
    echo -n "$symbol_prompt "
    set_color normal
end