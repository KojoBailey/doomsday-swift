# Swift Doomsday
Conway's Doomsday algorithm, implemented in Swift.

## Example Output
> [!NOTE]
> This is a WIP and is yet to be fully implemented.

```
Enter a date [YYYY-MM-DD]: 2006-07-17

The century anchor for the 21st century is 2 -> Tuesday.

The dooms-weekday for 2006 can be calculated as:
    6 / 12 = 0
    6 % 12 = 6
    6 / 4 = 1
    0 + 6 + 1 + 2 = 9
    9 % 7 = 2 -> Tuesday

For July, the mnemonic 7-11 tells us its doomsday falls on the 11th.

Taking the difference from the doomsday, we get 17 - 11 = 6.

The 11th is a Tuesday -> 2, so 6 + 2 = 8 and 8 % 7 = 1 -> Monday.

Therefore, the 17th of July, 2006 falls on a Monday.
```
