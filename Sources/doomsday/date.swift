struct Date: Equatable {
    let year: UInt
    let month: Month
    let day: UInt
}

extension Date {
    init(_ string: String) throws {
        guard string.count == 10 else {
            throw ErrorString("Expected 10 chars, but got \(string.count).") }
        guard [4,7].allSatisfy({ string[$0] == "-" }) else {
            throw ErrorString("Hyphens (-) are not used to separate fields correctly.") }

        let yearDigits = string.prefix(4).compactMap(\.uint)
        guard yearDigits.count == 4 else {
            throw ErrorString("Year is invalid. Should be of format YYYY with 4 digits.") }
        year = yearDigits.reduce(0) { acc, x in acc * 10 + x }

        let monthDigits = string.dropFirst(5).prefix(2).compactMap(\.uint)
        guard monthDigits.count == 2 else {
            throw ErrorString("Month is invalid. Should be of format MM with 2 digits.") }
        let monthIndex = monthDigits.reduce(0) { acc, x in acc * 10 + x }
        guard monthIndex >= 1 && monthIndex <= 12 else {
            throw ErrorString("Month is out of bounds. Should be between 01 and 12.") }
        month = Month(rawValue: monthIndex)!

        let dayDigits = string.dropFirst(8).prefix(2).compactMap(\.uint)
        guard dayDigits.count == 2 else {
            throw ErrorString("Day is invalid. Should be of format DD with 2 digits.") }
        day = dayDigits.reduce(0) { acc, x in acc * 10 + x }
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
    }
}
