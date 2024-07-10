# psCandy

![Header](./Images/header.png)

A Powershell Module to produce eye-candy outputs in the terminal.

I used Charmbracelet/gum to enhance my powershell scripts, but some limitations / behaviours made it difficult to use for me.

So I decided to write my own visual library, 100% in powershell.

So far, 3 classes are enable :
- Color
- Spinner
- List

## Color
The class provides 2 static metods :
- Color16
- ColorRBG

### Color16
```
  [Color]::Color16([String]$text,[Int]$ForegroundColor,[Int]$BackgroundColor,[Switch]$Underline,[Switch]$Strike)
```
This function returns a string with ansi codes to format the text passed to the function.



The function will apply formatting based on the available parameters

Here is a table with the color values accepted by the function

![](./Images/Ansi.png)

Examples :
```
[color]::color16("this is a test",45,-1,$false,$false)
```
Result :

![](./Images/test1.png)

```
[color]::color16("this is a test",127,-1,$true,$false)
```
Result :
![](./Images/test2.png)

```
[color]::color16("this is a test",88,188,$true,$false)
```
Result :

![](./Images/test3.png)

### ColorRGB
```
[color]::colorRGB ([string]$Text,[System.Drawing.Color]$Foreground,[System.Drawing.Color]$Background,[switch]$Underline,[switch]$Strike)
```
Similar to the Color16 function, but takes 2 [System.Drawing.Color] in parameters.
The output is pretty mych the same, except that it's not limiter to 256 colors.

Examples :
```
[color]::colorRGB("This is a RGB Test",[System.Drawing.Color]::DarkViolet,[System.Drawing.Color]::Empty,$False,$False)
```
Result :

![](./Images/test4.png)

***
But the real deal is when the class is instanciated.
The Render method, like the name suggests, reders an ansi colored string.
```
  $DeepPink = [Color]::new([System.Drawing.Color]::DeepPink)
  $DeepPink.render("Test from Object")
```
Result :

![](./Images/test5.png)

In addition, styles can be modified .....
```
  $DeepPink.style = [Styles]::Underline
  $DeepPink.render("Test from Object Underline :)")
```
Result :

![](./Images/test6.png)

Styles can be mixed :
```
  $DeepPink.style = ([Styles]::Underline -bor [Styles]::Strike)
  $DeepPink.render("Test from Object Underline and strike :)")
```
Result :

![](./Images/test7.png)

This method is geat to build a theme for your scripts.
This is how the other classes of the module use the [color] Classe.

