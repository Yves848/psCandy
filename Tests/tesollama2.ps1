function Replace-Tags {
  param (
      [string]$InputString,
      [hashtable]$Replacements
  )

  # Function to replace tags in a string
  function Replace-Tag {
      param ($match)
      $tagName = $match.Groups[1].Value
      $replacement = $Replacements[$tagName]
      if ($replacement -ne $null) {
          return $replacement
      } else {
          return $match.Value # Return the original match if no replacement is found
      }
  }

  # Define a regex pattern to match any tag format
  $pattern = '<([^>]+)>(.*?)<\/\1>'
  
  # Replace all occurrences of the tags with their corresponding values using the defined function
  $InputString = [regex]::Replace($InputString, $pattern, { param ($match) (Replace-Tag -match $match) }, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

  return $InputString
}

# Example usage:
$string = "<Blue>Text</Blue> and <Red>More Text</Red>"
$replacements = @{
  "Blue" = "Colorful Blue";
  "Red"  = "Colorful Red"
}
$result = Replace-Tags -InputString $string -Replacements $replacements
Write-Output "The result of replacing tags is: $result"
