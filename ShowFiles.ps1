# $VerbosePreference = 'Continue'
param (
  [string]$Path = "..\"
)
Import-Module "$((Get-Location).Path)\classes.ps1" -Force


[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 

function getDirContent {
  param(
    [string]$path
  )
  $items = [System.Collections.Generic.List[ListItem]]::new()
  $items.Add([ListItem]::new("..", $path))
  Get-ChildItem -Path $path -File  | ForEach-Object {
    
    [psCustomObject]$color = [color]::new([System.Drawing.Color]::Green)
    $Name = $Color.render("📄 $($_.Name)")
    $items.Add([ListItem]::new($Name, $_))
  }
  Get-ChildItem -Path $path -Directory  | ForEach-Object {
    
    [psCustomObject]$color = [color]::new([System.Drawing.Color]::OrangeRed)
    $Name = $Color.render("📂 $($_.Name)")
    $items.Add([ListItem]::new($Name, $_))
  }
  return $items
}

$items = getDirContent -path $Path
$result = $null
while ($true) {
  $List = [List]::new($items)
  $list.SetHeight(25)
  $list.SetLimit($True)
  $choice = $List.Display()
  if ($choice) {
    if ($choice.text -eq "..") {
      $p = [System.IO.Path]::GetDirectoryName($choice.Value)
    }
    else {
      if (Test-Path -Path $choice.Value.FullName -Type Container) {
        if ($choice.chained) {
          $result = $choice.Value
          break
        } else {
          $p = $choice.Value.FullName
        }
      }
      else {
        $result = $choice.Value
        break
      }
    }
    $items = getDirContent -path $p
    $List.setItems($items)

  }
  else {
    break
  }
}
$result