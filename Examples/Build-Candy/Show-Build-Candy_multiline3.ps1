import-module psCandy

$buffer = @"
<3>One line</3>
Two Line
<U>Three Line</U>
"@

$text = $buffer -split "`n" | % {
  "`n" + (Build-Candy $_ -width 60)
}

Write-Candy $text.ToString() -Width 60 -border "Rounded"