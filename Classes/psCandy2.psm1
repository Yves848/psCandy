. $PSScriptRoot/classes.ps1
. $PSScriptRoot/consts.ps1

function Write-CandyMessage {
    param (
        [string]$Message
    )
    
    if (-not $Message) {
        throw "Message cannot be null or empty."
    }
    
    # Output the message to the console
    Write-Host "$($CandyAnsi.BrightGreen)$Message$($CandyAnsi.Reset)"
}

function write-test {
    param (
        [string]$text
    )
    
    if (-not $text) {
        throw "Text cannot be null or empty."
    }
    
    Write-Host $([Candy]::Parse($text))
}

function Get-BorderType {
    param(
        [string]$type
    )
    $script:BorderTypes[$type]
}

#Write-Host $script:colors.psObject.properties
Export-ModuleMember -Function write-test, Get-BorderType
Export-ModuleMember -Variable *