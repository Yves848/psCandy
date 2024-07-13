[Flags()] enum Styles {
  Normal = 1
  Underline = 2
  Bold = 4
  Reversed = 8
  Strike = 16
}

enum Align {
  Left
  Center
  Right
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

class candyColor {
  [int]$r
  [int]$g
  [int]$b
}

class Colors {
  static [candyColor] AliceBlue () {
    return @{R = 240
      G        = 248
      B        = 255
    }
  }
  static [candyColor] AntiqueWhite () {
    return @{R = 250
      G        = 235
      B        = 215
    }
  }
  static [candyColor] Aqua () {
    return @{R = 0
      G        = 255
      B        = 255
    }
  }
  static [candyColor] Aquamarine () {
    return @{R = 127
      G        = 255
      B        = 212
    }
  }
  static [candyColor] Azure () {
    return @{R = 240
      G        = 255
      B        = 255
    }
  }
  static [candyColor] Beige () {
    return @{R = 245
      G        = 245
      B        = 220
    }
  }
  static [candyColor] Bisque () {
    return @{R = 255
      G        = 228
      B        = 196
    }
  }
  static [candyColor] Black () {
    return @{R = 0
      G        = 0
      B        = 0
    }
  }
  static [candyColor] BlanchedAlmond () {
    return @{R = 255
      G        = 235
      B        = 205
    }
  }
  static [candyColor] Blue () {
    return @{R = 0
      G        = 0
      B        = 255
    }
  }
  static [candyColor] BlueViolet () {
    return @{R = 138
      G        = 43
      B        = 226
    }
  }
  static [candyColor] Brown () {
    return @{R = 165
      G        = 42
      B        = 42
    }
  }
  static [candyColor] BurlyWood () {
    return @{R = 222
      G        = 184
      B        = 135
    }
  }
  static [candyColor] CadetBlue () {
    return @{R = 95
      G        = 158
      B        = 160
    }
  }
  static [candyColor] Chartreuse () {
    return @{R = 127
      G        = 255
      B        = 0
    }
  }
  static [candyColor] Chocolate () {
    return @{R = 210
      G        = 105
      B        = 30
    }
  }
  static [candyColor] Coral () {
    return @{R = 255
      G        = 127
      B        = 80
    }
  }
  static [candyColor] CornflowerBlue () {
    return @{R = 100
      G        = 149
      B        = 237
    }
  }
  static [candyColor] Cornsilk () {
    return @{R = 255
      G        = 248
      B        = 220
    }
  }
  static [candyColor] Crimson () {
    return @{R = 220
      G        = 20
      B        = 60
    }
  }
  static [candyColor] Cyan () {
    return @{R = 0
      G        = 255
      B        = 255
    }
  }
  static [candyColor] DarkBlue () {
    return @{R = 0
      G        = 0
      B        = 139
    }
  }
  static [candyColor] DarkCyan () {
    return @{R = 0
      G        = 139
      B        = 139
    }
  }
  static [candyColor] DarkGoldenrod () {
    return @{R = 184
      G        = 134
      B        = 11
    }
  }
  static [candyColor] DarkGray () {
    return @{R = 169
      G        = 169
      B        = 169
    }
  }
  static [candyColor] DarkGreen () {
    return @{R = 0
      G        = 100
      B        = 0
    }
  }
  static [candyColor] DarkKhaki () {
    return @{R = 189
      G        = 183
      B        = 107
    }
  }
  static [candyColor] DarkMagenta () {
    return @{R = 139
      G        = 0
      B        = 139
    }
  }
  static [candyColor] DarkOliveGreen () {
    return @{R = 85
      G        = 107
      B        = 47
    }
  }
  static [candyColor] DarkOrange () {
    return @{R = 255
      G        = 140
      B        = 0
    }
  }
  static [candyColor] DarkOrchid () {
    return @{R = 153
      G        = 50
      B        = 204
    }
  }
  static [candyColor] DarkRed () {
    return @{R = 139
      G        = 0
      B        = 0
    }
  }
  static [candyColor] DarkSalmon () {
    return @{R = 233
      G        = 150
      B        = 122
    }
  }
  static [candyColor] DarkSeaGreen () {
    return @{R = 143
      G        = 188
      B        = 143
    }
  }
  static [candyColor] DarkSlateBlue () {
    return @{R = 72
      G        = 61
      B        = 139
    }
  }
  static [candyColor] DarkSlateGray () {
    return @{R = 47
      G        = 79
      B        = 79
    }
  }
  static [candyColor] DarkTurquoise () {
    return @{R = 0
      G        = 206
      B        = 209
    }
  }
  static [candyColor] DarkViolet () {
    return @{R = 148
      G        = 0
      B        = 211
    }
  }
  static [candyColor] DeepPink () {
    return @{R = 255
      G        = 20
      B        = 147
    }
  }
  static [candyColor] DeepSkyBlue () {
    return @{R = 0
      G        = 191
      B        = 255
    }
  }
  static [candyColor] DimGray () {
    return @{R = 105
      G        = 105
      B        = 105
    }
  }
  static [candyColor] DodgerBlue () {
    return @{R = 30
      G        = 144
      B        = 255
    }
  }
  static [candyColor] Empty () {
    return @{R = 0
      G        = 0
      B        = 0
    }
  }
  static [candyColor] Firebrick () {
    return @{R = 178
      G        = 34
      B        = 34
    }
  }
  static [candyColor] FloralWhite () {
    return @{R = 255
      G        = 250
      B        = 240
    }
  }
  static [candyColor] ForestGreen () {
    return @{R = 34
      G        = 139
      B        = 34
    }
  }
  static [candyColor] Fuchsia () {
    return @{R = 255
      G        = 0
      B        = 255
    }
  }
  static [candyColor] Gainsboro () {
    return @{R = 220
      G        = 220
      B        = 220
    }
  }
  static [candyColor] GhostWhite () {
    return @{R = 248
      G        = 248
      B        = 255
    }
  }
  static [candyColor] Gold () {
    return @{R = 255
      G        = 215
      B        = 0
    }
  }
  static [candyColor] Goldenrod () {
    return @{R = 218
      G        = 165
      B        = 32
    }
  }
  static [candyColor] Gray () {
    return @{R = 128
      G        = 128
      B        = 128
    }
  }
  static [candyColor] Green () {
    return @{R = 0
      G        = 128
      B        = 0
    }
  }
  static [candyColor] GreenYellow () {
    return @{R = 173
      G        = 255
      B        = 47
    }
  }
  static [candyColor] Honeydew () {
    return @{R = 240
      G        = 255
      B        = 240
    }
  }
  static [candyColor] HotPink () {
    return @{R = 255
      G        = 105
      B        = 180
    }
  }
  static [candyColor] IndianRed () {
    return @{R = 205
      G        = 92
      B        = 92
    }
  }
  static [candyColor] Indigo () {
    return @{R = 75
      G        = 0
      B        = 130
    }
  }
  static [candyColor] Ivory () {
    return @{R = 255
      G        = 255
      B        = 240
    }
  }
  static [candyColor] Khaki () {
    return @{R = 240
      G        = 230
      B        = 140
    }
  }
  static [candyColor] Lavender () {
    return @{R = 230
      G        = 230
      B        = 250
    }
  }
  static [candyColor] LavenderBlush () {
    return @{R = 255
      G        = 240
      B        = 245
    }
  }
  static [candyColor] LawnGreen () {
    return @{R = 124
      G        = 252
      B        = 0
    }
  }
  static [candyColor] LemonChiffon () {
    return @{R = 255
      G        = 250
      B        = 205
    }
  }
  static [candyColor] LightBlue () {
    return @{R = 173
      G        = 216
      B        = 230
    }
  }
  static [candyColor] LightCoral () {
    return @{R = 240
      G        = 128
      B        = 128
    }
  }
  static [candyColor] LightCyan () {
    return @{R = 224
      G        = 255
      B        = 255
    }
  }
  static [candyColor] LightGoldenrodYellow () {
    return @{R = 250
      G        = 250
      B        = 210
    }
  }
  static [candyColor] LightGray () {
    return @{R = 211
      G        = 211
      B        = 211
    }
  }
  static [candyColor] LightGreen () {
    return @{R = 144
      G        = 238
      B        = 144
    }
  }
  static [candyColor] LightPink () {
    return @{R = 255
      G        = 182
      B        = 193
    }
  }
  static [candyColor] LightSalmon () {
    return @{R = 255
      G        = 160
      B        = 122
    }
  }
  static [candyColor] LightSeaGreen () {
    return @{R = 32
      G        = 178
      B        = 170
    }
  }
  static [candyColor] LightSkyBlue () {
    return @{R = 135
      G        = 206
      B        = 250
    }
  }
  static [candyColor] LightSlateGray () {
    return @{R = 119
      G        = 136
      B        = 153
    }
  }
  static [candyColor] LightSteelBlue () {
    return @{R = 176
      G        = 196
      B        = 222
    }
  }
  static [candyColor] LightYellow () {
    return @{R = 255
      G        = 255
      B        = 224
    }
  }
  static [candyColor] Lime () {
    return @{R = 0
      G        = 255
      B        = 0
    }
  }
  static [candyColor] LimeGreen () {
    return @{R = 50
      G        = 205
      B        = 50
    }
  }
  static [candyColor] Linen () {
    return @{R = 250
      G        = 240
      B        = 230
    }
  }
  static [candyColor] Magenta () {
    return @{R = 255
      G        = 0
      B        = 255
    }
  }
  static [candyColor] Maroon () {
    return @{R = 128
      G        = 0
      B        = 0
    }
  }
  static [candyColor] MediumAquamarine () {
    return @{R = 102
      G        = 205
      B        = 170
    }
  }
  static [candyColor] MediumBlue () {
    return @{R = 0
      G        = 0
      B        = 205
    }
  }
  static [candyColor] MediumOrchid () {
    return @{R = 186
      G        = 85
      B        = 211
    }
  }
  static [candyColor] MediumPurple () {
    return @{R = 147
      G        = 112
      B        = 219
    }
  }
  static [candyColor] MediumSeaGreen () {
    return @{R = 60
      G        = 179
      B        = 113
    }
  }
  static [candyColor] MediumSlateBlue () {
    return @{R = 123
      G        = 104
      B        = 238
    }
  }
  static [candyColor] MediumSpringGreen () {
    return @{R = 0
      G        = 250
      B        = 154
    }
  }
  static [candyColor] MediumTurquoise () {
    return @{R = 72
      G        = 209
      B        = 204
    }
  }
  static [candyColor] MediumVioletRed () {
    return @{R = 199
      G        = 21
      B        = 133
    }
  }
  static [candyColor] MidnightBlue () {
    return @{R = 25
      G        = 25
      B        = 112
    }
  }
  static [candyColor] MintCream () {
    return @{R = 245
      G        = 255
      B        = 250
    }
  }
  static [candyColor] MistyRose () {
    return @{R = 255
      G        = 228
      B        = 225
    }
  }
  static [candyColor] Moccasin () {
    return @{R = 255
      G        = 228
      B        = 181
    }
  }
  static [candyColor] NavajoWhite () {
    return @{R = 255
      G        = 222
      B        = 173
    }
  }
  static [candyColor] Navy () {
    return @{R = 0
      G        = 0
      B        = 128
    }
  }
  static [candyColor] OldLace () {
    return @{R = 253
      G        = 245
      B        = 230
    }
  }
  static [candyColor] Olive () {
    return @{R = 128
      G        = 128
      B        = 0
    }
  }
  static [candyColor] OliveDrab () {
    return @{R = 107
      G        = 142
      B        = 35
    }
  }
  static [candyColor] Orange () {
    return @{R = 255
      G        = 165
      B        = 0
    }
  }
  static [candyColor] OrangeRed () {
    return @{R = 255
      G        = 69
      B        = 0
    }
  }
  static [candyColor] Orchid () {
    return @{R = 218
      G        = 112
      B        = 214
    }
  }
  static [candyColor] PaleGoldenrod () {
    return @{R = 238
      G        = 232
      B        = 170
    }
  }
  static [candyColor] PaleGreen () {
    return @{R = 152
      G        = 251
      B        = 152
    }
  }
  static [candyColor] PaleTurquoise () {
    return @{R = 175
      G        = 238
      B        = 238
    }
  }
  static [candyColor] PaleVioletRed () {
    return @{R = 219
      G        = 112
      B        = 147
    }
  }
  static [candyColor] PapayaWhip () {
    return @{R = 255
      G        = 239
      B        = 213
    }
  }
  static [candyColor] PeachPuff () {
    return @{R = 255
      G        = 218
      B        = 185
    }
  }
  static [candyColor] Peru () {
    return @{R = 205
      G        = 133
      B        = 63
    }
  }
  static [candyColor] Pink () {
    return @{R = 255
      G        = 192
      B        = 203
    }
  }
  static [candyColor] Plum () {
    return @{R = 221
      G        = 160
      B        = 221
    }
  }
  static [candyColor] PowderBlue () {
    return @{R = 176
      G        = 224
      B        = 230
    }
  }
  static [candyColor] Purple () {
    return @{R = 128
      G        = 0
      B        = 128
    }
  }
  static [candyColor] RebeccaPurple () {
    return @{R = 102
      G        = 51
      B        = 153
    }
  }
  static [candyColor] Red () {
    return @{R = 255
      G        = 0
      B        = 0
    }
  }
  static [candyColor] RosyBrown () {
    return @{R = 188
      G        = 143
      B        = 143
    }
  }
  static [candyColor] RoyalBlue () {
    return @{R = 65
      G        = 105
      B        = 225
    }
  }
  static [candyColor] SaddleBrown () {
    return @{R = 139
      G        = 69
      B        = 19
    }
  }
  static [candyColor] Salmon () {
    return @{R = 250
      G        = 128
      B        = 114
    }
  }
  static [candyColor] SandyBrown () {
    return @{R = 244
      G        = 164
      B        = 96
    }
  }
  static [candyColor] SeaGreen () {
    return @{R = 46
      G        = 139
      B        = 87
    }
  }
  static [candyColor] SeaShell () {
    return @{R = 255
      G        = 245
      B        = 238
    }
  }
  static [candyColor] Sienna () {
    return @{R = 160
      G        = 82
      B        = 45
    }
  }
  static [candyColor] Silver () {
    return @{R = 192
      G        = 192
      B        = 192
    }
  }
  static [candyColor] SkyBlue () {
    return @{R = 135
      G        = 206
      B        = 235
    }
  }
  static [candyColor] SlateBlue () {
    return @{R = 106
      G        = 90
      B        = 205
    }
  }
  static [candyColor] SlateGray () {
    return @{R = 112
      G        = 128
      B        = 144
    }
  }
  static [candyColor] Snow () {
    return @{R = 255
      G        = 250
      B        = 250
    }
  }
  static [candyColor] SpringGreen () {
    return @{R = 0
      G        = 255
      B        = 127
    }
  }
  static [candyColor] SteelBlue () {
    return @{R = 70
      G        = 130
      B        = 180
    }
  }
  static [candyColor] Tan () {
    return @{R = 210
      G        = 180
      B        = 140
    }
  }
  static [candyColor] Teal () {
    return @{R = 0
      G        = 128
      B        = 128
    }
  }
  static [candyColor] Thistle () {
    return @{R = 216
      G        = 191
      B        = 216
    }
  }
  static [candyColor] Tomato () {
    return @{R = 255
      G        = 99
      B        = 71
    }
  }
  static [candyColor] Transparent () {
    return @{R = 255
      G        = 255
      B        = 255
    }
  }
  static [candyColor] Turquoise () {
    return @{R = 64
      G        = 224
      B        = 208
    }
  }
  static [candyColor] Violet () {
    return @{R = 238
      G        = 130
      B        = 238
    }
  }
  static [candyColor] Wheat () {
    return @{R = 245
      G        = 222
      B        = 179
    }
  }
  static [candyColor] White () {
    return @{R = 255
      G        = 255
      B        = 255
    }
  }
  static [candyColor] WhiteSmoke () {
    return @{R = 245
      G        = 245
      B        = 245
    }
  }
  static [candyColor] Yellow () {
    return @{R = 255
      G        = 255
      B        = 0
    }
  }
  static [candyColor] YellowGreen () {
    return @{R = 154
      G        = 205
      B        = 50
    }
  }

}

class Color {
  [candyColor]$Foreground = $null
  [candyColor]$Background = $null
  [Styles]$style
  
