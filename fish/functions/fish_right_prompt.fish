
## fish/functions/fish_right_prompt.fish
# Cosmic Fish Right Prompt (save as ~/.config/fish/functions/fish_right_prompt.fish)

function fish_right_prompt
    # Define colors
    set -l color_time '#6c6f93'
    set -l color_duration '#fab795'
    
    # Command execution time if last command took more than 5 seconds
    set -l cmd_duration $CMD_DURATION
    if test $cmd_duration -gt 5000
        set_color $color_duration
        
        # Format duration
        if test $cmd_duration -gt 60000
            # Minutes and seconds
            echo -n (math -s0 $cmd_duration / 60000)"m"(math -s0 $cmd_duration % 60000 / 1000)"s "
        else
            # Just seconds
            echo -n (math -s1 $cmd_duration / 1000)"s "
        end
    end
    
    # Current time
    set_color $color_time
    echo -n (date "+%H:%M:%S")
    set_color normal
end
