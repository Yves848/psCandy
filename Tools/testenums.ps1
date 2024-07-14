using module psCandy

$methodInfo = [colors].GetMethod("Blue", [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::Public)
[candyColor]$candycolor = $methodinfo.Invoke($null,$null)
[Color]$color = [Color]::new($candycolor)
$color.render("test")
