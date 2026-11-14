extension BinaryInteger {
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

    var ordinal: String {
        "\(self)\(ordinalSuffix)"
    }

    func modulo(_ divisor: Self) -> Self {
        let remainder = self % divisor
        return if remainder < 0 { remainder + divisor } else { remainder }
    }

    func isDivisibleBy(_ divisor: Self) -> Bool {
        self.modulo(divisor) == 0
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
