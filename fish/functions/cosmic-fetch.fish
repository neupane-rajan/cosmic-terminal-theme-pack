# Cosmic Fetch - A standalone system info display for Cosmic Theme Pack

function cosmic-fetch
    # Get current theme from kitty config
    function get_theme
        if test -f ~/.config/kitty/kitty.conf
            if grep -q "include themes/nebula.conf" ~/.config/kitty/kitty.conf
                echo "nebula"
            else if grep -q "include themes/solar.conf" ~/.config/kitty/kitty.conf
                echo "solar"
            else if grep -q "include themes/forest.conf" ~/.config/kitty/kitty.conf
                echo "forest"
            else if grep -q "include themes/ocean.conf" ~/.config/kitty/kitty.conf
                echo "ocean"
            else if grep -q "include themes/midnight.conf" ~/.config/kitty/kitty.conf
                echo "midnight"
            else if grep -q "include themes/dark-neon.conf" ~/.config/kitty/kitty.conf
                echo "dark-neon"
            else
                echo "nebula" # Default
            end
        else
            echo "nebula" # Default
        end
    end

    # Get ASCII art based on theme
    function get_ascii
        set theme (get_theme)
        
        switch $theme
            case "nebula"
                set_color '#26bbd9'
                echo '              .  . '\'    '\'.'
                echo '         .  -   -  . '\'' .'
                echo '       .  '\''             '
                echo '     .  '\''     ,__  + .  '
                echo '    .      . /   \    . '
                echo '   '\''     ,  /_ |  \_   '\'''
                echo '  .      |/  \___/  \   '
                echo '  .      |\___|___|_/  .'
                echo '  .      |/ \|/   \|\ '\'' '
                echo '  .      |\__|_____|/  .'
                echo '   '\''     |_/ |___\_.   '\'''
                echo '    '\''    /           . '
                echo '     '\''   \        .     '
                echo '      '\'' .|\     '\''      '
                echo '       '\'./|\\  .'\''       '
                echo '         '\''|\\.'\'
                
            case "solar"
                set_color '#4078f2'
                echo '           ;   :   ;'
                echo '       .   \_,!,_/   ,'
                echo '        `.,'\''     `.,'\'''
                echo '         /         \'
                echo '    ~ -- :         : -- ~'
                echo '         \         /'
                echo '        ,'\'':._   _.:'\'';'
                echo '       '\''   / `!` \   `'
                echo '           ;     ;'
                
            case "forest"
                set_color '#a7c080'
                echo '        _ _'
                echo '      /|/ \ '
                echo '     / | \ \  '
                echo '    /__|__\ \ '
                echo '   /__|____|_\'
                echo '      /  \    '
                echo '     / /\ \   '
                echo '    /_/  \_\  '
                echo '    /      \  '
                echo '   / /|  |\ \ '
                echo '  /_/ |__| \_\'
                echo '      |  |    '
                echo '      |  |    '
                echo '      |__|    '
                
            case "ocean"
                set_color '#7aa2f7'
                echo '      _.====.._'
                echo '    ,:._       ~-_'
                echo '        `\        ~-_'
                echo '          |          ~-_'
                echo '        ,-|             ~-_'
                echo '       /  |                 ~-_'
                echo '      |    \                   ~-_'
                echo '      |     |                     ~-_'
                echo '      |     |                        ~-_'
                echo '     /      |                           ~-_'
                echo '    |       |                              ~-_'
                echo '    |       |                                 ~-_'
                echo '    |       |                                    ~-_'
                echo '    |       |                                       ~-_'
                echo '    |       |                                          ~-.'
                
            case "midnight"
                set_color '#4d83ff'
                echo '           *       *'
                echo '        *      *      '
                echo '    *  .    *   .   *  '
                echo '     '\'. * .  * .'\''   '
                echo '    *  '\''  * *  '\''  * '
                echo '     * .  * * .  * '
                echo '      |     |      '
                echo '   .--+-----+--.   '
                echo '  /  /|     |\  \  '
                echo ' |  | |     | |  | '
                echo ' |  | |     | |  | '
                echo ' |  | |     | |  | '
                echo ' |  | |     | |  | '
                echo ' |  | |     | |  | '
                echo ' |__|_|     |_|__| '
                
            case "dark-neon"
                set_color '#ff79c6'
                echo '       _____'
                echo '     _/     \_'
                echo '    / |     | \'
                echo '   |  |     |  |'
                echo '   |  |     |  |'
                echo '    \  \___/  /'
                echo '     \_______/'
                echo '      |  |  |'
                echo '  ____|__|__|____'
                echo ' /    |  |  |    \'
                echo '|     |__|__|     |'
                echo '|_____|     |_____|'
                echo '|     |     |     |'
                echo '|_____|_____|_____|'
        end
        
        set_color normal
    end

    # Get system information
    function get_os
        if type -q lsb_release
            lsb_release -d | cut -f2
        else if test -f /etc/os-release
            cat /etc/os-release | grep "PRETTY_NAME" | cut -d '"' -f 2
        else
            echo (uname -s) (uname -r)
        end
    end

    function get_host
        hostname
    end

    function get_kernel
        uname -r
    end

    function get_uptime
        if type -q uptime
            uptime | sed 's/.*up \([^,]*\).*/\1/'
        else
            echo "Unknown"
        end
    end

    function get_packages
        set package_count 0
        
        # Count apt packages
        if type -q apt
            set apt_count (apt list --installed 2>/dev/null | wc -l)
            set package_count (math $package_count + $apt_count - 1)
        end
        
        # Count dnf packages
        if type -q dnf
            set dnf_count (dnf list installed 2>/dev/null | wc -l)
            set package_count (math $package_count + $dnf_count - 1)
        end
        
        # Count pacman packages
        if type -q pacman
            set pacman_count (pacman -Q 2>/dev/null | wc -l)
            set package_count (math $package_count + $pacman_count)
        end
        
        # Count brew packages
        if type -q brew
            set brew_count (brew list --formula 2>/dev/null | wc -l)
            set package_count (math $package_count + $brew_count)
        end
        
        if test $package_count -eq 0
            echo "Unknown"
        else
            echo $package_count
        end
    end

    function get_shell
        basename $SHELL
    end

    function get_term
        if test -n "$TERM_PROGRAM"
            echo $TERM_PROGRAM
        else
            echo $TERM
        end
    end

    function get_cpu
        if test -f /proc/cpuinfo
            grep "model name" /proc/cpuinfo | head -1 | cut -d ':' -f2 | xargs
        else if type -q sysctl; and sysctl -n machdep.cpu.brand_string >/dev/null 2>&1
            sysctl -n machdep.cpu.brand_string
        else
            echo "Unknown CPU"
        end
    end

    function get_memory
        if type -q free
            set total (free -h | grep Mem | awk '{print $2}')
            set used (free -h | grep Mem | awk '{print $3}')
            echo "$used / $total"
        else if type -q vm_stat; and type -q sysctl
            # For macOS
            set total (math (sysctl -n hw.memsize) / 1024 / 1024 / 1024)
            echo "Unknown / $total""GB"
        else
            echo "Unknown"
        end
    end

    # Determine colors based on theme
    set theme (get_theme)
    
    switch $theme
        case "nebula"
            set title_color '#29d398'
            set text_color '#26bbd9'
            set accent_color '#ee64ae'
        case "solar"
            set title_color '#c18401'
            set text_color '#4078f2'
            set accent_color '#a626a4'
        case "forest" 
            set title_color '#a7c080'
            set text_color '#83c092'
            set accent_color '#d699b6'
        case "ocean"
            set title_color '#7aa2f7'
            set text_color '#7dcfff'
            set accent_color '#bb9af7'
        case "midnight"
            set title_color '#4d83ff'
            set text_color '#5cccef'
            set accent_color '#c74ded'
        case "dark-neon"
            set title_color '#50fa7b'
            set text_color '#8be9fd'
            set accent_color '#ff79c6'
        case '*'
            set title_color '#29d398'
            set text_color '#26bbd9'
            set accent_color '#ee64ae'
    end

    # Display system information
    
    # Left side: ASCII art
    set ascii_lines (get_ascii | wc -l)
    set info_lines 10 # Approximate lines for system info
    
    set padding_lines (math max 0, $ascii_lines - $info_lines)
    set ascii_art (get_ascii)
    
    # Right side: System information
    set_color $title_color
    set username (whoami)
    set hostname (hostname)
    set userhost "$username@$hostname"
    
    set sep_line (string repeat -n (string length "$userhost") "─")
    
    echo # Start with blank line
    
    # Print header
    set_color $title_color
    echo -n "        $userhost"
    echo
    set_color $accent_color
    echo "        $sep_line"
    
    # Print information
    set_color $text_color
    echo "        OS: "(get_os)
    echo "        Kernel: "(get_kernel)
    echo "        Uptime: "(get_uptime)
    echo "        Packages: "(get_packages)
    echo "        Shell: "(get_shell)
    echo "        Terminal: "(get_term)
    echo "        CPU: "(get_cpu)
    echo "        Memory: "(get_memory)
    
    set_color $accent_color
    echo "        $sep_line"
    
    echo # End with blank line
    
    set_color normal
end