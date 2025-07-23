$script:esc = "$([char]27)"

$script:FD = "$($esc)[39m"
$script:BD = "$($esc)[49m"
$script:RS = "$($esc)[0m"

$script:Colors = @{
    Black   = "$($esc)[30m"
    Red     = "$($esc)[31m"
    Green   = "$($esc)[32m"
    Yellow  = "$($esc)[33m"
    Blue    = "$($esc)[34m"
    Magenta = "$($esc)[35m"
    Cyan    = "$($esc)[36m"
    White   = "$($esc)[37m"
}