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

$text = Build-Candy "This is the first line"  -width 60
$text += "`n" + (Build-Candy "This is the second line" -width 60 -align Right)

Write-Candy $text -Border "Rounded" -width 60

Write-Host

$params =@{
    width = 80
}
$text = Build-Candy "This is <57>the first</57> line"  -Align Center @params
$text += "`n" + (Build-Candy "This is <190><U>the second</U></190> line" -Align Left   @params)
$text += "`n" + (Build-Candy "🎉 This is <I>>the <219>third</219> line</I> 🎉" -Align Right   @params)

Write-Candy $text -Border "Rounded" @params

Write-Host

$params =@{
    fullscreen = $true
}
$text = Build-Candy "This is <57>the first</57> line"  -Align Center @params
$text += "`n" + (Build-Candy "This is <190><U>the second</U></190> line" -Align Left   @params)
$text += "`n" + (Build-Candy "🎉 This is <I>>the <219>third</219> line</I> 🎉" -Align Right   @params)

Write-Candy $text -Border "Double" @params 
