$None = [System.Drawing.Color]::Empty

[Flags()] enum Styles {
  Normal = 1
  Underline = 2
  Bold = 4
  Reversed = 8
  Strike = 16
}

$BorderTypes = @{
  "Normal"    = @{
    "Top"          = "─"
    "Bottom"       = "─"
    "Left"         = "│"
    "Right"        = "│"
    "TopLeft"      = "┌"
    "TopRight"     = "┐"
    "BottomLeft"   = "└"
    "BottomRight"  = "┘"
    "MiddleLeft"   = "├"
    "MiddleRight"  = "┤"
    "Middle"       = "┼"
    "MiddleTop"    = "┬"
    "MiddleBottom" = "┴"
  }
  "Rounded"   = @{
    "Top"          = "─"
    "Bottom"       = "─"
    "Left"         = "│"
    "Right"        = "│"
    "TopLeft"      = "╭"
    "TopRight"     = "╮"
    "BottomLeft"   = "╰"
    "BottomRight"  = "╯"
    "MiddleLeft"   = "├"
    "MiddleRight"  = "┤"
    "Middle"       = "┼"
    "MiddleTop"    = "┬"
    "MiddleBottom" = "┴"
  }
  "Block"     = @{
    "Top"          = "█"
    "Bottom"       = "█"
    "Left"         = "█"
    "Right"        = "█"
    "TopLeft"      = "█"
    "TopRight"     = "█"
    "BottomLeft"   = "█"
    "BottomRight"  = "█"
    "MiddleLeft"   = "█"
    "MiddleRight"  = "█"
    "Middle"       = "█"
    "MiddleTop"    = "█"
    "MiddleBottom" = "█"
  }
  "OuterHalf" = @{
    "Top"         = "▀"
    "Bottom"      = "▄"
    "Left"        = "▌"
    "Right"       = "▐"
    "TopLeft"     = "▛"
    "TopRight"    = "▜"
    "BottomLeft"  = "▙"
    "BottomRight" = "▟"
  }
  "InnerHalf" = @{
    "Top"         = "▄"
    "Bottom"      = "▀"
    "Left"        = "▐"
    "Right"       = "▌"
    "TopLeft"     = "▗"
    "TopRight"    = "▖"
    "BottomLeft"  = "▝"
    "BottomRight" = "▘"
  }
  "Thick"     = @{
    "Top"          = "━"
    "Bottom"       = "━"
    "Left"         = "┃"
    "Right"        = "┃"
    "TopLeft"      = "┏"
    "TopRight"     = "┓"
    "BottomLeft"   = "┗"
    "BottomRight"  = "┛"
    "MiddleLeft"   = "┣"
    "MiddleRight"  = "┫"
    "Middle"       = "╋"
    "MiddleTop"    = "┳"
    "MiddleBottom" = "┻"
  }
  "Double"    = @{
    "Top"          = "═"
    "Bottom"       = "═"
    "Left"         = "║"
    "Right"        = "║"
    "TopLeft"      = "╔"
    "TopRight"     = "╗"
    "BottomLeft"   = "╚"
    "BottomRight"  = "╝"
    "MiddleLeft"   = "╠"
    "MiddleRight"  = "╣"
    "Middle"       = "╬"
    "MiddleTop"    = "╦"
    "MiddleBottom" = "╩"
  }
  "Hidden"    = @{
    "Top"          = " "
    "Bottom"       = " "
    "Left"         = " "
    "Right"        = " "
    "TopLeft"      = " "
    "TopRight"     = " "
    "BottomLeft"   = " "
    "BottomRight"  = " "
    "MiddleLeft"   = " "
    "MiddleRight"  = " "
    "Middle"       = " "
    "MiddleTop"    = " "
    "MiddleBottom" = " "
  }
}


# $Theme = @{
#   "background"   = "#272935"
#   "black"        = "#272935"
#   "blue"         = "#BD93F9"
#   "brightBlack"  = "#555555"
#   "brightBlue"   = "#BD93F9"
#   "brightCyan"   = "#8BE9FD"
#   "brightGreen"  = "#50FA7B"
#   "brightPurple" = "#FF79C6"
#   "brightRed"    = "#FF5555"
#   "brightWhite"  = "#FFFFFF"
#   "brightYellow" = "#F1FA8C"
#   "cyan"         = "#6272A4"
#   "foreground"   = "#F8F8F2"
#   "green"        = "#50FA7B"
#   "purple"       = "#6272A4"
#   "red"          = "#FF5555"
#   "white"        = "#F8F8F2"
#   "yellow"       = "#FFB86C"
# }