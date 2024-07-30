using module C:\Users\yvesg\git\psCandy\Classes\psCandy.psm1

param (
    [string]$Path = "C:\Users\yvesg\git\psCandy\readme.md"
)

$Pager = [Pager]::New($path)
$Pager.actions.add(33, { 
  $Pager.index = $Pager.index - 8
  if ($Pager.index -lt 0) {
    $pager.offset = ($pager.offset - $pager.height)
    if ($pager.offset -lt 0) {
      $pager.offset = 0
    }
    $Pager.index = $Pager.height - $oldIndex
  }
} )

$Pager.actions.add(34, { 
  $oldIndex = $Pager.index
  $Pager.index = $Pager.index + 8
  if ($Pager.index -ge ($Pager.height -1)) {
    $pager.offset = ($pager.offset + $pager.height)
    if ($pager.offset -ge $pager.buffer.Length) {
      $pager.offset = $pager.buffer.Length - $pager.height
    }
    $Pager.index = $Pager.height - $oldIndex
  }
})

$Pager.Display()