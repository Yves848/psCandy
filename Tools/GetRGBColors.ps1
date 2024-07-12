using module psCandy
. .\themes.ps1

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 
[console]::Clear()

[system.Drawing.color] | Get-Member -Static -MemberType Properties | ForEach-Object {
  
  $color = [System.Drawing.Color]::"$($_.Name)"
  $template = @"
  static [candyColor] $($color.Name) () {
    return @{R = $($color.R)
    G = $($color.G)
    B = $($color.B)}
  }
"@
  $template
} | Out-File .\test.ps1
