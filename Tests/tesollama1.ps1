function Get-StringLength {
    param (
        [string]$InputString
    )

    # Initialize a counter for the length
    $length = 0

    # Loop through each character in the string
    foreach ($char in $InputString.ToCharArray()) {
        # Convert the character to its UTF-16 code unit (2 bytes)
        [int]$utf16CodeUnit = [System.BitConverter]::GetBytes($char)[0]
        
        # If the code unit is negative, it means we have a multibyte character
        if ($utf16CodeUnit -lt 0) {
            $length += 2
        } else {
            $length++
        }
    }

    return $length
}

function Get-StringByteLength {
  param (
      [string]$InputString
  )

  # Initialize a counter for the length in bytes
  $byteLength = 0

  # Loop through each byte in the string
  foreach ($byte in [System.Text.Encoding]::Unicode.GetBytes($InputString)) {
      $byteLength++
  }

  return $byteLength
}

# Example usage:
$string = "こんにちは世界123" # This is a Japanese greeting containing multibyte characters
$length = Get-StringByteLength -InputString $string
Write-Output "The length of the string in bytes is: $length"


# Example usage:
$string = "こんにちは世界123" # This is a Japanese greeting containing multibyte characters
$length = Get-StringLength -InputString $string
Write-Output "The length of the string is: $length"


function Get-StringFullLength {
  param (
      [string]$InputString
  )

  # Initialize a counter for the length in characters, including emojis
  $length = 0

  # Loop through each character in the string
  foreach ($char in $InputString.ToCharArray()) {
      # Convert the character to its UTF-16 code unit (2 bytes)
      [int]$utf16CodeUnit = [System.BitConverter]::GetBytes($char)[0]
      
      # If the code unit is negative, it means we have a multibyte character including emojis
      if ($utf16CodeUnit -lt 0) {
          $length += 2
      } else {
          $length++
      }
  }

  return $length
}

# Example usage:

$string = "こんにちは世界 🌍🗑️" # This includes a Japanese greeting and a globe emoji
# $string = "こんにちは世界" # This includes a Japanese greeting and a globe emoji
$length = Get-StringFullLength -InputString $string
Write-Output "The length of the string including emojis is: $length"

$string = "こんにちは世界 🌍" # This includes a Japanese greeting and a globe emoji
# $string = "こんにちは世界" # This includes a Japanese greeting and a globe emoji
$length = Get-StringFullLength -InputString $string
Write-Output "The length of the string including emojis is: $length"


function Get-StringByteLength {
  param (
      [string]$InputString
  )

  # Get the byte array of the string encoded in UTF-16
  $byteArray = [System.Text.Encoding]::Unicode.GetBytes($InputString)
  
  # Return the length of the byte array
  return $byteArray.Length
}

# Example usage:
$string = "こんにちは世界 🌍" # This includes a Japanese greeting and a globe emoji
$length = Get-StringByteLength -InputString $string
Write-Output "The length of the string in bytes is: $length"
