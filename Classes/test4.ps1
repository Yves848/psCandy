$esc = [char]27
$blue = "$($esc)[38;5;21m"
$reset = "$($esc)[0m"
$italic = "$($esc)[3m"
$underline = "$($esc)[4m"
$resetItalic = "$($esc)[23m"
$resetUnderline = "$($esc)[24m"
$yellowonred = "$($esc)[38;5;1;48;5;0m"
$defaultfg = "$($esc)[39m"
$defaultbg = "$($esc)[49m"

$text = "This is a test of $blue blue text$defaultfg and $italic italic text, with $underline underlined text$resetItalic $yellowonred yellow on red text$defaultbg$resetUnderline default text$reset"

write-host $text