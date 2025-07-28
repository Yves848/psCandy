<#
    Get env varibales defined by Delphi in rsvars.bat
#>

$script:version = @{
    "22.0" = "Delphi 11"
    "23.0" = "Delphi 12"
}

$script:env = [ordered]@{}
function Get-DelphiEnv {
    <#
        This function retrieves the Delphi environment variables from the registry and sets them in the global $script:env hashtable.
        It reads the rsvars.bat file to extract the environment variables and adds them to the hashtable.
        The default version is "23.0". You can specify a different version using the -version parameter.
    #>
    param(
        [string]$version = $script:BDSVersion
    )
    # Get the root path of BDS installation
    $rootpath = "HKCU:\SOFTWARE\Embarcadero\BDS\$($version)\"
    $rootdir = (Get-ItemProperty -Path $rootpath).RootDir
    # Parse rsvars.bat
    $rsvar = (Get-Content -Path "$rootdir\bin\rsvars.bat") -split "`n"
    $regex = [regex]::new("(\w+)=([.|\s|\S]*)")
    foreach ($var in $rsvar) {
        if ($var.Trim() -ne "") {
            $var = $var -replace "\@SET ", ""
            $match = $regex.Matches($var)
            $left = $match.Groups[1].Value
            $right = ""
            if ($match.Groups.Count -gt 2) {
                if ($match.groups[2].Value -ne "") {
                    $right = $match.groups[2].Value
                }
            }
            if (-not $script:env.Contains(($left).ToUpper())) {
                $script:env.Add(([string]$left).ToUpper(), $right)
            }
            else {
                $script:env[([string]$left).ToUpper()] = $right
            }
        }
    }
    # Add / Set additionnal env vars.
    # $LIBRARY, $COMPONENTS, $VCS, $BDSBIN
    if (-not $script:env.Contains("LIBRARY")) {
        $script:env.Add("LIBRARY", "$($script:VCS)\racine\racine-v2\externals\library_v35")
    }
    else {
        $script:env["LIBRARY"] = "$($script:VCS)\racine\racine-v2\externals\library_v35"
    }

    if (-not $script:env.Contains("COMPONENTS")) {
        $script:env.Add("COMPONENTS", "$($script:VCS)\Components")
    }
    else {
        $script:env["COMPONENTS"] = "$($script:VCS)\Components"
    }

    if (-not $script:env.Contains("VCS")) {
        $script:env.Add("VCS", "$($script:VCS)")
    }
    else {
        $script:env["VCS"] = "$($script:VCS)"
    }

    if (-not $script:env.Contains("BDSBIN")) {
        $script:env.Add("BDSBIN", "$($script:env['BDS'])\bin")
    }
    else {
        $script:env["BDSBIN"] = "$($script:env['BDS'])\bin"
    }

    
}


Function Set-DelphiEnv {
    <#
        This function sets the Delphi environment variables based on the current environment.
        It retrieves the environment variables and adds them to the global $script:env hashtable.
        The default version is "23.0". You can specify a different version using the -version parameter.
    #>
    param(
        [string]$version = $script:BDSVersion
    )
    Get-ChildItem env: | ForEach-Object {
        if (-not $script:env.Contains(([string]$_.Name).ToUpper())) {
            $script:env.Add(([string]$_.Name).ToUpper(), $_.Value)
        }
        else {
            $script:env[([string]$_.Name).ToUpper()] = $_.Value
        }
    }
    $script:folders = [ordered]@{
        "BDS"        = "$($script:env['BDS'])\"
        "ONEDRIVE"   = "$($script:env['ONEDRIVE'])\Documents\Embarcadero\Studio\$($version)"
        "PUBLIC"     = "c:\Users\Public\Documents\Embarcadero\Studio\$($version)"
        "COMPONENTS" = "$($script:env["COMPONENTS"])"
        "GEXPERTS"  =  "$($script:env["COMPONENTS"])\GExperts for RAD Studio 12"
    }
    # $script:env
}

function Get-DelphiPackages {
    <#
        This function retrieves the list of installed Delphi packages.
        It returns a list of package names that are registered in the Delphi environment.
        The default version is "23.0". You can specify a different version using the -version parameter.
    #>
    param(
        [string]$version = $script:BDSVersion
    )
    # Get the list of installed packages
    $packagespath = "HKCU:\SOFTWARE\Embarcadero\BDS\$($version)\Known Packages\"
    $packages = Get-Item -Path $packagespath | Select-Object -ExpandProperty Property
    $packages
}

