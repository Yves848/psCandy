# . "$PSScriptRoot\Themes.ps1" -Force
. "$PSScriptRoot\PSCandy.ps1" -Force

$Style = [Style]::new("ShowStyle")
# $Style.SetStyle([Styles]::Underline)
$Style.SetBorder($true)
$Style.SetColor([System.Drawing.Color]::White, [System.Drawing.Color]::DarkBlue)
$Style.setAlign([Align]::Left)
$Style.Render()
$Style.setAlign([Align]::Center)
$Style.Render()
# $Style.SetWidth(50)
$Style.setAlign([Align]::Right)
$Style.Render()