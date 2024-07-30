# Write-Candy

```Write-Candy``` use ```Build-Candy``` to render an ANSI formatted string and write it to the terminal.

The syntax is :

```powershell
Write-Candy -Text $text 
  [-width $width] 
  [-Border "Normal|Rounded|Block|OuterHalf|InnerHalf|Thick|Double|Hidden"]
  [-Align Left|Center|Right]
  [-Fullscreen]
```

The ```Text``` parameter is mandatory.  It can be passed through the pipe.

Every other parameter is optionnal.

```Width``` parameter indicates the wanted width of the generated string.
if ```Fullscreen``` is used along with ```Width```, ```Fullscreen``` will have the priority.

```Border``` parameter sets the border type that will be drawn around the result string.  It can be one of the following list :

 *"Normal", "Rounded", "Block", "OuterHalf" , "InnerHalf", "Thick", "Double", "Hidden"*

```Fullscreen``` is a switch parameter.  It's presence indicates that the output will take the whole screen width.

```Align``` parameter takes a value from an Enum, which can have ```Left, Center or Right``` as value.  As the name suggest, it will align the output accordingly to the choosen direction.

```Write-Candy``` uses ```Build-Candy``` to render the string it receives and writes it on the terminal.  The function doesn't return anything.

```Write-Candy``` can output a multiline formatted string.  
To produce multi-lines output, simply add "`n" where the string needs to be splitted.  
When using multi-lines output in one ```Write-Candy``` call, the optionnal parameters are applied to each line and are the same.  
To produce a multi-line output, with distinct formatting per line, one have to build a string using multiple ```Build-Candy``` calls and output the result with ```Write-Candy```

