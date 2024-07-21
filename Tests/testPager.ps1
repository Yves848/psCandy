using module C:\Users\yvesg\git\psCandy\Classes\psCandy.psm1

param (
    [string]$Path = "~\git\psCandy\readme.md"
)

$Pager = [Pager]::New($path)
$Pager.actions.add(33, { 
  $Pager.index = $Pager.index - 8
  if ($Pager.index -lt 0) {
    $Pager.index = 0
  }
} )
$Pager.actions.add(34, { 
  $oldIndex = $Pager.index
  $Pager.index = $Pager.index + 8
  if ($Pager.index -ge ($Pager.height -1)) {
    $pager.offset = ($pager.offset + $pager.height)
    $Pager.index = $Pager.height - $oldIndex
  }
})

$Pager.Display()