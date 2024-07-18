using module C:\Users\yvesg\git\psCandy\Classes\psCandy.psm1

$c = Build-Candy -text "<Green>Couple</Green> Papa  [White]<Red>Coucou</Red>[/White] Courage Prout"
$c 
$s = "Co"

$esc = [regex]::Replace($c, '\e', '#') -split "#"
$esc = $esc -split "#"

$esc
Write-Host ("-" * 20  )

$result = $esc | ForEach-Object {
  if ([regex]::IsMatch($_, $s)) {
    $currentIndex = 0
    $color = [Regex]::Match($_, "\[38[\d;]*m")
    $matches = [regex]::Matches($_, $s)
    $buffer = ""
    foreach ($match in $matches) {
      if ($match.Index -gt $currentIndex) {
        $buffer = [string]::concat($buffer, $_.Substring($currentIndex, $match.Index - $currentIndex))
      }
      $col = [Color]::new([Colors]::RoyalBlue(), [Colors]::White())
      $innerText = $col.ApplyColor(($match.Groups[0].Value))
      if ($color.Success) {
        $innerText = [string]::concat($innerText,"$([char]0x1b)$($color.Value)")
      } else {
        $innerText = [string]::concat($innerText,"$([char]0x1b)[39m")
      }
      $buffer = [string]::concat($buffer, $innerText)
      $currentIndex = $match.Index + $match.Length
    }
  
    if ($currentIndex -lt $_.Length) {
      $buffer = [string]::concat($buffer, $_.Substring($currentIndex))
    }
    $buffer
  }
  else {
    $_
  }
}

$result -join $([char]0x1b)