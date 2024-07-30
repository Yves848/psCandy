### Formatting tags

psCandy is a "tag" based library that renders colorfull output in the terminal.

There a several tag types :

## Color Tags

The color tags can be 8 or 16 bits.

8 bits tags are the basic ANSI color codes from 0 to 255.

![Ansi colors](../Images/Ansi.png)

To specify an 8bit color code, simply enclose the number in the opening and closing tags.

Example :

```powershell
  Build-Candy "<4>This is a blue String</4>"
```

Result : ![](./Images/Build-Candy1.png)

The "<>" tags are used to specify the foreground color where "[]" are used to fix the background color of the enclosed string.

Example :

```powershell
  Build-Candy "<4>[195]This is a blue String[/195]</4>"
```

Result : ![](./Images/Build-Candy2.png)

The foreground ("<>") and background ([]) tags can be used anywhere in the string that as to be formatted.
There is also no particular order between foreground and background.
An opening tag is where the formatting begins and a closing tag is where it ends.

The **only** requirement is to **always** close an open tag.

This example is valid :

```powershell
  Build-Candy "<4>This is a blue [195]on white</4> <55> and purple</55>[/195] string"
```

The result will be : ![](./Images/Build-Candy3.png)
## Style Tags