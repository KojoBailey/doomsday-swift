import Testing
@testable import doomsday

@Test func testModulo() async throws {
    #expect(8.modulo(3) == 2)
    #expect((-8).modulo(3) == 1)
}

@Test func testCenturyAnchor() async throws {
    #expect(getCenturyAnchor(21) == .Tuesday)
    #expect(getCenturyAnchor(20) == .Wednesday)
    #expect(getCenturyAnchor(19) == .Friday)
    #expect(getCenturyAnchor(18) == .Sunday)
}

@Test func testYearAnchor() async throws {
    #expect(getYearAnchor(2026) == getCenturyAnchor(21))
    #expect(getYearAnchor(2000) == getCenturyAnchor(21))
    #expect(getYearAnchor(1973) == getCenturyAnchor(20))
    #expect(getYearAnchor(1843) == getCenturyAnchor(19))
}