  static [string] color16 (
    [string]$Text,
    [int]$ForegroundColor = -1,
    [int]$BackgroundColor = -1,
    [switch]$Underline,
    [switch]$Strike
  ) {
    $esc = $([char]0x1b)
  
    $fore = ""
    $back = ""
    $Under = ""
    $Stri = ""
    if ($ForegroundColor -ne -1) {
      $fore = "$esc[38;5;$($ForegroundColor)m"
    }
    if ( $BackgroundColor -ne -1 ) {
      $back = "$esc[48;5;$($BackgroundColor)m"
    }
    if ($Underline) {
      $under = "$esc[4m"
    }
    if ($Strike) {
      $stri = "$esc[9m"
    }
    $close = "$esc[0m"
    $result = "$under$stri$fore$back$Text$close"
    return $result
  }

  static [string] colorRGB (
    [string]$Text,
    [candyColor]$Foreground,
    [candyColor]$Background,
    [switch]$Underline,
    [switch]$Strike
  ) {
    $esc = $([char]0x1b)
  
    $Fore = ""
    $Back = ""
    $Under = ""
    $Stri = ""
    
    if ($null -ne $Foreground) {
      $fore = "$esc[38;2;$($Foreground.R);$($Foreground.G);$($Foreground.B)m"
    }
    if ($null -ne $Background) {
      $back = "$esc[48;2;$($Background.R);$($Background.G);$($Background.B)m"
    }
    if ($Underline) {
      $under = "$esc[4m"
    }
    if ($Strike) {
      $stri = "$esc[9m"
    }
    $close = "$esc[0m"
    $result = "$under$stri$fore$back$Text$close"
    return $result
  }

