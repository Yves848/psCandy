# Define ANSI escape codes for terminal formatting
$script:esc = [char]27
$script:FG = "$($esc)[38;5;"     # Foreground
$script:BG = "$($esc)[48;5;"     # Background
$script:UL = "$($esc)[4m"        # Underline
$script:BD = "$($esc)[1m"        # Bold
$script:IT = "$($esc)[3m"        # Italic
$script:DF = "$($esc)[39m"       # Default Foreground
$script:DG = "$($esc)[49m"       # Default Background
$script:RS = "$($esc)[0m"        # Reset All
