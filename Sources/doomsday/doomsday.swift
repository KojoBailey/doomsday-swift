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
}

extension BinaryInteger {
    func modulo(_ divisor: Self) -> Self {
        let remainder = self % divisor
        return remainder < 0 ? remainder + divisor : remainder
    }
}

func calcCenturyAnchor(_ century: UInt) -> Day {
    switch century.modulo(4) {
    case 0: .Wednesday
    case 1: .Tuesday
    case 2: .Sunday
    case 3: .Friday
    default: fatalError("Unreachable")
    }
}

func calcYearAnchor(_ year: UInt) -> Day {
    calcCenturyAnchor((year / 100) + 1)
}

@main
struct doomsday {
    static func main() {
    }
}
