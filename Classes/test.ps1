# ANSI escape code for saving cursor position
$saveCursor = "`e[s"

# ANSI escape code for restoring cursor position
$restoreCursor = "`e[u"

# ANSI escape code for moving the cursor to the top-left corner of the screen (or any specific position)
$moveToTopLeft = "`e[H"

# ANSI escape code to clear the screen (or a portion of it)
$clearScreen = "`e[2J"

# Save the cursor position (where we will return later)
Write-Host "$saveCursor"

# Capture the content at the top of the screen (simulate by storing it in a variable)
$originalContent = @"
This is some original content.
It may be more lines long.
"@

# Display the original content
Write-Host $originalContent

# Pause for a moment
Start-Sleep -Seconds 2

# Write something new to the screen
Write-Host "`n--- New Content Starts Here ---"
Write-Host "This content will be temporarily written to the terminal."
Start-Sleep -Seconds 3

# Clear the newly written content (by returning cursor and overwriting)
Write-Host $restoreCursor
Write-Host "$clearScreen"

# Restore the original content
Write-Host "$originalContent"
