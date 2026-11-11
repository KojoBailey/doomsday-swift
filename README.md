# Swift Doomsday
This is a fun little project that implements John Conway's [Doomsday algorithm](https://en.wikipedia.org/wiki/Doomsday_rule) using Swift, mostly as an excuse for my first project in Swift outside of Xcode.

I originally implemented this idea in [Haskell](https://github.com/KojoBailey/doomsday-hs), but switched to Swift because it scales a lot better in terms of code architecture and niceties.

My aim is to make the most out of Swift's features to write as clean code as is not too tedious to set up. In particular, I'm writing Swift with languages like C++, C#, Mojo, and Rust in mind for comparison.

## Example Output
> [!NOTE]
> This is a WIP and is yet to be fully implemented.

```
Enter a date [YYYY-MM-DD]: 2006-07-17

The century anchor for the 21st century is 2 -> Tuesday.

The dooms-weekday for 2006 can be calculated with the sum of 4 components:
    1. century anchor = 2
    2. x = 2006 / 100 = 6 => x / 12 = 6 / 12 = 0
    3. r = x % 12 = 6 % 12 = 6
    4. r / 4 = 6 / 4 = 1
    sum = 2 + 0 + 6 + 1 = 9
    sum % 7 = 9 % 7 = 2 -> Tuesday

For July, the mnemonic 7-11 tells us its doomsday falls on Tuesday the 11th.

Taking the difference from the doomsday, we get 17 - 11 = 6.

The 11th is a Tuesday -> 2, so 6 + 2 = 8 and 8 % 7 = 1 -> Monday.

Therefore, the 17th of July, 2006 falls on a Monday.
```

## Template Output
```
Enter a date [YYYY-MM-DD]: <USER DATE INPUT>

The century anchor for the <CENTURY-th> century is <CENTURY ANCHOR> -> <CENTURY ANCHOR WEEKDAY>.

The dooms-weekday for <YEAR> can be calculated with the sum of 4 components:
    1. century anchor = <COMPONENT 1>
    2. yy = <YEAR> / 100 = <YY> => yy / 12 = <YY> / 12 = <COMPONENT 2>
    3. r = yy % 12 = <YY> % 12 = <COMPONENT 3>
    4. r / 4 = <COMPONENT 3> / 4 = <COMPONENT 4>
    sum = <COMPONENT 1> + <COMPONENT 2> + <COMPONENT 3> + <COMPONENT 4> = <SUM>
    sum % 7 = <SUM> % 7 = <DOOMS-WEEKDAY INDEX> -> <DOOMS-WEEKDAY>

For <MONTH>, the mnemonic <MNEMONIC> tells us its doomsday falls on <DOOMS-WEEKDAY> the <DOOMSDAY-th>.

Taking the difference from the doomsday, we get <DAY> - <DOOMSDAY> = <DIFFERENCE>.

The <DOOMSDAY-th> is a <DOOMS-WEEKDAY> -> <DOOMS-WEEKDAY INDEX>,
so <DIFFERENCE> + <DOOMS-WEEKDAY INDEX> = <DAY SUM> and <DAY SUM> % 7 = <WEEKDAY INDEX> -> <WEEKDAY>.

Therefore, the <DAY-th> of <MONTH>, <YEAR> falls on a <WEEKDAY>.
```
