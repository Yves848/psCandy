# Define the URL of the font file you want to download
$fontUrl = "https://example.com/path/to/yourfontfile.ttf"

# Define the path where you want to save the downloaded font
$savePath = "C:\Windows\Fonts\yourfontfile.ttf"

# Download the font file from the URL
Invoke-WebRequest -Uri $fontUrl -OutFile $savePath

# Check if the file already exists in the fonts directory (to avoid duplicates)
if (-Not (Test-Path "C:\Windows\Fonts\yourfontfile.ttf")) {
    # Move the downloaded font to the Windows Fonts directory
    Copy-Item -Path $savePath -Destination "C:\Windows\Fonts\"
} else {
    Write-Output "The font file already exists in the Fonts directory."
}
