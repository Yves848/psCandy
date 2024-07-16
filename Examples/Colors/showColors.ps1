using module psCandy 
. "$PSScriptRoot\themes.ps1"

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 
[console]::Clear()
Write-Candy "🎨 <Green>Pick</Green> <Blue>A</Blue> <Red>Color</Red>" -width ($global:Host.UI.RawUI.BufferSize.Width - 2) -border "Rounded" -Align Center
[System.Console]::SetCursorPosition(0, 3)

$items = [System.Collections.Generic.List[ListItem]]::new()
[Colors] | Get-Member -Static | Where-Object { $_.Definition -match 'candyColor' } | ForEach-Object { 
  $methodInfo = [colors].GetMethod($_.Name, [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::Public) 
  [candyColor]$candycolor = $methodinfo.Invoke($null, $null)
  $colorName = $_.Name
  [Color]$color = [Color]::new($candycolor)
  $items.Add([ListItem]::new($colorName, $color, $candyColor))
}
$List = [List]::new($items)
$List.LoadTheme($Theme)
$list.SetHeight(15)
$List.Display()
