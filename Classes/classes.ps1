$script:regex = [regex]::new('\<([\w\-]*\/?[\w\-]*)\>')

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

    static [string]set([string]$name) {
        if ($script:colors.psobject.properties.name -contains $name) {
            return "$($script:esc)[38;5;$($script:colors.$name.ansi)m"
        } else {
            throw "Color '$name' not found in ANSI colors."
        }
    }

    static [string]unset([string]$name) {
        if ($script:colors.psobject.properties.name -contains $name) {
            return "$($script:esc)[39m"
        } else {
            throw "Color '$name' not found in ANSI colors."
        }
    }
    static [string]rgb([string]$name) {
        if ($script:colors.psobject.properties.name -contains $name) {
            return $script:colors.$name.rgb
        } else {
            throw "Color '$name' not found in ANSI colors."
        }
    }
}

class Candy {
    static [string]ParseMessage([string]$Message) {
        $stack = [System.Collections.Stack]::new()
        $currentIndex = 0

        # Use the regex to parse the message
        $m = $script:regex.Matches($Message)

        $position = 0
        $output = [System.Text.StringBuilder]::new()
        while ($position -lt $Message.Length) {
            $match = $m | Where-Object { $_.Index -eq $position }
            if ($match) {
                # Add normal text before the tag
                if ($match.Index -gt $currentIndex) {
                    $output.Append($Message.Substring($currentIndex, $match.Index - $currentIndex)) | Out-Null
                }

                # Process the tag
                if ($match.Value -eq "</>") {
                    # Close the last style
                    if ($stack.Count -gt 0) {
                        $currentTag = $stack.Pop()
                        $output.Append([AnsiColor]::unset($currentTag)) | Out-Null
                    }
                } else {
                    # Open a new style
                    $tag = $match.Groups[1].Value
                    if ($tag -and $script:colors.psobject.properties.name -contains $tag) {
                        $output.Append([AnsiColor]::set($tag)) | Out-Null
                        $stack.Push($tag)
                    } else {
                        # If the tag is not recognized, just append it as is
                        $output.Append($match.Value) | Out-Null
                    }
                }
                $currentIndex = $match.Index + $match.Length
            }
         $position++   
        }
        $output.Append($Message.Substring($currentIndex)) | Out-Null
        return $output.ToString()
    }
}