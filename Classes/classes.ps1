$script:regex = [regex]::new('\<([\w]*\/?[\w]*)\>')

$script:esc = [char]27
$script:colors = get-content -path .\ansi256.json | ConvertFrom-Json -Depth 3
class AnsiColor {
    static [int]ansi([string]$name) {
        if ($script:colors.psobject.properties.name -contains $name) {
            return $script:colors.$name.ansi
        } else {
            throw "Color '$name' not found in ANSI colors."
        }
    }
}