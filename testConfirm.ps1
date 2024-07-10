Import-Module "$((Get-Location).Path)\classes.ps1" -Force

$confirm = [Confirm]::new("Do you want to continue?",@(
  [Option]::new("Yes", "Yes"),
  [Option]::new("No", "No"),
  [Option]::new("Maybe", "?")
),$true)

$confirm.Display()