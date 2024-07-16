# Structure of psCandy

## Enums

### Styles

This enum contains the differents font style available to render string on the terminal
This is a [Flags()] enum and the values can be combined.
The possible values are :
Normal, Underline, Bold, Reversed, Strike, Italic, Reverse

### Align

These are the 3 horizontal alignments possible :
Left, Center or Right

## Classes

### [candyColor]

[candyColor] is a class with 3 properties : r, g, b.
The class is used as a structure to instanciate the [Color] class.

### [Colors]

[Colors] is a helper class that only has static properties.
Each property represents a color and return a [candyColor] object that can be used to create a [Color] Object.

``` powershell
  $color = [Color]::New([colors]::YellowGreen())
```

### [Color]
This class has 3 static functions :
- Color16
- ColorRGB
- Pick

## Functions

### Write-Candy
