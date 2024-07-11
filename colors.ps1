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
