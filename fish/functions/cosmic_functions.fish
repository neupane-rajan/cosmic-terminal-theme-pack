# Cosmic Theme Functions

# Function to toggle between themes quickly
function theme
    switch $argv[1]
        case nebula
            sed -i '/include themes\/.*\.conf/d' ~/.config/kitty/kitty.conf
            echo "include themes/nebula.conf" >> ~/.config/kitty/kitty.conf
            echo "Theme switched to Nebula! Restart Kitty to apply."
        case solar
            sed -i '/include themes\/.*\.conf/d' ~/.config/kitty/kitty.conf
            echo "include themes/solar.conf" >> ~/.config/kitty/kitty.conf
            echo "Theme switched to Solar! Restart Kitty to apply."
        case forest
            sed -i '/include themes\/.*\.conf/d' ~/.config/kitty/kitty.conf
            echo "include themes/forest.conf" >> ~/.config/kitty/kitty.conf
            echo "Theme switched to Forest! Restart Kitty to apply."
        case ocean
            sed -i '/include themes\/.*\.conf/d' ~/.config/kitty/kitty.conf
            echo "include themes/ocean.conf" >> ~/.config/kitty/kitty.conf
            echo "Theme switched to Ocean! Restart Kitty to apply."
        case midnight
            sed -i '/include themes\/.*\.conf/d' ~/.config/kitty/kitty.conf
            echo "include themes/midnight.conf" >> ~/.config/kitty/kitty.conf
            echo "Theme switched to Midnight! Restart Kitty to apply."
        case dark-neon
            sed -i '/include themes\/.*\.conf/d' ~/.config/kitty/kitty.conf
            echo "include themes/dark-neon.conf" >> ~/.config/kitty/kitty.conf
            echo "Theme switched to Dark Neon! Restart Kitty to apply."
        case '*'
            echo "Usage: theme [nebula|solar|forest|ocean|midnight|dark-neon]"
    end
end

# Function to show system info with cool formatting
function sysinfo
    set_color '#29d398'
    echo "╭───── System Information ─────╮"
    set_color '#26bbd9'
    echo "  OS: "(uname -s)" "(uname -r)
    echo "  Host: "(hostname)
    echo "  Uptime: "(uptime | cut -d ',' -f1 | cut -d ' ' -f4,5)
    
    # Check for memory info
    if type -q free
        set mem (free -h | grep Mem | awk '{print $3 " / " $2}')
        echo "  Memory: $mem"
    end
    
    # Check for CPU info
    if test -f /proc/cpuinfo
        set cpu (grep "model name" /proc/cpuinfo | head -1 | cut -d ':' -f2 | xargs)
        echo "  CPU: $cpu"
    end
    
    set_color '#29d398'
    echo "╰────────────────────────────╯"
    set_color normal
end

# Function to create a pretty directory listing
function ll
    set_color '#fab795'
    echo "╭───── Directory Listing ─────╮"
    set_color normal
    
    # Run ls with colors and formatting
    ls -lah --color=always $argv | awk 'NR>1'
    
    set_color '#fab795'
    echo "╰────────────────────────────╯"
    set_color normal
end

# Function to show git status with nice formatting
function gstat
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "Not a git repository"
        return 1
    end
    
    set_color '#ee64ae'
    echo "╭───── Git Status ─────╮"
    set_color '#29d398'
    echo "  Branch: "(git branch --show-current)
    echo "  Commit: "(git rev-parse --short HEAD)" - "(git log -1 --pretty=%B | head -1)
    
    # Check for changes
    set_color '#fab795'
    set changes (git status --porcelain | wc -l)
    if test $changes -gt 0
        echo "  Changes: $changes file(s) modified"
    else
        echo "  Changes: Working tree clean"
    end
    
    # Check for upstream status
    if git rev-parse --abbrev-ref @{upstream} >/dev/null 2>&1
        set ahead (git rev-list --count @{upstream}..HEAD)
        set behind (git rev-list --count HEAD..@{upstream})
        
        if test $ahead -gt 0 -a $behind -gt 0
            set_color '#e95678'
            echo "  Sync: $ahead ahead, $behind behind"
        else if test $ahead -gt 0
            set_color '#29d398'
            echo "  Sync: $ahead commit(s) ahead"
        else if test $behind -gt 0
            set_color '#e95678'
            echo "  Sync: $behind commit(s) behind"
        else
            set_color '#29d398'
            echo "  Sync: Up-to-date with remote"
        end
    else
        set_color '#6c6f93'
        echo "  Sync: No upstream branch"
    end
    
    set_color '#ee64ae'
    echo "╰────────────────────╯"
    set_color normal
end