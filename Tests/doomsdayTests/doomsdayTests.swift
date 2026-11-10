import Testing
@testable import doomsday

@Test func testModulo() async throws {
    #expect(8.modulo(3) == 2)
    #expect((-8).modulo(3) == 1)
}

@Test func testCenturyAnchor() async throws {
    #expect(calcCenturyAnchor(21) == .Tuesday)
    #expect(calcCenturyAnchor(20) == .Wednesday)
    #expect(calcCenturyAnchor(19) == .Friday)
    #expect(calcCenturyAnchor(18) == .Sunday)
}

@Test func testYearAnchor() async throws {
    #expect(calcYearAnchor(2026) == calcCenturyAnchor(21))
    #expect(calcYearAnchor(2000) == calcCenturyAnchor(21))
    #expect(calcYearAnchor(1973) == calcCenturyAnchor(20))
    #expect(calcYearAnchor(1843) == calcCenturyAnchor(19))
}

@Test func testYearDoomsday() async throws {
    #expect(calcYearDoomsday(2026) == .Saturday)
    #expect(calcYearDoomsday(2006) == .Tuesday)
    #expect(calcYearDoomsday(1973) == .Wednesday)
}

@Test func testMonthDoomsday() async throws {
    #expect(Month.January
        .calcDoomsday(year: 2000) == 04)
    #expect(Month.January
        .calcDoomsday(year: 2001) == 03)
    #expect(Month.February
        .calcDoomsday(year: 2000) == 29)
    #expect(Month.February
        .calcDoomsday(year: 2001) == 28)
    #expect(Month.March
        .calcDoomsday(year: 2000) == 14)
    #expect(Month.April
        .calcDoomsday(year: 2000) == 04)
    #expect(Month.May
        .calcDoomsday(year: 2000) == 09)
    #expect(Month.June
        .calcDoomsday(year: 2000) == 06)
    #expect(Month.July
        .calcDoomsday(year: 2000) == 11)
    #expect(Month.August
        .calcDoomsday(year: 2000) == 08)
    #expect(Month.September
        .calcDoomsday(year: 2000) == 05)
    #expect(Month.October
        .calcDoomsday(year: 2000) == 10)
    #expect(Month.November
        .calcDoomsday(year: 2000) == 07)
    #expect(Month.December
        .calcDoomsday(year: 2000) == 12)
}

@Test func testWeekday() async throws {
    #expect(calcWeekday(year: 2006, month: .July,     day: 17) == .Monday)
    #expect(calcWeekday(year: 2009, month: .November, day: 20) == .Friday)
    #expect(calcWeekday(year: 1978, month: .March,    day: 07) == .Tuesday)
}
