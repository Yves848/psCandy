using module C:\Users\yvesg\git\psCandy\Classes\psCandy.psm1

param (
    [string]$Path = "~\git\psCandy\readme.md"
)

$Pager = [Pager]::New($path)
$Pager.actions.add(33, { $Pager.index = $Pager.index - 8} )
$Pager.actions.add(34, { $Pager.index = $Pager.index + 8 })

$Pager.Display()