  color (
    [candyColor]$Foreground,
    [candyColor]$Background = $null
  ) {
    $this.Foreground = $Foreground
    $this.Background = $Background
  }

  color (
    [candyColor]$Foreground
  ) {
    $this.Foreground = $Foreground
  }    
  
  [string]render (
    [string]$text
  ) {
    $esc = $([char]0x1b)
  
    $Fore = ""
    $Back = ""
    $Under = ""
    $Stri = ""
    if ($null -ne $this.Foreground) {
      $fore = "$esc[38;2;$($this.Foreground.R);$($this.Foreground.G);$($this.Foreground.B)m"
    }
    
    if ($null -ne $this.Background) {
      $back = "$esc[48;2;$($this.Background.R);$($this.Background.G);$($this.Background.B)m"
    }
    if ( ($this.style -band [Styles]::Underline) -eq [Styles]::Underline ) {
      $under = "$esc[4m"
    }
    
    
    if (($this.style -band [styles]::Strike) -eq [Styles]::Strike) {
      $stri = "$esc[9m"
    }
    $close = "$esc[0m"
    $result = "$under$stri$fore$back$Text$close"
    return $result
  }

  [string]render (
    [string]$text,
    [Styles]$style
  ) {
    $oldStyle = $this.style
    $this.style = $style

    $result = $this.render($text)

    $this.style = $oldStyle
    return $result
  }
}


class Option {
  [String]$text
  [PSCustomObject]$value
  [bool]$selected = $false

