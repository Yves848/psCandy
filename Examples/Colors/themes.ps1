using module ..\..\Classes\psCandy.psm1

$Theme = @{
  "list"= @{
    "SearchColor" = [Colors]::BlueViolet()
    "SelectedColor" = [Colors]::Yellow()
    "SelectedStyle" = [Styles]::Underline
    "FilterColor" = [Colors]::Orange()
    "NoFilterColor" = [Colors]::Orange()
    "FilterStyle" = [Styles]::Underline
    "Checked"="◉"
    "Unchecked"="○"
  }
  "spinner" = @{
    "spincolor"= [Colors]::MediumOrchid()
    "spinType"= "Dots"
  }
  "choice" = @{
    "SelectedForeground" = [Colors]::BlueViolet()
    "SelectedBackground" = [Colors]::White()
    "OptionColor" = [Colors]::SkyBlue()
    "MessageColor" = [Colors]::IndianRed()
  }
}