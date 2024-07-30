import-module psCandy

function output-string {
    param(
        [string]$text
    )
    Write-Host 
    Write-Host $text
    Write-Host
}

[console]::Clear()
[console]::OutputEncoding = [System.Text.Encoding]::UTF8

$text = Build-Candy "Test of a simple Build-Candy output`nOn two lines"

output-string $text

$text = Build-Candy "Test of a <75>simple</75> Build-Candy output`n<Red>On two lines</Red>" 

output-string $text

$text = Build-Candy "Test of a <75>simple</75> Build-Candy <U>output</U> 🌝`nOn <R>two</R> <U>lines</U>" -Align Center -fullscreen

output-string $text

$buffer = "Test of a <75>simple</75> Build-Candy <U>output</U> 🌝`nOn <R>two</R> <U>lines</U>"
$format = @{
    Border = "Thick"
    Align = "Center"
    fullscreen = $true
}
$text = Build-Candy $buffer @format

output-string $text