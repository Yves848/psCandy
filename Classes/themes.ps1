using module psCandy  

$Theme = @{
  "list"= @{
    "SearchColor" = [candyColor]::BlueViolet()
    "SelectedColor" = [candyColor]::Yellow()
    "SelectedStyle" = [Styles]::Underline
    "FilterColor" = [candyColor]::Orange()
    "NoFilterColor" = [candyColor]::Orange()
    "FilterStyle" = [Styles]::Underline
    "Checked"="◉"
    "Unchecked"="○"
  }
  "spinner" = @{
    "spincolor"= [candyColor]::MediumOrchid()
    "spinType"= "Dots"
  }
  "choice" = @{
    "SelectedForeground" = [candyColor]::BlueViolet()
    "SelectedBackground" = [candyColor]::White()
    "OptionColor" = [candyColor]::SkyBlue()
    "MessageColor" = [candyColor]::IndianRed()
  }
}