. "$((Get-Location).Path)\constants.ps1"

[Flags()] enum Styles {
  Normal = 1
  Underline = 2
  Bold = 4
  Reversed = 8
  Strike = 16
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

class Spinner {
  [hashtable]$Spinner
  [System.Collections.Hashtable]$statedata
  $runspace
  [powershell]$session
  [Int32]$X = $Host.UI.RawUI.CursorPosition.X
  [Int32]$Y = $Host.UI.RawUI.CursorPosition.Y
  [bool]$running = $false
  [Int32]$width = $Host.UI.RawUI.BufferSize.Width
  [System.Drawing.Color]$SpinColor = [System.Drawing.Color]::MediumOrchid
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
    [System.Console]::setcursorposition(($this.X + $this.statedata.offset) + 1, $this.Y)
    [system.console]::write("".PadLeft($this.statedata.label.Length, " "))
    $this.statedata.label = $label
    # Redraw the label to avoid flickering
    [System.Console]::setcursorposition(($this.X + $this.statedata.offset) + 1, $this.Y)
    [system.console]::write($label)
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
  [bool]$selected = $false
  [bool]$checked = $false
  [Color]$SearchColor 
  [Color]$SelectedColor

  ListItem(
    [string]$text,
    [PSCustomObject]$value
  ) {
    $this.text = $text
    $this.value = $value
  }
}

class List {
  [System.Collections.Generic.List[ListItem]]$items
  [int]$pages = 1
  [int]$page = 1
  [int]$height = 10
  [int]$index = 0
  [int]$width = $Host.UI.RawUI.BufferSize.Width
  [string]$filter = ""
  [string]$blanks = (" " * $Host.UI.RawUI.BufferSize.Width) * ($this.height + 1)
  [int]$linelen = 0
  [char]$selector = ">"
  [Color]$SearchColor
  [Color]$SelectedColor
  # TODO: Rendre paramétrable le style de sélection
  List (
    [System.Collections.Generic.List[ListItem]]$items
  ) {
    $this.items = $items
    $this.items | ForEach-Object {
      $_.selected = $false
      $_.checked = $false
    }
    $this.SearchColor = [Color]::new([System.Drawing.Color]::BlueViolet)
    $this.SelectedColor = [Color]::new([System.Drawing.Color]::BlueViolet)
    $this.SelectedColor.style = [Styles]::Underline
  }

  [Void] DrawTitle(
    [string]$title
  ) {
    [console]::setcursorposition(0, 0)
    [console]::WriteLine($title)
  }

  [Void] DrawFooter() {
    [console]::setcursorposition(0, $this.height + 2)
    [Console]::Write((" " * $this.width))
    [console]::setcursorposition(0, $this.height + 2)
    $footer = "◖ $($this.page)/$($this.pages)"
    if ($this.filter -and ($this.filter -ne "")) {
      $FilterColor = [Color]::new([System.Drawing.Color]::OrangeRed)
      $FilterColor.style = [Styles]::Underline
      $filtertext = $FilterColor.render("$($this.filter)")
    } else {
      $FilterColor = [Color]::new([System.Drawing.Color]::Green)
      $FilterColor.style = [Styles]::Underline
      $filtertext = $FilterColor.render("None")
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

  [String] MakeBufer(
    [System.Collections.Generic.List[ListItem]]$items
  ) {
    $i = 0
    $buffer = $items | ForEach-Object {
      $text = $_.text.PadRight($this.linelen," ")
      $add = $true
      if ($add) {
        if ($_.checked) {
          $text = "▣ $text"
        }
        else {
          $text = "▢ $text"
        }
        if ($this.index -eq $i) {
          $this.SelectedColor.render("$($this.selector) $($text)")
        }
        else {
          "  $($text)"
        }
      }
      $i++
    } | Out-String
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
    # $this.linelen = ($this.items | select-object -ExpandProperty text | Measure-Object -Property Length, {($_ -replace "\e\[[\d;]*m", '')} -Maximum).Maximum
    $this.linelen = ($this.items | Measure-Object -Maximum {
      ($_.text).Length
    }).Maximum
    # $this.linelen = ($this.items | Measure-Object -Maximum {
    #   ($_.text -replace "\e\[[\d;]*m", '').Length
    # }).Maximum
    [System.Console]::Clear()
    # TODO: Gérer les couleurs à partir du thème
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
              $_.text -match $this.filter
            } | Select-Object -Skip (($this.page - 1) * $this.height) -First $this.height
            $redraw = $true
          }
          8 {
            if ($this.filter.Length -gt 0) {
              $this.filter = $this.filter.Substring(0, $this.filter.Length - 1)
              $VisibleItems = $this.items | Where-Object {
                $_.text -match $this.filter
              } | Select-Object -Skip (($this.page - 1) * $this.height) -First $this.height
              $redraw = $true
            }
          }
          38 {
            if ($this.index -gt 0) {
              $this.index--
              $redraw = $true
            }
          }
          40 {
            if ($this.index -lt ($VisibleItems.Count - 1)) {
              $this.index++
              $redraw = $true
            }
          }
          191 {
            if ($key.ControlKeyState -eq "ShiftPressed") {
              $search = $true
              $redraw = $true
              # TODO: Ajouter une recherche incrémentale SANS zone de saisie
            }
          }
          37 {
            if ($this.page -gt 1) {
              $this.page--
              $redraw = $true
              [System.Collections.Generic.List[ListItem]]$VisibleItems = $this.items | Select-Object -Skip (($this.page - 1) * $this.height) -First $this.height
            }
          }
          39 {
            if ($this.page -lt $this.pages) {
              $this.page++
              $redraw = $true
              [System.Collections.Generic.List[ListItem]]$VisibleItems = $this.items | Select-Object -Skip (($this.page - 1) * $this.height) -First $this.height
            }
          }
          9 {
            $VisibleItems[$this.index].checked = -not $VisibleItems[$this.index].checked
            $redraw = $true
          }
          13 {
            $stop = $true

            $VisibleItems | ForEach-Object {
              if ($_.checked) {
                $result += $_
              }
            }
          }
          27 {
            $stop = $true
          }
        }
        # [console]::Clear()
      }
    }
    [console]::CursorVisible = $true
    [Console]::Clear()
    return $result | Select-Object -Property text, value
  }

}