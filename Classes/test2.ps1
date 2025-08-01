# Map tag → [on, off]
$ansiTags = @{
    'black'     = @("`e[30m",   "`e[39m")
    'yellow'    = @("`e[33m",   "`e[39m")
    'italic'    = @("`e[3m",    "`e[23m")
    'underline' = @("`e[4m",    "`e[24m")
    # Ajoute d'autres styles ici, [code_on, code_off]
}
$ansiReset = "`e[0m"

function Convert-CustomTagsToANSI {
    param([string]$text)

    $pattern = "<(?<tag>\w+)>|</>"
    $output = [System.Text.StringBuilder]::new()
    $pos = 0
    $stack = [System.Collections.Stack]::new()

    foreach ($match in [regex]::Matches($text, $pattern)) {
        $start = $match.Index
        $length = $match.Length

        # Ajoute le texte "normal"
        if ($start -gt $pos) {
            $null = $output.Append($text.Substring($pos, $start - $pos))
        }

        if ($match.Value -eq "</>") {
            # Ferme le dernier style
            if ($stack.Count -gt 0) {
                $current = $stack.Pop()
                # Désactive uniquement ce style
                $null = $output.Append($ansiTags[$current][1])
            }
        } else {
            $tag = $match.Groups['tag'].Value
            if ($ansiTags.ContainsKey($tag)) {
                $stack.Push($tag)
                $null = $output.Append($ansiTags[$tag][0])
            } else {
                $null = $output.Append($match.Value)
            }
        }

        $pos = $start + $length
    }

    # Ajoute ce qui reste après la dernière balise
    if ($pos -lt $text.Length) {
        $null = $output.Append($text.Substring($pos))
    }

    # Ferme tous les styles restants à la fin (pour être sûr)
    while ($stack.Count -gt 0) {
        $null = $output.Append($ansiTags[$stack.Pop()][1])
    }

    return $output.ToString()
}

# Exemple d'utilisation
$test = "<yellow>jaune <italic> italique <underline> italique souligné </> italique </></> Normal"
Write-Host (Convert-CustomTagsToANSI $test)