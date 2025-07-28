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
    Write-Host "$($AnsiColors.BrightGreen)$Message$($AnsiColors.Reset)"
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

$color = [AnsiColor]::ansi('blue')
Write-Host $color
Export-ModuleMember -Function *
Export-ModuleMember -Variable *