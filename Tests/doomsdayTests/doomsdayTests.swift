import Testing
@testable import doomsday

@Test func testAnchorFunctions() async throws {
    #expect(getCenturyAnchor(21) == .Tuesday)
    #expect(getCenturyAnchor(20) == .Wednesday)
    #expect(getCenturyAnchor(19) == .Friday)
    #expect(getCenturyAnchor(18) == .Sunday)
}

@Test func testModulo() async throws {
    #expect(8.modulo(3) == 2)
    #expect((-8).modulo(3) == 1)
}
