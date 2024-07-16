. "$PSScriptRoot\Import.ps1"

Write-Candy "Test"
Write-Candy "<Red>Hello</Red> 🌍 World!" -width ($Host.UI.RawUI.BufferSize.Width) -Align Center 
Write-Candy "<Green><Bold>Have</Bold></Green>  a 🌝 <Italic><Yellow>Day !</Yellow></Italic>" -width 80 -Align Right -Border "Rounded"
Write-Candy "Hope it will be <Underline>Bright</Underline>" -width 80 -Align Left -Border "Rounded"
Write-Candy "Another Test 🌝 📦 📦" -width 80 -Align Left -Border "Rounded"
Write-Candy "<DarkGreen><Underline>Another</Underline>   Test</DarkGreen>" -Border "Double"

