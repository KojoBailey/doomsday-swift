extension BinaryInteger {
    func modulo(_ divisor: Self) -> Self {
        let remainder = self % divisor
        return if remainder < 0 { remainder + divisor } else { remainder }
    }

    func isDivisibleBy(_ divisor: Self) -> Bool {
        self.modulo(divisor) == 0
    }

    var ordinalSuffix: String {
        if (11...13).contains(self.modulo(100)) { "th" } else {
            switch self.modulo(10) {
            case 1 : "st"
            case 2 : "nd"
            case 3 : "rd"
            default: "th"
            }
        }
    }
}

extension UnsignedInteger {
    func differenceFrom(_ x: Self) -> Self {
        if self > x { self - x } else { x - self }
    }
}

extension Sequence where Element: Numeric {
    func sum() -> Element {
        reduce(0, +)
    }
}

extension String {
    subscript(i: Int) -> Character {
        self[index(startIndex, offsetBy: i)]
    }
}

extension Character {
    func toUInt() -> UInt? {
        switch self {
        case "0": 0
        case "1": 1
        case "2": 2
        case "3": 3
        case "4": 4
        case "5": 5
        case "6": 6
        case "7": 7
        case "8": 8
        case "9": 9
        default: nil
        }
    }
}

enum Weekday: UInt {
    case Monday    = 1
    case Tuesday   = 2
    case Wednesday = 3
    case Thursday  = 4
    case Friday    = 5
    case Saturday  = 6
    case Sunday    = 0
}

enum Month: UInt {
    case January   = 01
    case February  = 02
    case March     = 03
    case April     = 04
    case May       = 05
    case June      = 06
    case July      = 07
    case August    = 08
    case September = 09
    case October   = 10
    case November  = 11
    case December  = 12

    func calcDoomsday(year: UInt) -> UInt {
        let isLeapYear = year.isDivisibleBy(4)
        return switch self {
        case .January  : if isLeapYear { 04 } else { 03 }
        case .February : if isLeapYear { 29 } else { 28 }
        case .March    : 14
        case .April    : 04
        case .May      : 09
        case .June     : 06
        case .July     : 11
        case .August   : 08
        case .September: 05
        case .October  : 10
        case .November : 07
        case .December : 12
        }
    }
}

func calcCenturyAnchor(_ century: UInt) -> Weekday {
    switch century.modulo(4) {
    case 0: .Wednesday
    case 1: .Tuesday
    case 2: .Sunday
    case 3: .Friday
    default: fatalError("Unreachable")
    }
}

func yearToCentury(_ year: UInt) -> UInt {
    (year / 100) + 1
}

func calcYearAnchor(_ year: UInt) -> Weekday {
    calcCenturyAnchor(yearToCentury(year))
}

func calcYearDoomsday(_ year: UInt) -> Weekday {
    let last2Digits = year.modulo(100)
    let remainder = last2Digits.modulo(12) 
    return Weekday(rawValue: [
        calcYearAnchor(year).rawValue,
        last2Digits / 12,
        remainder,
        remainder / 4,
    ].sum().modulo(7))!
}

struct Date: Equatable {
    let year: UInt
    let month: Month
    let day: UInt
}

func calcWeekday(year: UInt, month: Month, day: UInt) -> Weekday {
    Weekday(rawValue: 
        (day.differenceFrom(month.calcDoomsday(year: year)) + calcYearDoomsday(year).rawValue).modulo(7)
    )!
}

func calcWeekday(_ date: Date) -> Weekday {
    calcWeekday(year: date.year, month: date.month, day: date.day)
}

func parseDate(_ date: String) -> Date? {
    if date.count != 10 {
        return nil
    }
    for i in [0,1,2,3,5,6,8,9] {
        if !(date[i].isASCII && date[i].isNumber) {
            return nil
        }
    }
    if !(date[4] == "-" && date[7] == "-") {
        return nil
    }

    let year: UInt = (date[0].toUInt()! * 1000)
        + (date[1].toUInt()! * 100)
        + (date[2].toUInt()! * 10)
        + date[3].toUInt()!
    let monthIndex = (date[5].toUInt()! * 10) + date[6].toUInt()!
    if monthIndex == 0 || monthIndex > 12 {
        return nil
    }
    let month = Month(rawValue: monthIndex)!
    let day: UInt = (date[8].toUInt()! * 10) + date[9].toUInt()!
    if day == 0 {
        return nil
    }
    switch month {
    case .January, .March, .May, .July, .August, .October, .December:
        if day > 31 {
            return nil
        }
    case .April, .June, .September, .November:
        if day > 30 {
            return nil
        }
    case .February:
        if (year.isDivisibleBy(4) && day > 29) || (!year.isDivisibleBy(4) && day > 28) {
            return nil
        }
    }
    return Date(
        year: year,
        month: month,
        day: day,
    );
}

@main
struct doomsday {
    static func main() {
        while true {
            print("Enter a date (YYYY-MM-DD): ", terminator: "")
            guard let userResponse = readLine() else { break }
            guard let date = parseDate(userResponse) else {
                print("Invalid date format. Try again with YYYY-MM-DD.")
                continue
            }

            let century = yearToCentury(date.year)
            print("The century anchor for the \(century)\(century.ordinalSuffix) century is "
                + "\(calcCenturyAnchor(date.year)).")
            
            print("The dooms-weekday for \(date.year) is \(calcYearDoomsday(date.year)).")
            
            print("For \(date.month), its doomsday falls on the "
                + "\(date.month.calcDoomsday(year: date.year))\(date.day.ordinalSuffix).")

            print("Therefore, the \(date.day)\(date.day.ordinalSuffix) of \(date.month), \(date.year) "
                + "falls on a \(calcWeekday(date)).")
        }
    }
}
