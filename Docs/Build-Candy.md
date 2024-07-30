### Build-Candy

```Build-Candy``` is the fundation function that renders an ANSI string based on a tag-formated input.

The syntax is :

```powershell
Build-Candy -Text $text 
  [-width $width] 
  [-Border "Normal|Rounded|Block|OuterHalf|InnerHalf|Thick|Double|Hidden"]
  [-Align Left|Center|Right]
  [-Fullscreen]
```

The ```Text``` parameter is mandatory.  It can be passed through the pipe.

Every other parameter is optionnal.

```Width``` parameter indicates the wanted width of the generated string.
if ```Fullscreen``` is used along with ```Width```, ```Fullscreen``` will have the priority.

```Fullscreen``` is a switch parameter.  It's presence indicates that the output will take the whole screen width.

```Align``` parameter takes a value from an Enum, which can have ```Left, Center or Right``` as value.  As the name suggest, it will align the output accordingly to the choosen direction.

