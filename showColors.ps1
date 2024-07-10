# $VerbosePreference = 'Continue'
Import-Module "$((Get-Location).Path)\classes.ps1" -Force


[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 
$items = [System.Collections.Generic.List[ListItem]]::new()
[system.Drawing.color] | Get-Member -Static -MemberType Properties | ForEach-Object {
  
  [psCustomObject]$color = [color]::new([System.Drawing.Color]::"$($_.Name)")
  $colorName = $color.render($_.Name)
  $items.Add([ListItem]::new($colorName, $color))
}
$List = [List]::new($items)
$list.SetHeight(25)
$List.Display()