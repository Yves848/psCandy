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

Function Parse-CandyMessage {
    param (
        [string]$Message
    )
    
    if (-not $Message) {
        throw "Message cannot be null or empty."
    }
    
    # Use the regex to parse the message
    $m = $regex.Matches($Message)
    
    if ($m.Count -eq 0) {
        return $Message
    }
    
    $parsedMessage = foreach ($match in $m) {
        Write-Host ("$($match.Groups[1].Value) - Index : $($match.Index) - Length : $($match.Length)")
    }
    
    return $parsedMessage -join ''
} 

function write-test {
    param (
        [string]$text
    )
    
    if (-not $text) {
        throw "Text cannot be null or empty."
    }
    
    $convertedText = [Candy]::ParseMessage($text)
    Write-Host $convertedText
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