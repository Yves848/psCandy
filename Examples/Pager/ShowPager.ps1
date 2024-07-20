using module psCandy

param (
    [string]$Path = "~\git\psCandy\readme.md"
)

$Pager = [Pager]::New($path)
$Pager.Display()