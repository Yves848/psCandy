using module ..\..\Classes\psCandy.psm1
# . .\themes.ps1

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 
$Word1 = [Style]::New("Pick")
$word1.width = 4
$Word1.SetColor([System.Drawing.Color]::Green)
$Word2 = [Style]::New("A")
$Word2.width = 1
$Word2.SetColor([System.Drawing.Color]::Blue)
$Word3 = [Style]::New("Color")
$Word3.width = 5
$Word3.SetColor([System.Drawing.Color]::Red)
$line = @($Word1.Render(),$Word2.Render(),$Word3.Render()) -join " "
$Title = [Style]::New("👌🏻 $($Line)")
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