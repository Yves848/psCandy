using module psCandy

[Border]::GetBorderTypes() | ForEach-Object {
  Write-Candy " A Border <Yellow>$($_)</Yellow> test" -Border $_ -Width 80
}