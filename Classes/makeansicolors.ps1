$ansiBaseNames = @(
    'black','red','green','yellow','blue','magenta','cyan','white',
    'bright-black','bright-red','bright-green','bright-yellow','bright-blue','bright-magenta','bright-cyan','bright-white'
)
$tailwindShades = @(50,100,200,300,400,500,600,700,800,900)

# Helper pour assigner la "famille"
function Get-Family($r,$g,$b) {
    if ($r -eq $g -and $g -eq $b) { return 'gray' }
    $max = [math]::Max($r, [math]::Max($g, $b))
    switch ($max) {
        {$_ -eq $r -and $r -ge $g -and $r -ge $b} { return 'red' }
        {$_ -eq $g -and $g -ge $r -and $g -ge $b} { return 'green' }
        {$_ -eq $b -and $b -ge $r -and $b -ge $g} { return 'blue' }
    }
    return 'unknown'
}

# Helper pour l'intensité/nuance
function Get-Shade($r,$g,$b) {
    $max = [math]::Max($r, [math]::Max($g, $b))
    return $tailwindShades[[math]::Min([math]::Max([math]::Round($max * (9/5)), 0), 9)]
}

# Générer le RGB hex
function Get-ANSIColorRGB($code) {
    if ($code -lt 16) {
        $ansiRGB = @(
            '#000000', '#800000', '#008000', '#808000',
            '#000080', '#800080', '#008080', '#c0c0c0',
            '#808080', '#ff0000', '#00ff00', '#ffff00',
            '#0000ff', '#ff00ff', '#00ffff', '#ffffff'
        )
        return $ansiRGB[$code]
    } elseif ($code -ge 16 -and $code -le 231) {
        $n = $code - 16
        $r = [math]::Floor($n / 36)
        $g = [math]::Floor(($n % 36) / 6)
        $b = $n % 6
        $toHex = { param($c) $v = 55 + 40 * $c; if ($c -eq 0) { $v = 0 }; '{0:x2}' -f [int]$v }
        return "#$(& $toHex $r)$(& $toHex $g)$(& $toHex $b)"
    } else {
        $l = 8 + 10 * ($code - 232)
        '{0}' -f ("#{0:x2}{0:x2}{0:x2}" -f $l)
    }
}

# Générer le mapping unique "famille-shade-index"
$ansiColors = @{}
$indexTable = @{}  # Pour chaque famille+shade, un index séquentiel
for ($i = 0; $i -lt 256; $i++) {
    if ($i -lt 16) {
        $name = $ansiBaseNames[$i]
    } elseif ($i -ge 16 -and $i -le 231) {
        $n = $i - 16
        $r = [math]::Floor($n / 36)
        $g = [math]::Floor(($n % 36) / 6)
        $b = $n % 6
        $fam = Get-Family $r $g $b
        $shade = Get-Shade $r $g $b
        $key = "$fam-$shade"
        if (-not $indexTable.ContainsKey($key)) { $indexTable[$key] = 0 }
        $idx = $indexTable[$key]
        $indexTable[$key]++
        $name = "$fam-$shade-$idx"
    } else {
        # gris 232–255
        $idx = $i - 232
        $shade = $tailwindShades[[math]::Min([math]::Max([math]::Round(($i-232)*(9/23)),0),9)]
        $name = "gray-$shade-$idx"
    }
    $ansiColors[$name] = @{
        ansi = $i
        rgb  = Get-ANSIColorRGB $i
    }
}

# Export en JSON
$ansiColors | ConvertTo-Json -Depth 3 | Set-Content -Encoding UTF8 "ansi256.json"