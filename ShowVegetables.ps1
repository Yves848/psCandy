Import-Module "$((Get-Location).Path)\classes.ps1" -Force

$spinner = [Spinner]::new("Dots")
$Spinner.Start("Loading List...")
Start-Sleep -Seconds 5
$Spinner.Stop()

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 
$items = [System.Collections.Generic.List[ListItem]]::new()
$items.Add([ListItem]::new("Banana", 1,"🍌"))
$items.Add([ListItem]::new("Apple", 2, "🍎"))
$items.Add([ListItem]::new("Mandarine", 3, "🍊"))
$items.Add([ListItem]::new("Grape Fruit", 4, "🟠"))
$items.Add([ListItem]::new("Potato", 5,"🥔"))
$items.Add([ListItem]::new("Potato 2", 6,"🥔"))
$items.Add([ListItem]::new("Potato 3", 7,"🥔"))
$items.Add([ListItem]::new("Potato 4", 8,"🥔"))
$items.Add([ListItem]::new("Potato 5", 9,"🥔"))
$items.Add([ListItem]::new("Banana 2", 10,"🍌"))
$items.Add([ListItem]::new("Apple 2", 11,"🍎"))
$items.Add([ListItem]::new("Mandarine 2", 12,"🍊"))
$items.Add([ListItem]::new("Grape Fruit 2", 13,"🟠"))
$items.Add([ListItem]::new("Potato 6", 14,"🥔"))

$list = [List]::new($items)  
$list.Display()

Remove-Module -name classes -Force