function Get-SearchPaths {
    <#
        This function retrieves the search paths for Delphi packages.
        It returns a list of paths that are used to search for Delphi packages.
    #>
    param(
        [string]$version = $script:BDSVersion
    )
    Get-DelphiEnv
    $null = Set-DelphiEnv
    (SanitizePaths -packages ((Get-ItemProperty -Path "HKCU:\SOFTWARE\Embarcadero\BDS\$($version)\Library\Win32\" -Name 'Search Path')."Search Path" -split ";")) -join ";"
}

function SanitizePaths {
    <#
        This function sanitizes the paths of Delphi packages by replacing specific paths with environment variables.
        It uses a predefined mapping of paths to environment variables.
    #>
    param (
        [string[]]$packages = @()
    )
    $validPaths = $script:env.GetEnumerator() | Sort-Object { $_.Value.Length } -Descending | Where-Object { ($_.Value -ne "") -and (test-path -Path $_.Value) }

    $packages | ForEach-Object {
        $packagePath = $_
        $index = 0
        $result = $packagePath
        foreach ($envPath in $validPaths.Value) {
            if ($envPath -ne "" -and $packagePath.ToUpper().StartsWith($envPath.ToUpper())) {
                # write-host "Replacing $envPath with $($validPaths[$index].Name) in $packagePath"
                $result = $packagePath.ToUpper() -replace [regex]::Escape($envPath.ToUpper()), "$`($($validPaths[$index].Name)`)"       
                break
            }
            $index++
        }
        $result
    }
    
}

Function Get-LibPath {
    <#
        Retrieves the library paths for Delphi projects.
        It returns a list of paths that are used to search for Delphi libraries.
        The paths are retrieved from the root directory of the VCS (Version Control System).
    #>
    $root = "$($script:VCS)\racine\racine-v2\externals\library_v35"
    $paths = Get-ChildItem -Recurse -Directory -depth 0 $root | ForEach-Object { $_.FullName }
    $result = $paths | Where-Object {
        -not ($_.Contains("Proje")) # Exclude paths that contain "Proje"
    } 
    $result
}

Function Get-DelphiVersions {
    <#
        Retrieves the installed Delphi versions from the registry.
        It returns a list of version names found in the registry under the Embarcadero BDS key.
    #>
    $version = Get-ChildItem "HKCU:\SOFTWARE\Embarcadero\BDS\" | Select-Object -ExpandProperty Name 
    $version | ForEach-Object { "$($script:esc)$($script:FG)75m$($script:version[$([regex]::Match($_, "\d+\.\d+").Value)])$($script:DF) - BDS $([regex]::Match($_, "\d+\.\d+").Value)" }
}

Function  Compress-Archives {
    <#
        Compresses Delphi archives for the specified version.
        The default version is "23.0". You can specify a different version using the -version parameter.
        This function compresses various Delphi-related folders into ZIP files.
    #>
    param (
        [string]$version = $script:BDSVersion
    )
    Clear-Host
    $ProgressPreference = 'SilentlyContinue'
    Get-DelphiEnv -version $version
    Set-DelphiEnv -version $version
    Write-Host "$($FG)10m$($UL)$($IT)Compressing Delphi $version archives...$($RS)"
    Write-Host "This may take a while, please wait...$($RS)"
    Write-Host "--------------------------------------------------$($RS)"
    Write-Host

    <#
        $folders is an ordered hashtable that contains the folders to compress.
        The keys are the names of the folders, and the values are the paths to those folders.
        The paths are constructed using environment variables and the specified Delphi version.

        It is possible to pass the hashtable as a parameter to the function, but it is not necessary. #TO-DO ?

        Remarks: Adapt the paths to the environment variables after the normalized Delphi installation.
    #>

    if (-not (test-path -Path "./$($version)")) {
        New-Item -Path "./$($version)" -ItemType Directory | Out-Null
    }

    $TotalTime = [system.diagnostics.stopwatch]::StartNew()

    foreach ($folder in $script:folders.Keys) {
        $source = $script:folders[$folder]
        $FolderTime = [system.diagnostics.stopwatch]::StartNew()
        Write-Host "Compressing $($FG)75m$($IT)$folder$($DF) from $($FG)9m$source$($RS)" -NoNewline
        if (Test-Path $source) {
            Compress-Archive -DestinationPath "./$($version)/$folder.zip" -CompressionLevel Fastest -Force -Path $source -ErrorAction SilentlyContinue 
        }
        Write-Host " - Done in $($FG)9m$($FolderTime.Elapsed.Minutes):$($FolderTime.Elapsed.Seconds)$($RS)"
        $FolderTime.Stop()
    }
    Write-Host "--------------------------------------------------$($RS)"
    Write-Host "Total time taken: $($FG)9m$($TotalTime.Elapsed.Minutes):$($TotalTime.Elapsed.Seconds)$($RS)"
    Export-BDSRegistry -version $version
    Export-Json -filePath "./$($version)/$($version).json"
    $TotalTime.Stop()
    $ProgressPreference = 'Continue'
    Write-Host "All archives compressed successfully!" -ForegroundColor Green
    Write-Host "You can find the compressed files in the './$($version)/' directory." -ForegroundColor Cyan
    Write-Host "--------------------------------------------------$($RS)"

}

function Install-Packages {
    <#
        Installs Delphi packages by expanding the specified version packages.
        The default version is "23.0". You can specify a different version using the -version parameter.
        This function assumes that the packages are located in the "Components" directory of the VCS path.
    #>
    param (
        [string]$version = $script:BDSVersion
    )
    Write-Host "$($FG)10m$($UL)$($IT)Expanding Delphi $version packages...$($RS)"
    # TODO: Change the path to the packages directory if necessary.
    # if (-not (test-path -Path "\\fs01.integrale.home\applications$\YGO_TEST\$($version)")) {
    if (-not (test-path -Path "SourceUpd:\$($version)")) {
        Write-Host "Packages directory not found. Please ensure the BDS version is set correctly." -ForegroundColor Red
        return
    }
    Write-Host "$($FG)75m$($IT)$folder$($DF)This may take a while, please wait...$($RS)"
    $TotalTime = [system.diagnostics.stopwatch]::StartNew()
    # $json = Get-Content -Path "\\fs01.integrale.home\applications$\YGO_TEST\$($version)\$($version).json" | ConvertFrom-Json
    $json = Get-Content -Path "SourceUpd:$($version)\$($version).json" | ConvertFrom-Json
    $json.Destinations.PSObject.Properties | ForEach-Object {
        $dest = $_.Value -replace "##USER##", $env:USERNAME
        Write-Host "Copying $($FG)75m$($_.Name)$($DF) to $($FG)9m$dest$($RS)"
        Copy-Item -Path "SourceUpd:\$($version)\$($_.Name).zip" -Destination "DelphiSetup:\" -Force
        Expand-Archive -Path "DelphiSetup:\$($_.Name).zip" -DestinationPath $dest -Force -ErrorAction SilentlyContinue
    }
    Write-Host " - Done in $($FG)9m$($TotalTime.Elapsed.Minutes)m$($TotalTime.Elapsed.Seconds)s$($RS)"
    $TotalTime.Stop()
}

Function Write-DelphiEnv {
    <#
        Writes the current Delphi environment variables to the console.
        It displays the environment variables in a formatted table. 
    #>
    $script:env.GetEnumerator() | Sort-Object Name | Format-Table -AutoSize
}

Function Start-BDS {
    <#
        Starts the Delphi IDE (BDS) with the specified version.
        The default version is "23.0". You can specify a different version using the -version parameter.
        The VCS path can also be specified using the -VCSPath parameter.
    #>
    param (
        [string]$version = $script:BDSVersion,
        [string]$VCSPath = $script:VCS,
        [string]$LIBRARY = "$($script:env['VCS'])\racine\racine-v2\externals\library_v35"
    )
    Get-DelphiEnv -version $version
    Set-DelphiEnv -version $version
    $env:VCS = $VCSPath
    $env:COMPONENTS = "$($script:env['VCS'])\Components"
    $env:LIBRARY = $LIBRARY

    Write-Host "$($FG)10m$($UL)$($IT)Starting Delphi $version...$($RS)"
    $bdsPath = "$($script:env['BDS'])\bin\bds.exe"
    Start-Process -FilePath $bdsPath 
}

Function Export-Json {
    <#
        Exports the whole parameters necessary to export on a new environment to a JSON file.
        The default file path is "delphi_env.json" in the current directory.
        You can specify a different file path using the -filePath parameter.
    #>
    param (
        [string]$filePath = "$($version).json"
    )
    $data = @{}
    $data.BDSVersion = $script:BDSVersion
    $data.VCS = $script:VCS
    $data.Registry = "$($version).reg"
    $data.Destinations = @{}
    $data.Destinations.BDS = "$($script:env['PROGRAMFILES(X86)'])\Embarcadero\Studio"
    $data.Destinations.ONEDRIVE = "C:\Users\##USER##\OneDrive - Monument Insurance Ltd\Documents\Embarcadero\Studio\"
    $data.Destinations.PUBLIC = "C:\Users\Public\Documents\Embarcadero\Studio\"
    $data.Destinations.COMPONENTS = "$($script:env['COMPONENTS'])"
    $data | ConvertTo-Json -Depth 5 | Out-File -FilePath $filePath -Encoding UTF8
}

function Set-DelphiVCS {
    <#
        Sets the version control system path for Delphi projects.
        The default path is "C:\_SVN". You can specify a different path using the -VCSPath parameter.
        This function updates the global variable $script:VCS with the specified path.
    #>
    param(
        [string]$VCSPath = "C:\Git"
    )
    $script:VCS = $VCSPath
}

function Get-DelphiVCS {
    <#
        Returns the current version control system path.
        If not set, it returns the default path "C:\_SVN".
    #>  
    $script:VCS
}

function set-BDSVersion {
    <#
        Sets the BDS version for Delphi projects.
        The default version is "23.0". You can specify a different version using the -version parameter.
        This function updates the global variable $script:BDSVersion with the specified version.
    #>
    param(
        [string]$version = "23.0"
    )
    $script:BDSVersion = $version
}

function Get-BDSVersion {
    <#
        Returns the current BDS version.
        If not set, it returns the default version "23.0".
    #>
    $script:BDSVersion
}

function Export-BDSRegistry {
    <#
        Exports the BDS registry settings for the specified version to a .reg file.
        The default version is "23.0". You can specify a different version using the -version parameter.
        The exported file will be named "<version>.reg" in the current directory.
    #>
    param(
        [string]$version = $script:BDSVersion
    )
    Invoke-Expression "regedit.exe /e './temp.reg' 'HKEY_CURRENT_USER\SOFTWARE\Embarcadero\BDS\$($version)'" 
    # Invoke-Expression is Async .... so we must wait for the file to be created.
    start-sleep -milliseconds 1000
    Get-Content .\temp.reg -Encoding ascii | Out-File -FilePath "./$($version)/$($version).reg" -Encoding ascii   
    # Export Classes registry settings
    # $classes = Get-ChildItem "HKLM:\SOFTWARE\Classes" | Select-Object -ExpandProperty Name | Where-Object { $_ -like "*Borland*" }
    # $classes | ForEach-Object {
    #     $class = [regex]::Matches("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\$($_)", "Borland[\.\w\s]+").value
    #     Invoke-Expression "regedit.exe /e './temp.reg' 'HKEY_LOCAL_MACHINE\SOFTWARE\Classes\$($class)'"
    #     start-sleep -milliseconds 250
    #     $content = Get-Content .\temp.reg -Encoding ascii | Select-Object -Skip 2 
    #     Out-File -InputObject $content -FilePath "./$($version)/$($version).reg" -Append -Encoding ascii 
    #     Remove-Item -Path "./temp.reg" -Force
    #     $CLSID = (Get-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Classes\$($class)\CLSID")."(Default)"
    #     $CLSID
    #     if ($CLSID -ne "") {
    #         Invoke-Expression "regedit.exe /e './temp.reg' 'HKEY_CLASSES_ROOT\CLSID\$($CLSID)'" 
    #         start-sleep -milliseconds 250
    #         if (Test-Path -Path "./temp.reg") {
    #             Get-Content .\temp.reg -Encoding ascii | Select-Object -Skip 2 | Out-File -FilePath "./$($version)/$($version).reg" -Append -Encoding ascii   
    #             Remove-Item -Path "./temp.reg" -Force
    #         }
    #     }
    #     # Start-Sleep -Seconds 2
    #     # (Get-Content -Path "./$($version)/$($_).reg") -replace $env:USERNAME, "##USER##" | Out-File "./$($version)/$($_)_New.reg"
    #     # Move-Item "./$($version)/$($_)_New.reg" -Destination "./$($version)/$($_).reg" -Force
    
    Start-Sleep -Seconds 1
    (Get-Content -Path "./$($version)/$($version).reg") -replace $env:USERNAME, "##USER##" | Out-File "./$($version)/$($version)_New.reg"
    Move-Item "./$($version)/$($version)_New.reg" -Destination "./$($version)/$($version).reg" -Force
}
function Import-BDSRegistry {
    <#
        Imports the BDS registry settings from a .reg file for the specified version.
        The default version is "23.0". You can specify a different version using the -version parameter.
        The .reg file should be named "<version>.reg" and located in the current directory.
    #>
    param(
        [string]$version = $script:BDSVersion
    )
    if (-not (Test-Path "$($version).reg")) {
        Write-Host "Registry file '$($version).reg' not found. Please ensure it exists in the current directory." -ForegroundColor Red
        return
    }
    $prompt = @("Press $($FG)46mEnter$($DF) to import the registry settings for Delphi $version.", 
        "This will overwrite existing settings.", 
        "Press $($FG)9mCtrl-C$($DF) to Cancel.")

    Read-Host -Prompt ($prompt -join "`n") | Out-Null
    (Get-Content -Path "./$($version)/$($version).reg") -replace "##USER##", $env:USERNAME | Out-File "./$($version)/$($version)_Local.reg"
    Invoke-Expression "regedit.exe /s './$($version)/$($version)_Local.reg'"
}

function Split-File {
    # Obsolete / Not used anymore.
    param
    (
        [Parameter(Mandatory)]
        [String]
        $Path,

        [Int32]
        $PartSizeBytes = 99MB
    )

    try {
        # get the path parts to construct the individual part
        # file names:
        $fullBaseName = [IO.Path]::GetFileName($Path)
        $parentFolder = [IO.Path]::GetDirectoryName($Path)
        
        # get the original file size and calculate the
        # number of required parts:
        $originalFile = New-Object System.IO.FileInfo($Path)
        $totalChunks = [int]($originalFile.Length / $PartSizeBytes) + 1
        $digitCount = [int][Math]::Log10($totalChunks) + 1

        # read the original file and split into chunks:
        $reader = [IO.File]::OpenRead($Path)
        $count = 0
        $buffer = New-Object Byte[] $PartSizeBytes
        $moreData = $true

        # read chunks until there is no more data
        while ($moreData) {
            # read a chunk
            $bytesRead = $reader.Read($buffer, 0, $buffer.Length)
            # create the filename for the chunk file
            $chunkFileName = "$parentFolder\$fullBaseName.{0:D$digitCount}.part" -f $count
            Write-Verbose "saving to $chunkFileName..."
            $output = $buffer

            # did we read less than the expected bytes?
            if ($bytesRead -ne $buffer.Length) {
                # yes, so there is no more data
                $moreData = $false
                # shrink the output array to the number of bytes
                # actually read:
                $output = New-Object Byte[] $bytesRead
                [Array]::Copy($buffer, $output, $bytesRead)
            }
            # save the read bytes in a new part file
            [IO.File]::WriteAllBytes($chunkFileName, $output)
            # increment the part counter
            ++$count
        }
        # done, close reader
        $reader.Close()
    }
    catch {
        throw "Unable to split file ${Path}: $_"
    }
}

function Copy-File {
    param( [string]$from, [string]$to)
    $ffile = [io.file]::OpenRead($from)
    $tofile = [io.file]::OpenWrite($to)
    Write-Progress -Activity "Copying file" -status "$from -> $to" -PercentComplete 0
    try {
        [byte[]]$buff = new-object byte[] (65536*2) # 128 KB buffer
        [long]$total = [int]$count = 0
        do {
            $count = $ffile.Read($buff, 0, $buff.Length)
            $tofile.Write($buff, 0, $count)
            $total += $count
            if ($total % 1mb -eq 0) {
                Write-Progress -Activity "Copying file" -status "$from -> $to" `
                   -PercentComplete ([long]($total * 100 / $ffile.Length))
            }
        } while ($count -gt 0)
    }
    finally {
        $ffile.Dispose()
        $tofile.Dispose()
        Write-Progress -Activity "Copying file" -Status "Ready" -Completed
    }
}

function Install-BDS {
    <#
        Installs the Delphi IDE (BDS) with the specified version.
        The default version is "23.0". You can specify a different version using the -version parameter.
        This function assumes that the BDS installer is located in the current directory.
    #>
    param (
        [string]$version = $script:BDSVersion,
        [string]$SLIPFILE = ".2026_52.1750233006487.slip"
    )
    Clear-Host
    
    Write-Host "$($FG)12m$($UL)$($IT)Downloading RadStudio $version installer ...$($RS)"
    if (-not (Test-Path -Path $temp)) {
        New-Item -Path $temp -ItemType Directory | Out-Null
    }
    Copy-File -from "$($source)\$($version)\RadStudio.zip" -to "$($temp)\RadStudio.zip"
    Copy-File -from "$($source)\$($version)\$($SLIPFILE)" -to "$($temp)\$($SLIPFILE)"
    
    <# Expand zip file with installer #>
    Expand-Archive -Path "DelphiSetup:\RadStudio.zip" -DestinationPath "DelphiSetup:\" -Force

    $installer = (Get-ChildItem -Path "DelphiSetup:\" -Filter "radstudio*.exe" | Select-Object -First 1).FullName
    Write-Host "Installer ${installer} " -ForegroundColor Green
    Write-Host "$($FG)10m$($UL)$($IT)Installing Delphi $version...$($RS)"
    if (-not $installer) {
        Write-Host "Installer not found in the temporary directory. Please ensure the ZIP file contains the installer." -ForegroundColor Red
        Write-Host "Installer ${installer} not found in the temporary directory." -ForegroundColor Red
        Write-Host "Available files: $(Get-ChildItem -Path "DelphiSetup:\")" -ForegroundColor Yellow
        return
    }
    # $installerPath = "$((Get-PSDrive -Name DelphiSetup).Root)\$($installer)"
    # if (-not (Test-Path -Path $installerPath)) {
    #     Write-Host "Installer not found at '$installerPath'. Please ensure it exists in the current directory." -ForegroundColor Red
    #     return
    # }
    $result = Start-Process -FilePath $installer -ArgumentList "/SILENT", "/NORESTART", "/SLIPFILE=$($temp)\$($SLIPFILE)", "/FEATURES=delphi_windows;teechart;dunit;font;modeling", "/LOG=c:\Temp\installBDS.log" -Wait -PassThru
    
    if ($result.ExitCode -ne 0) {
        Write-Host "Delphi $version installation failed with exit code $($result.ExitCode)." -ForegroundColor Red
        return
    }
    
    Write-Host "Delphi $version installation completed." -ForegroundColor Green
}

function Mount-Iso {
    param (
        [string]$isoPath
    )
    if (-not (Test-Path -Path $isoPath)) {
        Write-Host "ISO file not found at '$isoPath'. Please ensure it exists." -ForegroundColor Red
        return
    }
    $script:mountResult = Mount-DiskImage -ImagePath $isoPath -PassThru
    if ($script:mountResult) {
        $script:dvdletter = ($script:mountResult | Get-Volume).DriveLetter
        Write-Host "Mounted ISO: $($script:mountResult.DevicePath) - Drive Letter: $(($script:mountResult | Get-Volume).DriveLetter)" -ForegroundColor Green
    }
    else {
        Write-Host "Failed to mount ISO." -ForegroundColor Red
    }
}

function Dismount-Iso {
    if ($script:mountResult) {
        Dismount-DiskImage -DevicePath $script:mountResult.DevicePath
        Write-Host "Dismounted ISO: $($script:mountResult.DevicePath)" -ForegroundColor Green
    }
    else {
        Write-Host "No ISO mounted." -ForegroundColor Red
    }
}

Function Write-Rainbow {
    <#
        Writes a rainbow-colored message to the console.
    #>
    param (
        [string]$message = "Welcome to Delphi Upgrader!"
    )
    [System.Text.StringBuilder]$sb = [System.Text.StringBuilder]::new()
    $i = 147
    $message.ToCharArray() | ForEach-Object {
        $null = $sb.Append("$($FG)$($i)m$($_)")
        $i++
        if ($i -gt 183) {
            $i = 147
        }
    }
    Write-Host "$($UL)$($sb.ToString())"
}