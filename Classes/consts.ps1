$script:esc = "$([char]27)"

$script:FD = "$($esc)[39m"
$script:BD = "$($esc)[49m"
$script:RS = "$($esc)[0m"
$script:foreground = "$($esc)[38;5;"
$script:background = "$($esc)[48;5;"

$script:tags = @{
    "0"   = @{
        set   = "$($esc)[0m"
        unset = "$($esc)[39m"
    }
    "1"   = @{
        set   = "$($esc)[1m"
        unset = "$($esc)[39m"
    }
    "2"   = @{
        set   = "$($esc)[2m"
        unset = "$($esc)[39m"
    }
    "3"   = @{
        set   = "$($esc)[3m"
        unset = "$($esc)[39m"
    }
    "4"   = @{
        set   = "$($esc)[4m"
        unset = "$($esc)[39m"
    }
    "5"   = @{
        set   = "$($esc)[5m"
        unset = "$($esc)[39m"
    }
    "6"   = @{
        set   = "$($esc)[6m"
        unset = "$($esc)[39m"
    }
    "7"   = @{
        set   = "$($esc)[7m"
        unset = "$($esc)[39m"
    }
    "8"   = @{
        set   = "$($esc)[8m"
        unset = "$($esc)[39m"
    }
    "9"   = @{
        set   = "$($esc)[9m"
        unset = "$($esc)[39m"
    }
    "10"  = @{
        set   = "$($esc)[10m"
        unset = "$($esc)[39m"
    }
    "11"  = @{
        set   = "$($esc)[11m"
        unset = "$($esc)[39m"
    }
    "12"  = @{
        set   = "$($esc)[12m"
        unset = "$($esc)[39m"
    }
    "13"  = @{
        set   = "$($esc)[13m"
        unset = "$($esc)[39m"
    }
    "14"  = @{
        set   = "$($esc)[14m"
        unset = "$($esc)[39m"
    }
    "15"  = @{
        set   = "$($esc)[15m"
        unset = "$($esc)[39m"
    }
}
