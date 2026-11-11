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
    var sum: Element {
        reduce(0, +)
    }
}

extension String {
    subscript(i: Int) -> Character {
        self[index(startIndex, offsetBy: i)]
    }
}

extension Character {
    var uint: UInt? {
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
    ].sum.modulo(7))!
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

struct ErrorString: Error, CustomStringConvertible {
    let description: String
    init(_ description: String) { self.description = description }
}

func parseDate(_ date: String) throws -> Date {
    guard date.count == 10 else {
        throw ErrorString("Expected 10 chars, but got \(date.count).") }
    guard [4,7].allSatisfy({ date[$0] == "-" }) else {
        throw ErrorString("Hyphens (-) are not used to separate fields correctly.") }

    let yearDigits = date.prefix(4).compactMap(\.uint)
    guard yearDigits.count == 4 else {
        throw ErrorString("Year is invalid. Should be of format YYYY with 4 digits.") }
    let year: UInt = yearDigits.reduce(0) { acc, x in acc * 10 + x }

    let monthDigits = date.dropFirst(5).prefix(2).compactMap(\.uint)
    guard monthDigits.count == 2 else {
        throw ErrorString("Month is invalid. Should be of format MM with 2 digits.") }
    let monthIndex = monthDigits.reduce(0) { acc, x in acc * 10 + x }
    guard monthIndex >= 1 && monthIndex <= 12 else {
        throw ErrorString("Month is out of bounds. Should be between 01 and 12.") }
    let month = Month(rawValue: monthIndex)!

    let dayDigits = date.dropFirst(8).prefix(2).compactMap(\.uint)
    guard dayDigits.count == 2 else {
        throw ErrorString("Day is invalid. Should be of format DD with 2 digits.") }
    let day = dayDigits.reduce(0) { acc, x in acc * 10 + x }
    guard day != 0 else {
        throw ErrorString("Day cannot be 00.") }
    switch month {
    case .January, .March, .May, .July, .August, .October, .December:
        guard day <= 31 else {
            throw ErrorString("\(month) has at most 31 days.") }
    case .April, .June, .September, .November:
        guard day <= 30 else {
            throw ErrorString("\(month) has at most 30 days.") }
    case .February:
        if year.isDivisibleBy(4) {
            guard day <= 29 else {
                throw ErrorString("\(month) on a leap year has at most 29 days.") }
        } else {
            guard day <= 28 else {
                throw ErrorString("\(month) on a non-leap year has at most 28 days.") }
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
            print("Enter a date [YYYY-MM-DD]: ", terminator: "")
            guard let userResponse = readLine() else { break }

            let date: Date
            do {
                date = try parseDate(userResponse)
            } catch {
                print("Invalid date format. Reason: \(error)")
                continue
            }
            let (year, month, day) = (date.year, date.month, date.day)

            let century = yearToCentury(year)
            print("The century anchor for the \(century)\(century.ordinalSuffix) century is "
                + "\(calcCenturyAnchor(year)).")
            
            print("The dooms-weekday for \(year) is \(calcYearDoomsday(year)).")
            
            print("For \(month), its doomsday falls on the "
                + "\(month.calcDoomsday(year: year))\(day.ordinalSuffix).")

            print("Therefore, the \(day)\(day.ordinalSuffix) of \(month), \(year) "
                + "falls on a \(calcWeekday(date)).")
        }
    }
}
