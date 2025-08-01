# Mapping ANSI couleurs
$fgColors = @{
    'black'   = 30;  'red'     = 31;  'green'   = 32;  'yellow'  = 33
    'blue'    = 34;  'magenta' = 35;  'cyan'    = 36;  'white'   = 37
    'default' = 39
}
$bgColors = @{
    'black'   = 40;  'red'     = 41;  'green'   = 42;  'yellow'  = 43
    'blue'    = 44;  'magenta' = 45;  'cyan'    = 46;  'white'   = 47
    'default' = 49
}
$ansiTags = @{
    'italic'    = @("`e[3m", "`e[23m")
    'underline' = @("`e[4m", "`e[24m")
    # Rajoute autres styles si besoin
}

function Convert-CustomTagsToANSI {
    param([string]$text)

    $pattern = "<(?<tag>[a-z]+)(?:/(?<bg>[a-z]+))?>|</(?<resetbg>[a-z]+)>|</>"
    $output = [System.Text.StringBuilder]::new()
    $pos = 0
    $stack = [System.Collections.Stack]::new()

    foreach ($match in [regex]::Matches($text, $pattern)) {
        $start = $match.Index
        $length = $match.Length

        # Ajoute le texte normal
        if ($start -gt $pos) {
            $null = $output.Append($text.Substring($pos, $start - $pos))
        }

        if ($match.Groups['resetbg'].Success) {
            # Balise de reset background: </yellow>
            $stack.Push(@{bg=$match.Groups['resetbg'].Value})
            $null = $output.Append("`e[49m")
        }
        elseif ($match.Value -eq "</>") {
            # Ferme le dernier style/couleur
            if ($stack.Count -gt 0) {
                $current = $stack.Pop()
                if ($current -is [hashtable]) {
                    if ($current.ContainsKey('fg')) { $null = $output.Append("`e[39m") }
                    if ($current.ContainsKey('bg')) { $null = $output.Append("`e[49m") }
                } else {
                    $null = $output.Append($ansiTags[$current][1])
                }
            }
        }
        elseif ($match.Groups['tag'].Success) {
            $fg = $match.Groups['tag'].Value
            $bg = $match.Groups['bg'].Value

            if ($ansiTags.ContainsKey($fg)) {
                $stack.Push($fg)
                $null = $output.Append($ansiTags[$fg][0])
            }
            elseif ($fgColors.ContainsKey($fg) -and $bg) {
                # <fg/bg>
                if ($bgColors.ContainsKey($bg)) {
                    $stack.Push(@{fg=$fg;bg=$bg})
                    $null = $output.Append("`e[$($fgColors[$fg])m`e[$($bgColors[$bg])m")
                } else {
                    $null = $output.Append($match.Value)
                }
            }
            elseif ($fgColors.ContainsKey($fg)) {
                # <fg>
                $stack.Push(@{fg=$fg})
                $null = $output.Append("`e[$($fgColors[$fg])m")
            }
            else {
                $null = $output.Append($match.Value)
            }
        }
        $pos = $start + $length
    }

    # Ajoute le texte restant
    if ($pos -lt $text.Length) {
        $null = $output.Append($text.Substring($pos))
    }

    # Reset tous les styles restants
    while ($stack.Count -gt 0) {
        $current = $stack.Pop()
        if ($current -is [hashtable]) {
            if ($current.ContainsKey('fg')) { $null = $output.Append("`e[39m") }
            if ($current.ContainsKey('bg')) { $null = $output.Append("`e[49m") }
        } else {
            $null = $output.Append($ansiTags[$current][1])
        }
    }

    return $output.ToString()
}

# Exemples d'utilisation
$test1 = "<black/white>noir sur blanc <italic> italique </> normal </>"
$test2 = "<yellow>jaune <black/white>noir/blanc </> jaune </>"
$test3 = "<yellow/blue>fg jaune, bg bleu</> normal"
$test4 = "<yellow>jaune </yellow> normal" # reset du bg uniquement

Write-Host (Convert-CustomTagsToANSI $test1)
Write-Host (Convert-CustomTagsToANSI $test2)
Write-Host (Convert-CustomTagsToANSI $test3)
Write-Host (Convert-CustomTagsToANSI $test4)