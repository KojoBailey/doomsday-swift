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

func produceSteps(date: Date) -> [[String]] {
    var paragraphs = [[String]]()

    let (year, month, day) = (date.year, date.month, date.day)

    let century = yearToCentury(year)
    let yearAnchor = calcYearAnchor(year)
    paragraphs.append([
        "The century anchor for the \(century.ordinal) century is \(yearAnchor.rawValue) -> \(yearAnchor).",
    ])

    let last2Digits = year.modulo(100)
    let remainder = last2Digits % 12
    let sum = yearAnchor.rawValue + (last2Digits / 12) + remainder + (remainder / 4)
    let yearDoomsday = calcYearDoomsday(year)
    paragraphs.append([
        "The dooms-weekday for \(year) can be calculated with the sum of 4 components:",
        "\t1. century anchor = \(yearAnchor.rawValue)",
        "\t2. yy = \(year) % 100 = \(last2Digits) => yy / 12 = \(last2Digits) / 12 = \(last2Digits / 12)",
        "\t3. rem = yy % 12 = \(last2Digits) % 12 = \(remainder)",
        "\t4. rem / 4 = \(remainder) / 4 = \(remainder / 4)",
        "\tsum = \(yearAnchor.rawValue) + \(last2Digits / 12) + \(remainder) + \(remainder / 4) = \(sum)",
        "\tsum % 7 = \(sum) % 7 = \(yearDoomsday.rawValue) -> \(yearDoomsday)",
    ])

    let monthDoomsdate = month.calcDoomsday(year: year)
    let mnemonic = "\(month.rawValue)/\(monthDoomsdate)"
    paragraphs.append([
        "For \(month), its mnemonic \(mnemonic) tells us its doomsday falls on \(yearDoomsday) the "
            + "\(monthDoomsdate.ordinal).",
    ])

    let difference = day.differenceFrom(monthDoomsdate)
    paragraphs.append([
        "Taking the difference from the doomsday, we get "
            + "\(max(day, monthDoomsdate)) - \(min(day, monthDoomsdate)) = \(difference).",
    ])

    let daySum = difference + yearDoomsday.rawValue
    let weekdayIndex = daySum % 7
    paragraphs.append([
        "The doomsday is a \(yearDoomsday) -> \(yearDoomsday.rawValue), so "
            + "\(difference) + \(yearDoomsday.rawValue) = \(daySum) and "
            + "\(daySum) % 7 = \(weekdayIndex) -> \(Weekday(rawValue: weekdayIndex)!).",
    ])

    paragraphs.append([
        "Therefore, the \(day.ordinal) of \(month), \(year) "
            + "falls on a \(calcWeekday(date)).",
    ])

    return paragraphs
}

@main
struct doomsday {
    static func main() {
        while true {
            print("Enter a date [YYYY-MM-DD]: ", terminator: "")
            guard let userResponse: String = readLine() else {
                break
            }

            if ["q", "quit"].contains(userResponse) {
                break
            }

            let date: Date
            do {
                date = try Date(userResponse)
            } catch {
                print("Invalid date format. Reason: \(error)")
                continue
            }

            print()
            for paragraph in produceSteps(date: date) {
                paragraph.forEach { print($0) }
                print()
            }
            print()
        }
    }
}
