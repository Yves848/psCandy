using module ..\..\Classes\psCandy.psm1

param (
    [string]$Path = "\git\psCandy\readme.md"
)

$Pager = [Pager]::New($path)
$Pager.Display()