using module ..\..\Classes\psCandy.psm1
. .\themes.ps1

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 
# [console]::Clear()
$Word1 = [Style]::New("Pick")
$word1.width = 4
$Word1.SetColor([Colors]::Green())
$Word2 = [Style]::New("A")
$Word2.width = 1
$Word2.SetColor([Colors]::Blue())
$Word3 = [Style]::New("Color")
$Word3.width = 5
$Word3.SetColor([Colors]::Red())

$line = @($Word1.Render(),$Word2.Render(),$Word3.Render()) -join " "

$Title = [Style]::New("👌🏻 $($Line)")
$Title.SetColor([Colors]::Green())
$Title.setAlign([Align]::Center)
$Title.SetBorder($true)
[Console]::WriteLine($Title.Render())

$items = [System.Collections.Generic.List[ListItem]]::new()
[Colors] | Get-Member -Static | Where-Object {$_.Definition -match 'candyColor'} | ForEach-Object { 
  $methodInfo = [colors].GetMethod($_.Name, [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::Public) 
  [candyColor]$candycolor = $methodinfo.Invoke($null,$null)
  $colorName = $_.Name
  [Color]$color = [Color]::new($candycolor)
  $items.Add([ListItem]::new($colorName, $color,$candyColor))
}
$List = [List]::new($items)
$List.LoadTheme($Theme)
$list.SetHeight(15)
$List.Display()
