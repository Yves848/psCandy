using module ..\..\Classes\psCandy.psm1

param (
    [string]$Path = "d:\git\psCandy\readme.md"
)

$Pager = [Pager]::New($path)
$Pager.Display()