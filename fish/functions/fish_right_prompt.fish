# Cosmic Fish Right Prompt

function fish_right_prompt
    # Define colors
    set -l color_time '#6c6f93'
    set -l color_duration '#fab795'
    
    # Define symbols
    set -l symbol_time ''
    set -l symbol_duration ''
    
    # Command execution time if last command took more than 3 seconds
    set -l cmd_duration $CMD_DURATION
    if test $cmd_duration -gt 3000
        set_color $color_duration
        echo -n "$symbol_duration "
        
        # Format duration
        if test $cmd_duration -gt 3600000
            # Hours, minutes and seconds
            echo -n (math -s0 $cmd_duration / 3600000)"h"(math -s0 $cmd_duration % 3600000 / 60000)"m"(math -s0 $cmd_duration % 60000 / 1000)"s "
        else if test $cmd_duration -gt 60000
            # Minutes and seconds
            echo -n (math -s0 $cmd_duration / 60000)"m"(math -s0 $cmd_duration % 60000 / 1000)"s "
        else
            # Just seconds
            echo -n (math -s1 $cmd_duration / 1000)"s "
        end
    end
    
    # Current time with nice icon
    set_color $color_time
    echo -n "$symbol_time "
    echo -n (date "+%H:%M:%S")
    set_color normal
end