## List
The list class is a generic list component that takes a [System.Collections.Generic.List[ListItem] in input and displays the items in a pretty way.

```
  [ListItem]
```
Is a class that allows [List] to display and processes the list.

[ListItem] has 4 constructor overloads :
```
  ListItem([string]$text,[PSCustomObject]$value)
```
The simpliest.  Create a [ListItem] with only a [string]$Text and a [PSCustomObject]$Value.
Even the $Value can be $null.

```
ListItem([string]$text,[PSCustomObject]$value,[string]$Icon)
```
This constructor allows the use of an icon that will be draw at the beginning of the line.

Example :
```
Import-Module "$((Get-Location).Path)\classes.ps1" -Force

$spinner = [Spinner]::new("Dots")
$Spinner.Start("Loading List...")
Start-Sleep -Seconds 5
$Spinner.Stop()

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 
$items = [System.Collections.Generic.List[ListItem]]::new()
$items.Add([ListItem]::new("Banana", 1,"🍌"))
$items.Add([ListItem]::new("Apple", 2, "🍎"))
$items.Add([ListItem]::new("Mandarine", 3, "🍊"))
$items.Add([ListItem]::new("Grape Fruit", 4, "🟠"))
$items.Add([ListItem]::new("Potato", 5,"🥔"))
$items.Add([ListItem]::new("Potato 2", 6,"🥔"))
$items.Add([ListItem]::new("Potato 3", 7,"🥔"))
$items.Add([ListItem]::new("Potato 4", 8,"🥔"))
$items.Add([ListItem]::new("Potato 5", 9,"🥔"))
$items.Add([ListItem]::new("Banana 2", 10,"🍌"))
$items.Add([ListItem]::new("Apple 2", 11,"🍎"))
$items.Add([ListItem]::new("Mandarine 2", 12,"🍊"))
$items.Add([ListItem]::new("Grape Fruit 2", 13,"🟠"))
$items.Add([ListItem]::new("Potato 6", 14,"🥔"))

$list = [List]::new($items)  
$list.Display()

Remove-Module -name classes -Force
```
Result :

![](./Images/list1.gif)

```
ListItem([string]$text,[PSCustomObject]$value,[string]$Icon,[System.Drawing.Color]$Color)
```
This constructor takes a 4th parameter : The rendering color of the [ListItem]

Example :
```
param (
  [string]$Path = "..\"
)
Import-Module "$((Get-Location).Path)\classes.ps1" -Force


[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 

function getDirContent {
  param(
    [string]$path
  )
  $items = [System.Collections.Generic.List[ListItem]]::new()
  $items.Add([ListItem]::new("..", $path))
  Get-ChildItem -Path $path -File  | ForEach-Object {
    $Name = $_.Name
    $items.Add([ListItem]::new($Name, $_,"📄",[System.Drawing.Color]::Green))
  }
  Get-ChildItem -Path $path -Directory  | ForEach-Object {
    $Name = $_.Name
    $items.Add([ListItem]::new($Name,$_, "📂", [System.Drawing.Color]::OrangeRed))
  }
  return $items
}

$items = getDirContent -path $Path
$result = $null
$Theme.list.SelectedColor = [System.Drawing.Color]::yellow
while ($true) {
  $List = [List]::new($items)
  $list.SetHeight(25)
  $list.SetLimit($True)
  $choice = $List.Display()
  if ($choice) {
    if ($choice.text -eq "..") {
      $p = [System.IO.Path]::GetDirectoryName($choice.Value)
    }
    else {
      if (Test-Path -Path $choice.Value.FullName -Type Container) {
        if ($choice.chained) {
          $result = $choice.Value
          break
        } else {
          $p = $choice.Value.FullName
        }
      }
      else {
        $result = $choice.Value
        break
      }
    }
    $items = getDirContent -path $p
    $List.setItems($items)
  }
  else {
    break
  }
}
$result
```
Result :

![](./Images/list2.gif)

In this "mini" *functionnal* file explorer, the files are redered in green, with a icon "📄" and the Folders are in Orange with an icon "📂"

```
ListItem([string]$text,[PSCustomObject]$value,[System.Drawing.Color]$Color)
```
This last constructor only take a [ListItem] color, but no icon.

Example :
```
Import-Module "$((Get-Location).Path)\classes.ps1" -Force


[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 
$items = [System.Collections.Generic.List[ListItem]]::new()
[system.Drawing.color] | Get-Member -Static -MemberType Properties | ForEach-Object {
  
  [psCustomObject]$color = [color]::new([System.Drawing.Color]::"$($_.Name)")
  $colorName = $_.Name
  $items.Add([ListItem]::new($colorName, $color,[System.Drawing.Color]::"$($_.Name)"))
}
$List = [List]::new($items)
$list.SetHeight(25)
$List.Display()
```

Result :

![](./Images/list3.gif)


## Spinner
The Spinner is a class than can display an animated spinner while performing long tasks.
There are 7 styles of Spinners (Circle,Dots,Line,Square,Bubble,Arrow,Pulse).  By default, "Dots" is used.
The Spinner can be "themed" with the [Color] class.

Example :
```
Import-Module "$((Get-Location).Path)\classes.ps1" -Force

("Circle","Dots","Line","Square","Bubble","Arrow","Pulse") | ForEach-Object {
  $spinner = [Spinner]::new($_)
  $Spinner.Start("$($_) Testing Spinner...")
  Start-Sleep -Seconds 3
  $Spinner.Stop()
} 



Remove-Module -name classes -Force
```

Result :

![](./Images/Spinners1.gif)