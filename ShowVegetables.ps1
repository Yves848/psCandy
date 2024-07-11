using module psCandy
. .\themes.ps1

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 
$items = [System.Collections.Generic.List[ListItem]]::new()
$items.Add([ListItem]::new("Banana", 1,"🍌"))
$items.Add([ListItem]::new("Apple", 2, "🍎"))
$items.Add([ListItem]::new("Mandarine", 3, "🍊"))
$items.Add([ListItem]::new("Grape Fruit", 4, "🟠"))
$items.Add([ListItem]::new("Grape Fruit(too)", @{"aString"="Test"; "aBool"=$true}, "🟠"))
$items.Add([ListItem]::new("Potato", 5,"🥔"))
$items.Add([ListItem]::new("Potato 2", 6,"🥔"))
$items.Add([ListItem]::new("Potato 3", 7,"🥔"))
$items.Add([ListItem]::new("Potato 4",8,"🥔"))
$items.Add([ListItem]::new("Potato 5", 9,"🥔"))
$items.Add([ListItem]::new("Banana 2", 10,"🍌"))
$items.Add([ListItem]::new("Apple 2", 11,"🍎"))
$items.Add([ListItem]::new("Mandarine 2", 12,"🍊"))
$items.Add([ListItem]::new("Grape Fruit 2", 13,"🟠"))
$items.Add([ListItem]::new("Potato 6", 14,"🥔"))

$list = [List]::new($items)  
$list.LoadTheme($Theme)
$list.SetHeight(10)
# $list.SetLimit($True)
$list.Display()
