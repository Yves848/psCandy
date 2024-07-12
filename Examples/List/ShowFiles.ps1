using module psCandy

param (
  [string]$Path = "..\"
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 
[Console]::Clear()
function getDirContent {
  param(
    [string]$path
  )
  $items = [System.Collections.Generic.List[ListItem]]::new()
  $items.Add([ListItem]::new("..", $path,[Colors]::White()))
  Get-ChildItem -Path $path -File  | ForEach-Object {
    $Name = $_.Name
    $items.Add([ListItem]::new($Name, $_,"📄",[Colors]::Green()))
  }
  Get-ChildItem -Path $path -Directory  | ForEach-Object {
    $Name = $_.Name
    $items.Add([ListItem]::new($Name,$_, "📂", [Colors]::OrangeRed()))
  }
  return $items
}

$items = getDirContent -path $Path
$result = $null
if ($theme) {
  $Theme.list.SelectedColor = [Colors]::yellow()
}
while ($true) {
  $List = [List]::new($items)
  $list.SetHeight(15)
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