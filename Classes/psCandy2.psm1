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
    $matches = $regex.Matches($Message)
    
    if ($matches.Count -eq 0) {
        return $Message
    }
    
    $parsedMessage = foreach ($match in $matches) {
        
            Write-Host $match.Groups[1].Value
        
    }
    
    return $parsedMessage -join ''
} 

Export-ModuleMember -Function *
Export-ModuleMember -Variable *