import XCTest

@testable import RationalModule

final class IntegerLiteralTests: XCTestCase {
	func `test_literal_two_conversion`() throws {
		let r: Rational<Int> = 2
		XCTAssertEqual(r.numerator, 2)
		XCTAssertEqual(r.denominator, 1)
	}
}
