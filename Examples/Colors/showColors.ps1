using module ..\..\Classes\psCandy.psm1
# . .\themes.ps1

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 

$Title = [Style]::New("Pick colors")
$Title.SetColor([System.Drawing.Color]::Green)
$Title.setAlign([Align]::Center)
$Title.SetBorder($true)
[Console]::WriteLine($Title.Render())
$items = [System.Collections.Generic.List[ListItem]]::new()
[system.Drawing.color] | Get-Member -Static -MemberType Properties | ForEach-Object {
  
  [psCustomObject]$color = [color]::new([System.Drawing.Color]::"$($_.Name)")
  $colorName = $_.Name
  $items.Add([ListItem]::new($colorName, $color,[System.Drawing.Color]::"$($_.Name)"))
}
$List = [List]::new($items)
$List.LoadTheme($Theme)
$list.SetHeight(15)
$List.Display()