  Option(
    [String]$text,
    [PSCustomObject]$value
  ) {
    $this.text = $text
    $this.value = $value
  }
  Option(
    [String]$text,
    [PSCustomObject]$value,
    [bool]$selected
  ) {
    $this.text = $text
    $this.value = $value
    $this.selected = $selected
  }
}
class Border {
  static [hashtable] GetBorder(
    [string]$type = "Normal"
  ) {
    return $script:BorderTypes[$type]
  }
}

class Spinner {
  [hashtable]$Spinner
  [System.Collections.Hashtable]$statedata
  $runspace
  [powershell]$session
  [Int32]$X = $Host.UI.RawUI.CursorPosition.X
  [Int32]$Y = $Host.UI.RawUI.CursorPosition.Y
  [bool]$running = $false
  [Int32]$width = $Host.UI.RawUI.BufferSize.Width
  [candyColor]$SpinColor = [Colors]::MediumOrchid()
  [bool]$CuirsorState = [System.Console]::CursorVisible

  $Spinners = @{
    "Circle" = @{
      "Frames" = @("◜", "◠", "◝", "◞", "◡", "◟")
      "Sleep"  = 50
    }
    "Dots"   = @{
      "Frames" = @("⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷", "⣿")
      "Sleep"  = 50
    }
    "Line"   = @{
      "Frames" = @("▰▱▱▱▱▱▱", "▰▰▱▱▱▱▱", "▰▰▰▱▱▱▱", "▰▰▰▰▱▱▱", "▰▰▰▰▰▱▱", "▰▰▰▰▰▰▱", "▰▰▰▰▰▰▰", "▰▱▱▱▱▱▱")
      "Sleep"  = 50
    }
    "Square" = @{
      "Frames" = @("⣾⣿", "⣽⣿", "⣻⣿", "⢿⣿", "⡿⣿", "⣟⣿", "⣯⣿", "⣷⣿", "⣿⣾", "⣿⣽", "⣿⣻", "⣿⢿", "⣿⡿", "⣿⣟", "⣿⣯", "⣿⣷")
      "Sleep"  = 50
    }
    "Bubble" = @{
      "Frames" = @("......", "o.....", "Oo....", "oOo...", ".oOo..", "..oOo.", "...oOo", "....oO", ".....o", "....oO", "...oOo", "..oOo.", ".oOo..", "oOo...", "Oo....", "o.....", "......")
      "Sleep"  = 50
    }
    "Arrow"  = @{
      "Frames" = @("≻    ", " ≻   ", "  ≻  ", "   ≻ ", "    ≻", "    ≺", "   ≺ ", "  ≺  ", " ≺   ", "≺    ")
      "Sleep"  = 50
    }
    "Pulse"  = @{
      "Frames" = @("◾", "◾", "◼️", "◼️", "⬛", "⬛", "◼️", "◼️")
      "Sleep"  = 50
    }
  }

  Spinner(
    [string]$type = "Dots"
  ) {
    $this.Spinner = $this.Spinners[$type]
  }

  Spinner(
    [string]$type = "Dots",
    [int]$X,
    [int]$Y
  ) {
    $this.Spinner = $this.Spinners[$type]
    $this.X = $X
    $this.Y = $Y
  }

  [void] Start(
    [string]$label = "Loading..."
  ) {
    $this.running = $true
    $this.statedata = [System.Collections.Hashtable]::Synchronized([System.Collections.Hashtable]::new())
    $this.runspace = [runspacefactory]::CreateRunspace()
    $this.statedata.offset = ($this.Spinner.Frames | Measure-Object -Property Length -Maximum).Maximum
    $ThemedFrames = @()
    $color = [Color]::new($this.SpinColor)
    $this.Spinner.Frames | ForEach-Object {
      $ThemedFrames += $color.render($_)
    }
    $this.statedata.Frames = $ThemedFrames
    $this.statedata.Sleep = $this.Spinner.Sleep
    $this.statedata.label = $label
    $this.statedata.oldLabel = $label
    $this.statedata.X = $this.X
    $this.statedata.Y = $this.Y
    $this.runspace.Open()
    $this.Runspace.SessionStateProxy.SetVariable("StateData", $this.StateData)
    $sb = {
      [System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8
      [system.Console]::CursorVisible = $false
      $X = $StateData.X
      $Y = $StateData.Y
    
      $Frames = $statedata.Frames
      $i = 0
      while ($true) {
        [System.Console]::setcursorposition($X, $Y)
        $text = $Frames[$i]    
        [system.console]::write($text)
        [System.Console]::setcursorposition(($X + $statedata.offset) + 1, $Y)
        [system.console]::write((" " * 80))
        [System.Console]::setcursorposition(($X + $statedata.offset) + 1, $Y)
        [system.console]::write($statedata.label)
        $i = ($i + 1) % $Frames.Length
        Start-Sleep -Milliseconds $Statedata.Sleep
      }
    }
    $this.session = [powershell]::create()
    $null = $this.session.AddScript($sb)
    $this.session.Runspace = $this.runspace
    $null = $this.session.BeginInvoke()
  }

  [void] SetLabel(
    [string]$label
  ) {
    $this.statedata.label = $label
  }

  [void] SetColor(
    [candyColor]$color
  ) {
    $this.SpinColor = $color
  }

  [void] Stop() {
    if ($this.running -eq $true) {
      [System.Console]::setcursorposition(0, $this.Y)
      [system.console]::write("".PadLeft($this.Width, " "))
      $this.running = $false
      $this.session.Stop()
      $this.runspace.Close()
      $this.runspace.Dispose()
      [System.Console]::setcursorposition($this.X, $this.Y)
      [system.Console]::CursorVisible = $this.CuirsorState
    } 
  }
}

class ListItem {
  [string]$text
  [PSCustomObject]$value
  [string]$Icon
  [bool]$selected = $false
  [bool]$checked = $false
  [bool]$chained = $true
  [bool]$header = $false
  [candyColor]$Color = [Colors]::White()  
  [Color]$IconColor = [Color]::New([Colors]::White())

