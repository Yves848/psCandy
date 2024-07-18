using module C:\Users\yvesg\git\psCandy\Classes\psCandy.psm1

[Border]::GetBorderTypes() | ForEach-Object {
  Write-Candy " A Border <Yellow>$($_)</Yellow> test" -Border $_ -Width 80
}