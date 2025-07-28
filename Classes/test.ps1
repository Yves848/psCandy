# Mapping balises -> [ouverture, fermeture]
$ansiMap = @{
    "Black/White" = @("`e[38;5;0;48;5;15m", "`e[39m")
    "Underline"   = @("`e[4m", "`e[24m")
    "Bold"        = @("`e[1m", "`e[22m")
    # Ajoute d'autres balises si tu veux
}

function Convert-BalisesToANSI([string]$text) {
    $pattern      = '\<([\w]*\/?[\w]*)\>'    # <Balise>
    $closePattern = '</>'            # balise fermante courte

    $output = ""
    $stack  = @()   # pile de balises ouvertes (stocke la clé, ex: "Bold")

    $i = 0
    while ($i -lt $text.Length) {
        # Balise ouvrante <Balise>
        if ($text.Substring($i) -match "^$pattern") {
            $balise = $matches[1]
            if ($ansiMap.ContainsKey($balise)) {
                $output += $ansiMap[$balise][0]   # code ouverture
                $stack += $balise                 # push
            }
            $i += $balise.Length + 2  # < et >
            continue
        }
        # Balise fermante </>
        elseif ($text.Substring($i) -match "^$closePattern") {
            if ($stack.Count -gt 0) {
                $last = $stack[-1]
                $output += $ansiMap[$last][1]     # code fermeture
                $stack = $stack[0..($stack.Count-2)] # pop
            }
            $i += 3 # </>
            continue
        }
        else {
            $output += $text[$i]
            $i++
        }
    }
    # En fin de chaîne, fermer tout proprement
    foreach ($b in [Array]::Reverse($stack)) {
        $output += $ansiMap[$b][1]
    }
    return $output
}

# TEST
$texte = "<Black/White><Underline>Test</> Normal</>"
Write-Host (Convert-BalisesToANSI $texte)