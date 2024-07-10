# $VerbosePreference = 'Continue'
Import-Module "$((Get-Location).Path)\classes.ps1" -Force



# [system.Drawing.color] | Get-Member -Static -MemberType Properties | ForEach-Object {
#   $color = [color]::new([System.Drawing.Color]::"$($_.Name)")
#   write-host "This $($color.render("$($_.Name)",0)) a test of the color function"
# }

# [$spinner = [Spinner]::new("Dots")
# $spinner.SetColor([System.Drawing.Color]::Red)
# $Spinner.Start("Spinner Test")
# Start-Sleep -Seconds 1
# $Spinner.Stop()

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 
$items = [System.Collections.Generic.List[ListItem]]::new()
$items.Add([ListItem]::new("🍌 Banana", 1))
$items.Add([ListItem]::new("🍎 Apple", 2))
$items.Add([ListItem]::new("🍊 Mandarine", 3))
$items.Add([ListItem]::new("🟠 Grape Fruit", 4))
$items.Add([ListItem]::new("🥔 Potato", 5))
$items.Add([ListItem]::new("🥔 Potato 2", 6))
$items.Add([ListItem]::new("🥔 Potato 3", 7))
$items.Add([ListItem]::new("🥔 Potato 4", 8))
$items.Add([ListItem]::new("🥔 Potato 5", 9))
$items.Add([ListItem]::new("🍌 Banana 2", 10))
$items.Add([ListItem]::new("🍎 Apple 2", 11))
$items.Add([ListItem]::new("🍊 Mandarine 2", 12))
$items.Add([ListItem]::new("🟠 Grape Fruit 2", 13))
$items.Add([ListItem]::new("🥔 Potato 6", 14))

$list = [List]::new($items)  
$list.Display()

Remove-Module -name classes -Force
# $top = 0
# $left = 0
# $width = $Host.UI.RawUI.BufferSize.Width
# $height = $Host.UI.RawUI.BufferSize.Height
# [System.Management.Automation.Host.Rectangle]$rect = [System.Management.Automation.Host.Rectangle]::new(0,0,$Host.UI.RawUI.BufferSize.Width,$Host.UI.RawUI.BufferSize.Height)
# [System.Management.Automation.Host.BufferCell[,]]$buffer = $Host.UI.RawUI.GetBufferContents($rect)
# Start-Sleep -Seconds 2
# Clear-Host
# Start-Sleep -Seconds 2
# # Restaurer le contenu capturé
# $Destination = New-Object System.Management.Automation.Host.Coordinates 0, 0
# $cell = [System.Management.Automation.Host.BufferCell]::new("C","White","Red","Complete")
# $buffer[10,1]=$cell
# $buffer[10,2]=$cell
# $buffer[10,3]=$cell
# $buffer[10,10].ForegroundColor = [System.ConsoleColor]::Red
# $Host.UI.RawUI.SetBufferContents($Destination,$buffer)