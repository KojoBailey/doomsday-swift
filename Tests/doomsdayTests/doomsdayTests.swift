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
