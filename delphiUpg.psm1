#Requires -Version 5.1
. .\visual.ps1
. .\core.ps1

<#
    This module is designed to manage Delphi development environments.
    It provides functions to retrieve and set Delphi environment variables, manage packages,
    and perform various operations related to Delphi development.
#>

set-DelphiVCS
set-BDSVersion
<# Assign a drive letter to HKEY_CLASSES_ROOT for convenience #>
New-PSDrive -Name "HKCR" -PSProvider Registry -Root "HKEY_CLASSES_ROOT" -ErrorAction SilentlyContinue | Out-Null

<# Create a temporary directory for the Delphi setup #>
$script:temp = [system.IO.Path]::GetTempPath() + (New-Guid).ToString("N")
New-Item -Path $temp -ItemType Directory | Out-Null
Start-Sleep -Milliseconds 1000
if (-not (Test-Path -Path $temp)) {
    Write-Host "Failed to create temporary directory: $temp" -ForegroundColor Red
    return
}

<# Create the DelphiSetup PSDrive #>
New-PSDrive -Name "DelphiSetup" -PSProvider FileSystem -Root $temp -ErrorAction SilentlyContinue -Scope Global | Out-Null
$script:source = "\\fs01.integrale.home\applications$\YGO_TEST"
<# Create the SourceUpd PSDrive -> to update to fit production #>
New-PSDrive -Name "SourceUpd" -PSProvider FileSystem -Root $script:source -ErrorAction SilentlyContinue -Scope Global | Out-Null

    
<# Set the environment variables for Delphi #>
@($script:env).Clear()

Write-Host "$($styles.u1)$($bFG.green)$($styles.b1)Delphi $($styles.i1)Upgrade $($styles.i0)Module $($styles.b0)Loaded$($FG.default)"

# Write-Host "$($script:FG)10m$($script:UL)$($script:IT)Delphi Upgrade Module Loaded$($script:RS)"
Write-Host ""

<# Cleanup actions when the module is removed #>

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    Remove-PSDrive -Name DelphiSetup -ErrorAction SilentlyContinue | Out-Null
    Remove-PSDrive -Name SourceUpd -ErrorAction SilentlyContinue | Out-Null
    Remove-Item -Path $temp -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
}
<# Todo: Only export the necessary functions #>
Export-ModuleMember -Function *
# Export-ModuleMember -Function Compress-Archives
# Export-ModuleMember -Function Start-BDS
# Export-ModuleMember -Function Install-BDS
