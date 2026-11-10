enum Day {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

enum Month {
    case January
    case February
    case March
    case April
    case May
    case June
    case July
    case August
    case September
    case October
    case November
    case December
}

extension BinaryInteger {
    func modulo(_ divisor: Self) -> Self {
        let remainder = self % divisor
        return remainder < 0 ? remainder + divisor : remainder
    }
}

func getCenturyAnchor(_ century: UInt) -> Day {
    switch century.modulo(4) {
    case 0: .Wednesday
    case 1: .Tuesday
    case 2: .Sunday
    case 3: .Friday
    default: fatalError("Unreachable")
    }
}

// func getYearAnchor(_ year: UInt) -> Day {
// }

@main
struct doomsday {
    static func main() {
        print(getCenturyAnchor(21))
    }
}
