Add-Type -Assembly System.IO.Compression.FileSystem
<#
    Defining a hashtable to store all the environment variables
#>
$script:env = [ordered]@{}
$script:Documents = "$($env:OneDrive)\Documents"
$script:DocumentAllUsers = "$($env:PUBLIC)\Documents"
$script:VCS = "_SVN"

. .\core.ps1
. .\visual.ps1


@($script:env).Clear()

Write-Host "$($script:FG)10m$($script:UL)$($script:IT)Delphi Upgrade Module Loaded$($script:RS)"
Write-Host ""

Export-ModuleMember -Function Get-DelphiPackages
Export-ModuleMember -Function Get-DelphiEnv
Export-ModuleMember -Function Set-DelphiEnv
Export-ModuleMember -Function Get-LibPath
Export-ModuleMember -Function Get-DelphiVersions
Export-ModuleMember -Function Compress-Archives
Export-ModuleMember -Function Install-Packages
Export-ModuleMember -Function Write-DelphiEnv
Export-ModuleMember -Function Start-BDS
Export-ModuleMember -Function Export-Json