  ListItem(
    [string]$text,
    [PSCustomObject]$value,
    [string]$Icon
  ) {
    $this.text = $text
    $this.value = $value
    $this.Icon = $Icon
  }

  ListItem(
    [string]$text,
    [PSCustomObject]$value,
    [string]$Icon,
    [candyColor]$Color
  ) {
    $this.text = $text
    $this.value = $value
    $this.Icon = $Icon
    $this.Color = $Color
  }
  ListItem(
    [string]$text,
    [PSCustomObject]$value,
    [candyColor]$Color
  ) {
    $this.text = $text
    $this.value = $value
    $this.Color = $Color
  }

  ListItem(
    [string]$text,
    [PSCustomObject]$value
  ) {
    $this.text = $text
    $this.value = $value
    $this.Icon = ""
  }
}

function padRightUTF8 {
  param(
    [string]$text,
    [int]$length
  )
  $bytecount = 0
  $text.ToCharArray() | ForEach-Object {
    $b = [Text.Encoding]::UTF8.Getbytecount($_)
    if ($b -ge 2) {
      $b = $b - 1
    }
    $bytecount += ($b) 
  }

  $totalbytes = [Text.Encoding]::UTF8.GetByteCount("".PadLeft($length, " "))
  $diff = $totalbytes - $bytecount
  if ($diff -lt 0) {
    $text.Substring(0, $length)  
  }
  else {
    [string]::Concat($text, "".PadLeft($diff, " "))
  }
  
}

class List {
  [System.Collections.Generic.List[ListItem]]$items
  [int]$pages = 1
  [int]$page = 1
  [int]$height = 10
  [int]$index = 0
  [int]$width = $Host.UI.RawUI.BufferSize.Width - 3
  [string]$filter = ""
  [string]$blanks = (" " * $Host.UI.RawUI.BufferSize.Width) * ($this.height + 1)
  [int]$linelen = 0
  [char]$selector = ">"
  [Color]$SearchColor = [Color]::new([Colors]::BlueViolet())
  [Color]$HeaderColor = [Color]::new([Colors]::BlueViolet())
  [Color]$SelectedColor = [Color]::new([Colors]::Green())
  [Color]$FilterColor = [Color]::new([Colors]::Orange())
  [Color]$NoFilterColor = [Color]::new([Colors]::Green())
  [string]$checked = "▣"
  [string]$unchecked = "▢"
  [bool]$limit = $false
  [bool]$border = $false
  [bool]$fullscreen = $true
  [string]$header = ""
  [int]$nbToDraw = 0
  [hashtable]$borderType = [Border]::GetBorder("Rounded")
  [hashtable]$theme = @{}
  [int]$Y = $global:Host.UI.RawUI.CursorPosition.Y
  
