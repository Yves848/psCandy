using module psCandy

class _color {
    static [candyColor] tocolor([string]$color) {
        $methodInfo = [colors].GetMethod($color, [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::Public)
        if ($null -eq $methodInfo) {
            return [colors]::White()
        }
        return $methodinfo.Invoke($null, $null)
    }

    static [string] colorList() {
        $result = @()
        [Colors] | Get-Member -Static | Where-Object { $_.Definition -match 'candyColor' } | ForEach-Object { 
            $result += $_.Name
        }
        return $result -join "|"
    }
}

function Write-Candy {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Text
    )

    # Define a regex pattern to match color tags
    $colors = [_color]::colorList()
    $colorPattern = '<(?<color>' + $colors  + ')>(?<text>.*?)<\/\k<color>>'
    $StylePattern = '<(?<style>Underline|Strike)>(?<text>.*?)<\/\k<style>>'
    # Start with the original text
    $currentIndex = 0
    $matches = [regex]::Matches($Text, $colorPattern)
    $buffer = ""
    foreach ($match in $matches) {
        # Output text before the color tag
        if ($match.Index -gt $currentIndex) {
            # Write-Host -NoNewline -Object $Text.Substring($currentIndex, $match.Index - $currentIndex)
            $buffer = [string]::concat($buffer, $Text.Substring($currentIndex, $match.Index - $currentIndex))
        }
        
        # Output the colored text
        $color = $match.Groups['color'].Value
        $col = [Color]::new([_color]::tocolor($color))
        $innerText = $col.render(($match.Groups['text'].Value))
        # Write-Host -NoNewline -Object $innerText -ForegroundColor $color
        $buffer = [string]::concat($buffer, $innerText)
        
        # Update the current index
        $currentIndex = $match.Index + $match.Length
    }
    
    # Output any remaining text after the last color tag
    if ($currentIndex -lt $Text.Length) {
        # Write-Host -NoNewline -Object $Text.Substring($currentIndex)
        $buffer = [string]::concat($buffer, $Text.Substring($currentIndex))
    }

    $currentIndex = 0
    $matches = [regex]::Matches($buffer, $StylePattern)
    [Color] $style = [Color]::new($null)
    $buffer2 = ""
    foreach ($match in $matches) {
        # Output text before the color tag
        if ($match.Index -gt $currentIndex) {
            # Write-Host -NoNewline -Object $Text.Substring($currentIndex, $match.Index - $currentIndex)
            $buffer2 = [string]::concat($buffer2, $buffer.Substring($currentIndex, $match.Index - $currentIndex))
        }
        
        # Output the colored text
        $color = $match.Groups['style'].Value
        $style.style = $color
        $innerText = $style.render(($match.Groups['text'].Value))
        # Write-Host -NoNewline -Object $innerText -ForegroundColor $color
        $buffer2 = [string]::concat($buffer2, $innerText)
        
        # Update the current index
        $currentIndex = $match.Index + $match.Length
    }
    
    # Output any remaining text after the last color tag
    if ($currentIndex -lt $Text.Length) {
        # Write-Host -NoNewline -Object $Text.Substring($currentIndex)
        $buffer2 = [string]::concat($buffer2, $buffer.Substring($currentIndex))
    }

    # Ensure we end with a newline
    Write-Host $buffer2
}

# Example usage
# Write-Candy -Text "This <Underline>is</Underline> <Strike><Red>red</Red></Strike> and this is <Green>green</Green>."
Write-Candy -Text "<Yellow>Warning</Yellow>: This is a <Blue>blue</Blue> message."

# get-service -ErrorAction SilentlyContinue | ForEach-Object {
#     Write-Candy -text "$($_.Status -eq "Running" ? "<Green>Running</Green>" : "<Red>Stopped</Red>") - <Underline>$($_.DisplayName)</Underline>"
# }
