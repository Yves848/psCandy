$script:regex = [regex]::new('\<([\w\-]*\/?[\w\-]*)\>')

$script:esc = [char]27
$script:reset = "$($script:esc)[0m"
$script:attr = Get-Content -Path .\ansi256.json | ConvertFrom-Json
$script:ansi = @{
    "style" = "$($script:esc)[{0}m"  
    "fg"    = "$($script:esc)[38;5;{0}m"
    "bg"    = "$($script:esc)[48;5;{0}m"
    "df"    = "$($script:esc)[39m"
    "db"    = "$($script:esc)[49m"
}
foreach ($prop in $script:colors.psobject.Properties) {
    $cle = $prop.Value
    $cle.PSObject.Properties.Add([PSNoteProperty]::new('Type', "color"))
}

$script:attr.psobject.Properties.add([PSNoteProperty]::new("italic", [PSCustomObject]@{
            on   = 3
            off  = 23
            Type = "style"
        }))
$script:attr.psobject.Properties.add([PSNoteProperty]::new("bold", [PSCustomObject]@{
            on   = 1
            off  = 21
            Type = "style"
        }))
$script:attr.psobject.Properties.add([PSNoteProperty]::new("underline", [PSCustomObject]@{
            on   = 4
            off  = 24
            Type = "style"
        }))
$script:attr.psobject.Properties.add([PSNoteProperty]::new("strike", [PSCustomObject]@{
            on   = 9
            off  = 29
            Type = "style"
        }))

class CandyAnsi {
    static [int]ansi([string]$name) {
        if ($script:attr.psobject.properties.name -contains $name) {
            return $script:attr.$name.ansi
        }
        else {
            throw "Color '$name' not found in ANSI colors."
        }
    }

    static [string]set([string]$name) {
        $slash = $name.IndexOf("/")
        if ($slash -ne -1) {
            <# Un slash veut dire que le tag peut contenir fg et/ou bg #>
            $fg, $bg = $name -split "/"
            # Write-Host "fore = $fg back = $bg"
            $result = ""
            if (($null -ne $fg) -and ($fg.trim() -ne "")) {
                $result = [string]::Format($script:ansi["fg"], $script:attr.$fg.ansi)
            }
            if (($null -ne $bg) -and ($bg.trim() -ne "")) {
                $result = [string]::Format($script:ansi["bg"], $script:attr.$bg.ansi)
            }
            
            return $result
        }
        else {
            # <# C'est obligatoirement un fg ou un style #>
            if ($script:attr.psobject.properties.name -contains $name) {
                if ($script:attr.$name.type -eq "style") {
                    return [string]::Format($script:ansi["style"], $script:attr.$name.on)
                }
                else {
                    return [string]::Format($script:ansi["fg"], $script:attr.$name.ansi)
                }
            }
            else {
                throw "Color '$($name)' not found in ANSI colors."
            }
        }   
    }

    static [string]unset([string]$name) {
        $slash = $name.IndexOf("/")
        if ($slash -ne -1) {
            return "$($script:esc)[49m" 
        }
        else { 
            # <# C'est obligatoirement un fg ou un style #>
            if ($script:attr.psobject.properties.name -contains $name) {
                if ($script:attr.$name.type -eq "style") {
                    return [string]::Format($script:ansi["style"], $script:attr.$name.off)
                }
                else {
                    return "$($script:esc)[39m" 
                }
            }
            else {
                throw "Color '$($name)' not found in ANSI colors."
            }
        }
    }
    static [string]rgb([string]$name) {
        if ($script:attr.psobject.properties.name -contains $name) {
            return $script:attr.$name.rgb
        }
        else {
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
                        $output.Append([CandyAnsi]::unset($currentTag)) | Out-Null
                    }
                }
                else {
                    # Open a new style
                    $tag = $match.Groups[1].Value
                    if ($tag) {
                        $output.Append([CandyAnsi]::set($tag)) | Out-Null
                        $stack.Push($tag)
                    }
                    else {
                        # If the tag is not recognized, just append it as is
                        $output.Append($match.Value) | Out-Null
                    }
                }
                $currentIndex = $match.Index + $match.Length
            }
            $position++
        }
        $output.Append($Message.Substring($currentIndex)) | Out-Null
        $output.Append($script:reset) | Out-Null
        return $output.ToString()
    }
}