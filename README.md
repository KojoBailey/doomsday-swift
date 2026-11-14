# Swift Doomsday
This is a fun little project that implements John Conway's [Doomsday algorithm](https://en.wikipedia.org/wiki/Doomsday_rule) using Swift, mostly as an excuse for my first project in Swift outside of Xcode.

I originally implemented this idea in [Haskell](https://github.com/KojoBailey/doomsday-hs), but switched to Swift because it scales a lot better in terms of code architecture and niceties.

My aim is to make the most out of Swift's features to write as clean code as is not too tedious to set up. In particular, I'm writing Swift with languages like C++, C#, Mojo, and Rust in mind for comparison.

## Usage
Run the `doosmday` executable and it will prompt you to enter a date of the format `YYYY-MM-DD` - e.g., 2006-07-17 for the 17th of July, 2006 - and any invalid dates will be rejeted with a short description of what's wrong. The program will then output an explanation of the steps to calculate the day of the week for that day.

To quit the program normally, enter `q` or `quit` instead of a date.

### Example
```
Enter a date [YYYY-MM-DD]: 2006-07-17

The century anchor for the 21st century is 2 -> Tuesday.

The dooms-weekday for 2006 can be calculated with the sum of 4 components:
	1. century anchor = 2
	2. yy = 2006 % 100 = 6 => yy / 12 = 6 / 12 = 0
	3. rem = yy % 12 = 6 % 12 = 6
	4. rem / 4 = 6 / 4 = 1
	sum = 2 + 0 + 6 + 1 = 9
	sum % 7 = 9 % 7 = 2 -> Tuesday

For July, its mnemonic 7/11 tells us its doomsday falls on Tuesday the 11th.

Taking the difference from the doomsday, we get 17 - 11 = 6.

The doomsday is a Tuesday -> 2, so 6 + 2 = 8 and 8 % 7 = 1 -> Monday.

Therefore, the 17th of July, 2006 falls on a Monday.
```
