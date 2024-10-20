using module psCandy

[console]::OutputEncoding = [System.Text.Encoding]::UTF8
[console]::Clear()

$label = [Style]::new("Label")
$Label.SetColor([Colors]::White(), [Colors]::DarkGreen())
$Label.SetStyle([Styles]::Underline)
$lbl = $Label.Render()
$Style = [Style]::new("`n$($lbl)`n")
# $Style.SetStyle([Styles]::Underline)
$Style.SetBorder($true)
$Style.SetColor([Colors]::White(), [Colors]::DarkBlue())
$Style.setAlign([Align]::Left)
$Style.Render()
$Style.SetLabel("Center`nSecond")
$Style.setAlign([Align]::Center)
$Style.Render()
# $Style.SetWidth(50)
$Style.SetLabel("Right")
$Style.setAlign([Align]::Right)
$Style.Render()