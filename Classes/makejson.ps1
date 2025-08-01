$attr = Get-Content -Path .\ansi256.json | ConvertFrom-Json
foreach ($prop in $attr.psobject.Properties) {
    $cle = $prop.Value
    $cle.PSObject.Properties.Add([PSNoteProperty]::new('Type', "color"))
}
$attr.psobject.Properties.add([psnoteproperty]::new("italique", [PSCustomObject]@{
    ansi = 123
    Type = "style"
}))
$attr