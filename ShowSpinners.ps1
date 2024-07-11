. "$PSScriptRoot\Themes.ps1" -Force
. "$PSScriptRoot\PSCandy.ps1" -Force

("Circle","Dots","Line","Square","Bubble","Arrow","Pulse") | ForEach-Object {
  $spinner = [Spinner]::new($_)
  $spinner.Start("$($_) Testing Spinner for 5 seconds ...")
  start-sleep -Milliseconds 5000
  
  $Spinner.Stop()
} 