  # TODO: Rendre paramétrable le style de sélection
  [candyColor] toColor([string]$color) {
    $methodInfo = [colors].GetMethod($color, [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::Public)
    [candyColor]$candycolor = $methodinfo.Invoke($null, $null)
    return $candycolor
  }

  [void] LoadTheme([hashtable]$theme) {
    $this.theme = $theme
    if ($this.theme.list) {
      if ($this.theme.list.SelectedColor) {
        $this.selectedColor = [Color]::new($this.toColor($this.theme.list.SelectedColor))
      }
      if ($this.theme.list.SearchColor) {
        $this.SearchColor = [Color]::new($this.toColor($this.theme.list.SearchColor))
      }
      if ($this.theme.list.FilterColor) {
        $this.FilterColor = [Color]::new($this.toColor($this.theme.list.FilterColor))
      }
      if ($this.theme.list.NoFilterColor) {
        $this.NoFilterColor = [Color]::new($this.toColor($this.theme.list.NoFilterColor))
      }
      if ($this.theme.list.Selectedstyle) {
        $this.SelectedColor.style = $this.theme.list.Selectedstyle
      }
      if ($this.theme.list.Checked) {
        $this.checked = $this.theme.list.Checked 
      }
      if ($this.theme.list.UnChecked) {
        $this.unchecked = $this.theme.list.UnChecked
      }
    }
  }

  List (
    [System.Collections.Generic.List[ListItem]]$items
  ) {
    $this.items = $items
    $this.items | ForEach-Object {
      $_.selected = $false
      $_.checked = $false
    }
    $this.selectedColor.style = [Styles]::Underline
    # $this.LoadTheme()
  }

  [Void] DrawTitle(
    [string]$title
  ) {
    [console]::setcursorposition(0, 0)
    [console]::WriteLine($title)
  }

  [Void] DrawFooter() {
    $footerOffset = (4 + $this.y)
    if ($this.border) {
      $footerOffset = (4 + $this.Y)
    }
    [console]::setcursorposition(0, $this.height + $footerOffset)
    [Console]::Write((" " * $this.width))
    [console]::setcursorposition(0, $this.height + $footerOffset)
    $footer = "◖"
    if ($this.pages -gt 1) {
      $footer += " " + "$($this.page)/$($this.pages)"
    }
    
    if ($this.filter -and ($this.filter -ne "")) {
      $filtertext = $this.FilterColor.render("$($this.filter)")
    }
    else {
      $filtertext = $this.noFilterColor.render("None")
    }
    $footer += " ⋮ [Filter: $($filtertext)] ◗"
    [console]::WriteLine($footer)
  }

  [void] SetHeight(
    [int]$height
  ) {
    $this.height = $height
    $this.blanks = (" " * $global:Host.UI.RawUI.BufferSize.Width) * ($this.height + 2)
  }

  [void] SetWidth(
    [int]$Width
  ) {
    $this.width = $width
    $this.blanks = (" " * $global:Host.UI.RawUI.BufferSize.Width) * ($this.height + 2)
  }

  [void]  SetLimit(
    [Bool]$limit
  ) {
    $this.limit = $limit
  }

  [void] SetItems([System.Collections.Generic.List[ListItem]]$items) {
    $this.items = $items
  }


  [void] SetHeader([string]$header) {
    $this.header = $header
  }

  [String] MakeBufer(
    [System.Collections.Generic.List[ListItem]]$items
  ) {
    $i = 0
    $offset = 0
    if ($this.limit) {
      $baseoffset = 0
    }
    else {
      $baseoffset = 0
    }
    if ($items) {
      $buffer = $items | ForEach-Object {
        $checkmark = ""
        if ($_.Icon) {
          $offset = $baseoffset - 2
        }
        else {
          $offset = $baseoffset - 1
        }
        # $text = $_.text.PadRight(($this.linelen + $offset), " ")
        $text = padRightUTF8 -text $_.text -length ($this.linelen + $offset)
        $icon = $_.Icon 
        if (($null -ne $icon) -and ($icon.Trim() -ne "")) {
          $icon = $_.IconColor.render($icon)
          $icon = $icon -replace "\e\[0m", ''
          # $text = "$icon $text"          
        }
        if ($null -ne $_.Color) {
          $c = [Color]::new($_.Color)
          $text = $c.render($text)
        }
        if ($this.limit) {
          $text = "$icon $text"
          if ($this.index -eq $i) {
            $text = $this.SelectedColor.render($text)
          }
          else {
            $text = $text
          }
        }
        else {
          if ($_.checked) {
            $checkmark = $this.checked
          }
          else {
            $checkmark = $this.unchecked
          }
          $text = "$checkmark $icon $text"
          if ($this.index -eq $i) {
            $text = $this.SelectedColor.render("$($this.selector) $($text)")
          }
          else {
            $text = "  $($text)"
          }
        }
        $text
        $i++
      } | Out-String
    }
    else {
      $buffer = "Too much filter ? 😊"
    }
    if ($this.border) {
      while ($i -lt $this.height) {
        $buffer += $this.borderType.Left + "".PadRight(($this.linelen + 4 + $offset), " ") + $this.borderType.Right + "`n"
        $i++
      }
      $buffer = $this.borderType.TopLeft + "".PadLeft(($this.linelen + 4 + $offset), $this.borderType.Top) + $this.borderType.TopRight + "`n" + $buffer
      $buffer = $buffer + $this.borderType.BottomLeft + "".PadLeft(($this.linelen + 4 + $offset), $this.borderType.Bottom) + $this.borderType.BottomRight
    }
    return $buffer
  }

  [System.Collections.Generic.List[PSObject]] Display() {
    $result = @()
    $this.pages = [math]::Ceiling($this.items.Count / $this.height)
    [System.Collections.Generic.List[ListItem]]$VisibleItems = @()
    $stop = $false
    [console]::CursorVisible = $false
    $redraw = $true
    $search = $false
    $continue = $false
    if ($this.fullscreen) {
      $this.linelen = $this.width 
      if (-not $this.limit) {
        $this.linelen = $this.width - 2
      }
    }
    else {
      $this.linelen = ($this.items | Measure-Object -Maximum {
        ($_.text).Length
        }).Maximum
    }
    
    # $this.linelen = ($this.items | Measure-Object -Maximum {
    #   ($_.text -replace "\e\[[\d;]*m", '').Length
    # }).Maximum
    # [System.Console]::Clear()
    while (-not $stop) {
      if ($redraw) {
        if ($search) {
          # TODO: Gérer les coordonnées pour intégrer le cadre
          [Console]::setcursorposition(0, $this.Y)
          [console]::Write($this.SearchColor.Render("Search: "))
          [console]::CursorVisible = $true
          $this.filter = $global:host.UI.ReadLine()
          [console]::CursorVisible = $false
          $search = $false
          $redraw = $true
          Continue
        }
        else {
          [console]::Write("".PadLeft(80, " ")) 
        }
        $this.nbToDraw = $this.height
        if ($this.header -ne "") {
          $this.nbToDraw = $this.height - 2
        }
        if ($this.filter -and ($this.filter -ne "")) {
          $VisibleItems = $this.items | Where-Object {
            $_.text -match $this.filter
          } | Select-Object -Skip (($this.page - 1) * $this.height) -First $this.height
          $this.pages = [math]::Ceiling($VisibleItems.Count / $this.height)
        }
        else {
          $VisibleItems = $this.items | Select-Object -Skip (($this.page - 1) * $this.height) -First $this.height
          $this.pages = [math]::Ceiling($this.items.Count / $this.height)
        }
        $buffer = $this.MakeBufer($VisibleItems)
        [Console]::setcursorposition(0, $this.Y)
        [Console]::Write($this.blanks)
        [Console]::setcursorposition(0, ($this.Y + 1))
        if ($this.index -gt $VisibleItems.Count - 1 ) {
          $this.index = 0

        }
        if ($this.header -ne "") {
          $out = [string]::concat("".padleft(6, " "), $this.header)
          $out = $out.PadRight($this.linelen + 3, " ")
          $out = $this.HeaderColor.render($out)
          [Console]::WriteLine("$out")
        }
        [System.Console]::Write($buffer)
        
        $this.DrawFooter()
      }
      $redraw = $false
      if ($global:Host.UI.RawUI.KeyAvailable) {
        [System.Management.Automation.Host.KeyInfo]$key = $($global:host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'))
        if ($env:DEBUGVISUAL -eq $true) {
          $bottom = ($this.height + 2) + $this.Y
          [Console]::setcursorposition(0, $bottom)
          if ($this.filter -and ($this.filter -ne "")) {
            Write-Host "Filter : $($this.filter)"
          }
          else {
            Write-Host "No Filter                    "
          }
          [Console]::setcursorposition(0, ($bottom + 1))
          [Console]::write("Key: $($key.VirtualKeyCode)  Char : $($key.Character)")
          [Console]::setcursorposition(0, ($bottom + 2))
          [Console]::write("Key: $($key.ControlKeyState)  ")
          [Console]::setcursorposition(20, ($bottom + 1))
          [Console]::write("LineLen: $($this.linelen)  ")
          
        }
        switch ($key.VirtualKeyCode) {
          { (($_ -ge 65) -and ($_ -le 101)) -or (($_ -ge 48) -and ($_ -le 57)) } {
            $car = $key.Character.ToString()
            if ($key.ControlKeyState -eq "ShiftPressed") {
              $car = $car.ToUpper()
            }
            $this.filter = $this.filter + $Car
            $VisibleItems = $this.items | Where-Object {
              $_.text -cmatch $this.filter
            } | Select-Object -Skip (($this.page - 1) * $this.height) -First $this.height
            $redraw = $true
          }
          8 {
            # Backspace
            if ($this.filter.Length -gt 0) {
              $this.filter = $this.filter.Substring(0, $this.filter.Length - 1)
              $VisibleItems = $this.items | Where-Object {
                $_.text -match $this.filter
              } | Select-Object -Skip (($this.page - 1) * $this.height) -First $this.height
              $redraw = $true
            }
          }
          38 {
            # Up
            
            $this.index--
            $redraw = $true
            
          }
          40 {
            # Down
            
            $this.index++
            $redraw = $true
            
          }
          191 {
            if ($key.ControlKeyState -eq "ShiftPressed") {
              $search = $true
              $redraw = $true
            }
          }
          37 {
            # Left
            if ($key.ControlKeyState -eq "LeftCtrlPressed") {

            }
            else {
              if ($this.page -gt 1) {
                $this.page--
                $redraw = $true
                [System.Collections.Generic.List[ListItem]]$VisibleItems = $this.items | Select-Object -Skip (($this.page - 1) * $this.height) -First $this.height
              }
            }
          }
          39 {
            # Right
            if ($key.ControlKeyState -eq "LeftCtrlPressed") {

            }
            else {
              if ($this.page -lt $this.pages) {
                $this.page++
                $redraw = $true
                [System.Collections.Generic.List[ListItem]]$VisibleItems = $this.items | Select-Object -Skip (($this.page - 1) * $this.height) -First $this.height
              }
            }
          }
          9 {
            # Tab
            $VisibleItems[$this.index].checked = -not $VisibleItems[$this.index].checked
            $this.index++
            $redraw = $true
          }
          13 {
            # Enter
            $stop = $true
            if ($this.limit) {
              if ($key.ControlKeyState -eq "LeftCtrlPressed") {
                $continue = $true
              }
              $result = $VisibleItems[$this.index]
            }
            else {
              $this.items | ForEach-Object {
                if ($_.checked) {
                  $result += $_
                }
              }
            }
          }
          27 {
            $stop = $true
          }
        }
        if ($redraw) {
          if ($this.index -lt 0) {
            $this.index = 0
          }
          if ($this.index -gt $VisibleItems.Count - 1) {
            $this.index = $VisibleItems.Count - 1
          }
        }
        # [console]::Clear()
      }
    }
    [console]::CursorVisible = $true
    [Console]::Clear()
    if ($continue) {
      $fields = "text", "value", "chained"
    }
    else {
      $fields = "text", "value"
    }
    
    return $result | Select-Object -Property $fields
  }

}

class Confirm {
  [string]$Message = ""
  [Option[]]$Choices
  [int]$width = $Host.UI.RawUI.BufferSize.Width - 2
  [bool]$fullscreen = $false
  [Color]$SeletedColor = [color]::new([Colors]::White(), [Colors]::BlueViolet())
  [Color]$OptionColor = [color]::new([Colors]::Cyan())
  [Color]$MessageColor = [color]::new([Colors]::White())
  [int]$index = 0
  Confirm(
    [string]$Message,
    [Option[]]$Choices,
    [int]$width
  ) {
    $this.Message = $Message
    $this.Choices = $Choices
    $this.fullscreen = $false
    $this.width = $width
  }

  Confirm(
    [string]$Message,
    [Option[]]$Choices,
    [bool]$fullscreen
  ) {
    $this.Message = $Message
    $this.Choices = $Choices
    $this.fullscreen = $true
  }

  [void] LoadTheme() {
    # $this.SeletedColor = [Color]::new($script:Theme.Choice.SelectedForeground ? $script:Theme.Choice.SelectedForeground : [Colors]::White()
    #   ,
    #   $script:Theme.Choice.SelectedBackground ? $script:Theme.Choice.SelectedBackground : [Colors]::BlueViolet())
    # $this.OptionColor = [Color]::new($script:Theme.Choice.OptionColor ? $script:Theme.Choice.OptionColor : [Colors]::Cyan())
    # $this.MessageColor = [Color]::new($script:Theme.Choice.MessageColor ? $script:Theme.Choice.MessageColor : [Colors]::White())  
  }

  [PSCustomObject] Display() {
    $this.LoadTheme()
    $result = $null
    $title = $this.Message
    $padding = [Math]::Ceiling(($this.width - $title.Length) / 2) #
    $filler = "".padleft($padding, " ")
    [Console]::WriteLine($this.MessageColor.Render("$filler$title"))
    $nbChoices = $this.Choices.Count
    $choiceWidth = [Math]::Floor($this.width / $nbChoices) - 4
    [Console]::WriteLine()
    $buffer = $this.choices | ForEach-Object {
      $text = $_.text
      $padding = [Math]::Ceiling(($choiceWidth - $text.Length) / 2)
      $filler = "".padleft($padding, " ")
      $text = $filler.Remove([math]::Floor($padding / 2), [math]::Floor($text.Length / 2)).Insert([math]::Floor($padding / 2), $text)
      
      $_.text = $text
    }
    $buttonswidth = 0
    $this.Choices | ForEach-Object {
      $buttonswidth += $_.text.Length
    }
    $spaceleft = $this.width - $buttonswidth
    $filler = [math]::Floor($spaceleft / ($this.Choices.Count + 1))
    $space = "".padleft($filler, " ")
    # Write-Host $space -NoNewline
    $stop = $false
    $y = [Console]::CursorTop
    [console]::CursorVisible = $false
    $this.index = 0
    $i = 0
    $this.Choices | ForEach-Object {
      if ($_.selected) {
        $this.index = $i
      }
      $i++
    }
    $this.Choices[$this.index].selected = $true
    while (-not $stop) {
      $buffer = $this.Choices | ForEach-Object {
        if ($_.selected) {
          $text = $this.SeletedColor.render($_.text)
        }
        else {
          $text = $this.OptionColor.render($_.text)
        }
        "$space$($text)"
      } | Out-String 
      [Console]::SetCursorPosition(0, $y)
      [Console]::Write(($buffer -split "`r`n") -join '')
      if ($global:Host.UI.RawUI.KeyAvailable) {
        [System.Management.Automation.Host.KeyInfo]$key = $($global:host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'))
        if ($key.VirtualKeyCode -eq 13) {
          $stop = $true
          $result = $this.Choices | Where-Object { $_.selected -eq $true }
        }
        if ($key.VirtualKeyCode -eq 37) {
          # Left
          $this.Choices[$this.index].selected = $false
          if ($this.index -eq 0) {
            $this.index = $this.Choices.Count - 1
          }
          else {
            $this.index--
          }
          $this.Choices[$this.index].selected = $true
        }
        if ($key.VirtualKeyCode -eq 39) {
          # Right
          $this.Choices[$this.index].selected = $false
          if ($this.index -eq ($this.Choices.Count - 1)) {
            $this.index = 0
          }
          else {
            $this.index++
          }
          $this.Choices[$this.index].selected = $true
        }
      }
    }
    [console]::CursorVisible = $true
    $fields = "value"
    return $result | Select-Object -Property $fields
  }
}

class Style {
  # TODO: Ajouter une gestion de la couleur et de l'alignement pat ligne
  # TODO: Ajouter des "sections" au composant
  [int]$width = $Host.UI.RawUI.BufferSize.Width - 2
  [string]$text = ""
  [Color]$color = [Color]::new([Colors]::White(), $null)
  [Styles]$style = [Styles]::Normal
  [bool]$border = $false
  [hashtable]$borderType = [Border]::GetBorder("Rounded")
  [Align]$align = [Align]::left

  Style(
    [string]$text
  ) {
    $this.text = $text
  }

  [void] SetColor(
    [candyColor]$Foreground,
    [candyColor]$Background
  ) {
    $this.color = [Color]::new($Foreground, $Background)
  }

  [void] SetColor(
    [candyColor]$Foreground
  ) {
    $this.color = [Color]::new($Foreground, $null)
  }

  [void] SetStyle(
    [Styles]$style
  ) {
    $this.style = $style
  }

  [void] SetBorder(
    [bool]$border
  ) {
    $this.border = $border
  }

  [void] setAlign(
    [Align]$align
  ) {
    $this.align = $align
  }

  [void] SetWidth(
    [int]$width
  ) {
    $this.width = $width
  }

  [void] SetLabel(
    [string]$text
  ) {
    $this.text = $text
  }

  [String] Render() {
    $labels = $this.text -split "`n"
    $label = $labels | ForEach-Object {
      $lbl = $_
      switch ($this.align) {
        Center {
          $lblClean = $lbl -replace "\e\[[\d;]*m", ''
          $lbllen = ($lblClean).Length
          $padding = ($this.width - $lbllen) / 2
          $leftpadding = [int][Math]::Floor($padding)
          $rightpadding = [int][Math]::Ceiling($padding)
          $lbl = (" " * $leftPadding) + $lbl + (" " * $rightPadding)
        }
        Right {
          $lbl = $lbl.PadLeft($this.width, " ")
        }
        Left {
          $lbl = $lbl.PadRight($this.width , " ")
        }
      }
      if ($this.color -ne [Color]::Empty) {
        $this.color.style = $this.style
        $lbl = $this.color.render($lbl)
      }
      $lbl
    }
    $result = $label -join "`n"
    if ($this.border) {
      $top = $this.borderType.TopLeft + "".PadLeft(($this.width), $this.borderType.Top) + $this.borderType.TopRight
      $result = $label | ForEach-Object {
        $this.borderType.Left + $_ + $this.borderType.Right
      } | Out-String
      # $buffer = result -join "" # $result = $this.borderType.Left + $label + $this.borderType.Right
      $result = $top + "`n" + $result + $this.borderType.BottomLeft + "".PadLeft(($this.width), $this.borderType.Bottom) + $this.borderType.BottomRight
    }

    return $result
  }

}

class Pager {
  $buffer
  [int]$height = $Host.UI.RawUI.BufferSize.Height - 2
  [int]$width = $Host.UI.RawUI.BufferSize.Width - 2
  [int]$offset = 0
  [int]$index = 0
  [Color]$selectedColor = [Color]::new($null, $null)
  [hashtable]$borderType = [Border]::GetBorder("Rounded")
  
  Pager(
    [string]$file
  ) {
    # TODO: check if bat is installed
    [console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $this.buffer = Invoke-Expression -Command "bat $file --style='numbers' -f --terminal-width $($this.width)"
    $this.selectedColor.style = [Styles]::Underline
  }

  [void] Display() {
    [console]::OutputEncoding = [System.Text.Encoding]::UTF8
    [console]::Clear()
    $stop = $false
    [console]::CursorVisible = $false
    while (-not $stop) {
      $i = 0
      $cache = $this.buffer | Select-Object -Skip $this.offset -First $this.height | ForEach-Object {
        if ($i -eq $this.index) {
          $line = $this.selectedColor.render(($_ -replace "\e\[[\d;]*m", '').padright($this.width, " "))
        }
        else {
          $offset = ($_ -replace "\e\[[\d;]*m", '').Length
          $line = $_.padright(($this.width + ($_.Length - $offset)), " ")
        }
        
        $i++
        $this.borderType.Left + $line + $this.borderType.Right
      } | Out-String
      $cache = ($this.borderType.TopLeft + "".padleft($this.width, $this.borderType.top) + $this.borderType.TopRight) + "`n" + $cache + ($this.borderType.BottomLeft + "".padleft($this.width, $this.borderType.bottom) + $this.borderType.BottomRight)
      [console]::setcursorposition(0, 0)
      [console]::write($cache)
      if ($global:Host.UI.RawUI.KeyAvailable) {
        [System.Management.Automation.Host.KeyInfo]$key = $($global:host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'))
        switch ($key.VirtualKeyCode) {
          38 {
            # Up
            $this.index --
            if ($this.index -lt 0) {
              $this.index = 0
              if ($this.offset -gt 0) {
                $this.offset--
              }
            }
            
          }
          40 {
            # Down
            $this.index++
            if ($this.index -gt ($this.height - 1)) {
              $this.index = $this.height - 1
              if ($this.offset -lt ($this.buffer.Length - $this.height)) {
                $this.offset++
              }
              
            }
          }
          27 {
            $stop = $true
          }
        }
      }
    }
    [console]::CursorVisible = $true
  }
}