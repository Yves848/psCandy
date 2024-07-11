using module .\Release\psCandy.psm1

$Theme = @{
  "list"= @{
    "SearchColor" = [System.Drawing.Color]::BlueViolet
    "SelectedColor" = [System.Drawing.Color]::Yellow
    "SelectedStyle" = [Styles]::Underline
    "FilterColor" = [System.Drawing.Color]::Orange
    "FilterStyle" = [Styles]::Underline
    "Checked"="◉"
    "Unchecked"="○"
  }
  "spinner" = @{
    "spincolor"= [System.Drawing.Color]::MediumOrchid
    "spinType"= "Dots"
  }
  "choice" = @{
    "SelectedForeground" = [System.Drawing.Color]::BlueViolet
    "SelectedBackground" = [System.Drawing.Color]::White
    "OptionColor" = [System.Drawing.Color]::SkyBlue
    "MessageColor" = [System.Drawing.Color]::IndianRed
  }
}