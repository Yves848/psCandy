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

$text = Build-Candy "Test of a simple Build-Candy output"

output-string $text

$text = Build-Candy "Test of a <75>simple</75> Build-Candy output"

output-string $text

$text = Build-Candy "Test of a <75>simple</75> Build-Candy <U>output</U> 🌝"

output-string $text

$text = Build-Candy "Test of a <75>simple</75> Build-Candy <U>output</U> 🌝" -fullscreen

output-string $text

$text = Build-Candy "Test of a <75>simple</75> Build-Candy <U>output</U> 🌝" -fullscreen -border "Rounded"

output-string $text

$text = Build-Candy "Test of a <75>simple</75> Build-Candy <U>output</U> 🌝" -fullscreen -border "Rounded" -Align Center

output-string $text
