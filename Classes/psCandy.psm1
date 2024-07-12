$None = [System.Drawing.Color]::Empty

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

class Color {
  [System.Drawing.Color]$Foreground = [System.Drawing.Color]::Empty
  [System.Drawing.Color]$Background = [System.Drawing.Color]::Empty
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
    [System.Drawing.Color]$Foreground,
    [System.Drawing.Color]$Background,
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
    [System.Drawing.Color]$Foreground,
    [System.Drawing.Color]$Background = [System.Drawing.Color]::Empty
  ) {
    $this.Foreground = $Foreground
    $this.Background = $Background
  }

  color (
    [System.Drawing.Color]$Foreground
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
    $fore = "$esc[38;2;$($this.Foreground.R);$($this.Foreground.G);$($this.Foreground.B)m"
    
    if ($this.Background -ne [System.Drawing.Color]::Empty) {
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
  [System.Drawing.Color]$SpinColor = ($script:theme.spinner.spincolor) ? $script:theme.spinner.spincolor : [System.Drawing.Color]::MediumOrchid
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
    [System.Drawing.Color]$color
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
  [System.Drawing.Color]$Color = $None

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
    [System.Drawing.Color]$Color
  ) {
    $this.text = $text
    $this.value = $value
    $this.Icon = $Icon
    $this.Color = $Color
  }
  ListItem(
    [string]$text,
    [PSCustomObject]$value,
    [System.Drawing.Color]$Color
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

class List {
  [System.Collections.Generic.List[ListItem]]$items
  [int]$pages = 1
  [int]$page = 1
  [int]$height = 10
  [int]$index = 0
  [int]$width = $Host.UI.RawUI.BufferSize.Width - 1
  [string]$filter = ""
  [string]$blanks = (" " * $Host.UI.RawUI.BufferSize.Width) * ($this.height + 1)
  [int]$linelen = 0
  [char]$selector = ">"
  [Color]$SearchColor = [Color]::new([System.Drawing.Color]::BlueViolet)
  [Color]$SelectedColor = [Color]::new([System.Drawing.Color]::Green)
  [Color]$FilterColor = [Color]::new([System.Drawing.Color]::Orange)
  [bool]$limit = $false
  [bool]$border = $false
  [bool]$fullscreen = $true
  [hashtable]$borderType = [Border]::GetBorder("Rounded")
  [hashtable]$theme = @{}
  
  # TODO: Rendre paramétrable le style de sélection

  [void] LoadTheme([hashtable]$theme) {
    $this.theme = $theme
    $this.SearchColor = [Color]::new($this.theme.list.SearchColor ? $theme.list.SearchColor : [System.Drawing.Color]::BlueViolet)
    $this.SelectedColor = [Color]::new($this.theme.list.SelectedColor ? $this.theme.list.SelectedColor : [System.Drawing.Color]::Green)
    $this.FilterColor = [Color]::new($this.theme.list.FilterColorColor ? $this.theme.list.FilterColor : [System.Drawing.Color]::Orange)
    $this.SelectedColor.style = $this.theme.list.SelectedStyle ? $this.theme.list.SelectedStyle : [Styles]::Underline
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
    $footerOffset = 2
    if ($this.border) {
      $footerOffset = 4
    }
    [console]::setcursorposition(0, $this.height + $footerOffset)
    [Console]::Write((" " * $this.width))
    [console]::setcursorposition(0, $this.height + $footerOffset)
    $footer = "◖ $($this.page)/$($this.pages)"
    if ($this.filter -and ($this.filter -ne "")) {
      $this.FilterColor = [Color]::new($script:theme.list.FilterColor ? $script:theme.list.FilterColor : [System.Drawing.Color]::Orange)
      $this.FilterColor.style = $script:theme.list.FilterStyle ? $script:theme.list.FilterStyle : [Styles]::Underline 
      $filtertext = $this.FilterColor.render("$($this.filter)")
    }
    else {
      $this.FilterColor = [Color]::new([System.Drawing.Color]::Green)
      $this.FilterColor.style = [Styles]::Normal
      $filtertext = $this.FilterColor.render("None")
    }
    $footer += "⋮ [Filter: $($filtertext)] ◗"
    [console]::WriteLine($footer)
  }

  [void] SetHeight(
    [int]$height
  ) {
    $this.height = $height
    $this.blanks = (" " * $global:Host.UI.RawUI.BufferSize.Width) * ($this.height + 1)
  }

  [void]  SetLimit(
    [Bool]$limit
  ) {
    $this.limit = $limit
  }

  [String] MakeBufer(
    [System.Collections.Generic.List[ListItem]]$items
  ) {
    $checked = $this.theme.list.Checked ? $this.theme.list.Checked : "▣"
    $unchecked = $this.theme.list.UnChecked ? $this.theme.list.UnChecked : "▢"
    $i = 0
    $offset = 0
    if ($this.limit) {
      $baseoffset = 0
    }
    else {
      $baseoffset = -1
    }
    if ($items) {
      $buffer = $items | ForEach-Object {
        if ($_.Icon) {
          $offset = $baseoffset - 2
        }
        else {
          $offset = $baseoffset
        }
        $text = $_.text.PadRight(($this.linelen + $offset), " ")
        $icon = $_.Icon
        if ($icon) {
          $text = "$icon $text"
          
        }
        if ($_.Color -ne [System.Drawing.Color]::Empty) {
          $c = [Color]::new($_.Color)
          $text = $c.render($text)
        }
        if ($this.limit) {
          if ($this.index -eq $i) {
            $text = $this.SelectedColor.render($text)
          }
          else {
            $text = $text
          }
        }
        else {
          if ($_.checked) {
            $text = "$($checked) $text"
          }
          else {
            $text = "$($unchecked) $text"
          }
          if ($this.index -eq $i) {
            $text = $this.SelectedColor.render("$($this.selector) $($text)")
          }
          else {
            $text = "  $($text)"
          }
        }
        if ($this.border) {
          $this.borderType.Left + $text + $this.borderType.Right
        }
        else {
          $text
        }
        # $this.borderType.Left + $text + $this.borderType.Right
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
    # $this.linelen = ($this.items | select-object -ExpandProperty text | Measure-Object -Property Length, {($_ -replace "\e\[[\d;]*m", '')} -Maximum).Maximum
    if ($this.fullscreen) {
      $this.linelen = $this.width - 4
    }
    else {
      $this.linelen = ($this.items | Measure-Object -Maximum {
        ($_.text).Length
        }).Maximum
    }
    
    # $this.linelen = ($this.items | Measure-Object -Maximum {
    #   ($_.text -replace "\e\[[\d;]*m", '').Length
    # }).Maximum
    [System.Console]::Clear()
    while (-not $stop) {
      if ($redraw) {
        if ($search) {
          # TODO: Gérer les coordonnées pour intégrer le cadre
          [Console]::setcursorposition(0, 0)
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
        [Console]::setcursorposition(0, 0)
        [Console]::Write($this.blanks)
        [Console]::setcursorposition(0, 1)
        if ($this.index -gt $VisibleItems.Count - 1 ) {
          $this.index = 0

        }
        $buffer = $this.MakeBufer($VisibleItems)
        [System.Console]::Write($buffer)
        
        $this.DrawFooter()
      }
      $redraw = $false
      if ($global:Host.UI.RawUI.KeyAvailable) {
        [System.Management.Automation.Host.KeyInfo]$key = $($global:host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'))
        if ($env:DEBUGVISUAL -eq $true) {
          $bottom = $this.height + 2
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
  [Color]$SeletedColor 
  [Color]$OptionColor 
  [Color]$MessageColor 
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
    $this.SeletedColor = [Color]::new($script:Theme.Choice.SelectedForeground ? $script:Theme.Choice.SelectedForeground : [System.Drawing.Color]::White
      ,
      $script:Theme.Choice.SelectedBackground ? $script:Theme.Choice.SelectedBackground : [System.Drawing.Color]::BlueViolet)
    $this.OptionColor = [Color]::new($script:Theme.Choice.OptionColor ? $script:Theme.Choice.OptionColor : [System.Drawing.Color]::Cyan)
    $this.MessageColor = [Color]::new($script:Theme.Choice.MessageColor ? $script:Theme.Choice.MessageColor : [System.Drawing.Color]::White)  
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
  [int]$width = $Host.UI.RawUI.BufferSize.Width - 2
  [string]$text = ""
  [Color]$color = [Color]::new([System.Drawing.Color]::White, [System.Drawing.Color]::Empty)
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
    [System.Drawing.Color]$Foreground,
    [System.Drawing.Color]$Background
  ) {
    $this.color = [Color]::new($Foreground, $Background)
  }

  [void] SetColor(
    [System.Drawing.Color]$Foreground
  ) {
    $this.color = [Color]::new($Foreground, [System.Drawing.Color]::Empty)
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
          $w = $this.width 
          $t = $lbl.Length
          $lp = [math]::Floor(($w - $t) / 2)
          $lbl = $lbl.PadLeft($lp, " ").PadRight($w, " ")
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