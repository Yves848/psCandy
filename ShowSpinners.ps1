Import-Module "$((Get-Location).Path)\classes.ps1" -Force

("Circle","Dots","Line","Square","Bubble","Arrow","Pulse") | ForEach-Object {
  $spinner = [Spinner]::new($_)
  $Spinner.Start("$($_) Testing Spinner...")
  Start-Sleep -Seconds 3
  $Spinner.Stop()
} 



Remove-Module -name classes -Force