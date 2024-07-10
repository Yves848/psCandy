Import-Module "$((Get-Location).Path)\classes.ps1" -Force
$options = @(
  [Option]::new("Yes", "Yes"),
  [Option]::new("No", "No",$true),
  [Option]::new("Maybe", "?")
)
$confirm = [Confirm]::new("Do you want to continue?",$options,$true)
$result = $confirm.Display()
[console]::Clear()
switch ($result.value) {
  "Yes" {
    Write-Host "You chose Yes"
  }
  "No" {
    Write-Host "You chose No"
  }
  "?" {
    Write-Host "You chose Maybe"
  }
  default {
    Write-Host "You chose nothing"
  }
}
