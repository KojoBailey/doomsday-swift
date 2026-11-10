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
    #expect(calcMonthDoomsday(.January,   year: 2000) == 04)
    #expect(calcMonthDoomsday(.January,   year: 2001) == 03)
    #expect(calcMonthDoomsday(.February,  year: 2000) == 29)
    #expect(calcMonthDoomsday(.February,  year: 2001) == 28)
    #expect(calcMonthDoomsday(.March,     year: 2000) == 14)
    #expect(calcMonthDoomsday(.April,     year: 2000) == 04)
    #expect(calcMonthDoomsday(.May,       year: 2000) == 09)
    #expect(calcMonthDoomsday(.June,      year: 2000) == 06)
    #expect(calcMonthDoomsday(.July,      year: 2000) == 11)
    #expect(calcMonthDoomsday(.August,    year: 2000) == 08)
    #expect(calcMonthDoomsday(.September, year: 2000) == 05)
    #expect(calcMonthDoomsday(.October,   year: 2000) == 10)
    #expect(calcMonthDoomsday(.November,  year: 2000) == 07)
    #expect(calcMonthDoomsday(.December,  year: 2000) == 12)
}
