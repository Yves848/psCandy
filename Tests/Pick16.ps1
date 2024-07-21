using module C:\Users\yvesg\git\psCandy\Classes\psCandy.psm1

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[console]::Clear()
[Console]::CursorVisible = $false
Write-Candy -Text "Pick a color <Green>(8bits)</Green>" -fullscreen -Border "Rounded" -Align Center
$y = $host.UI.RawUI.CursorPosition.Y
$Cell = ">000<" # Lenght 5

$w = $host.UI.RawUI.WindowSize.Width - 2
$CellsperRows = [math]::Floor($w / ($Cell.Length))
$index = 0
$backmode = $false
$back = -1
while ($true) {
  [console]::SetCursorPosition(0, $y)
  $Color = 0
 
  
  $buffer = ""
  while ($Color -lt 256) {
    $clsString = $color.ToString().PadLeft(3, " ")
    if ($index -eq $color) {
      $clsString = "<R>" + $clsString + "</R>"
    }
    
    $clsString = " " + $clsString + " "
    $buffer += [Color]::Applycolor16($clsString, $color, $back)
    if (($color + 1) % $CellsperRows -eq 0) {
      $buffer += "`n"
    }
    $Color++
  }
  Write-Candy $buffer
  if ($back -ne -1) {
    Write-Candy -text "Color is <$($index)>[$($back)]$index[/$($back)]</$($index)> " -fullscreen -Border "Rounded"
  }
  else {
    Write-Candy -text "Color is <$($index)>$index</$($index)> " -fullscreen -Border "Rounded"
  }
  
  if ($global:Host.UI.RawUI.KeyAvailable) {
    [System.Management.Automation.Host.KeyInfo]$key = $($global:host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'))
    if ($key.VirtualKeyCode -eq 39) {
      $index++
      if ($index -gt 255) {
        $index = 0
      }
    }
    if ($key.VirtualKeyCode -eq 37) {
      $index--
      if ($index -lt 0) {
        $index = 255
      }
    } 
    if ($key.VirtualKeyCode -eq 40) {
      $index += $CellsperRows
      if ($index -gt 255) {
        $index = 0
      }
    }
    if ($key.VirtualKeyCode -eq 38) {
      $index-= $CellsperRows
      if ($index -lt 0) {
        $index = 255
      }
    } 
    if ($key.VirtualKeyCode -eq 66) {
      if ($back -eq -1) {
        $back = $index
      } else {
        $back = -1
      }
      
    }
    
    if ($key.VirtualKeyCode -eq 13) {
      break
    }
    if ($key.VirtualKeyCode -eq 27) {
      break
    }
    if ($key.VirtualKeyCode -eq 32) {
      $index = 0
    }
  }
}
[console]::CursorVisible = $true