. "$((Get-Location).Path)\constants.ps1"

[Flags()] enum Styles {
  Normal = 1
  Underline = 2
  Bold = 4
  Reversed = 8
  Strike = 16
}

$Script:Theme = @{
  "list"= @{
    "SearchColor" = [System.Drawing.Color]::BlueViolet
    "SelectedColor" = [System.Drawing.Color]::BlueViolet
    "SelectedStyle" = [Styles]::Underline
    "FilterColor" = [System.Drawing.Color]::Orange
    "FilterStyle" = [Styles]::Underline
  }
  "spinner" = @{
    "spincolor"= [System.Drawing.Color]::MediumOrchid
  }
}