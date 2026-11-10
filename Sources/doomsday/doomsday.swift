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

extension BinaryInteger {
    func modulo(_ divisor: Self) -> Self {
        let remainder = self % divisor
        return if remainder < 0 { remainder + divisor } else { remainder }
    }

    func isDivisibleBy(_ divisor: Self) -> Bool {
        self.modulo(divisor) == 0
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

func calcYearAnchor(_ year: UInt) -> Weekday {
    calcCenturyAnchor((year / 100) + 1)
}

extension Sequence where Element: Numeric {
    func sum() -> Element {
        reduce(0, +)
    }
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

func difference(_ x: UInt, _ y: UInt) -> UInt {
    if x == y { 0 } else { max(x, y) - min(x, y) }
}

func calcWeekday(year: UInt, month: Month, day: UInt) -> Weekday {
    return Weekday(rawValue: 
        (difference(day, month.calcDoomsday(year: year)) + calcYearDoomsday(year).rawValue).modulo(7)
    )!
}

@main
struct doomsday {
    static func main() {
    }
}
