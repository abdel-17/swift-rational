import XCTest

@testable import RationalModule

final class FractionTests: XCTestCase {
	func test_2_over_4_returns_1_over_2() throws {
		let r = Rational(2, 4)
		XCTAssertEqual(r.numerator, 1)
		XCTAssertEqual(r.denominator, 2)
	}

	func test_2_over_2_returns_1_over_1() throws {
		let r = Rational(2, 2)
		XCTAssertEqual(r.numerator, 1)
		XCTAssertEqual(r.denominator, 1)
	}

	func test_1_over_negative_3_returns_negative_1_over_3() throws {
		let r = Rational(1, -3)
		XCTAssertEqual(r.numerator, -1)
		XCTAssertEqual(r.denominator, 3)
	}

	func test_6_over_3_returns_2_over_1() throws {
		let r = Rational(6, 3)
		XCTAssertEqual(r.numerator, 2)
		XCTAssertEqual(r.denominator, 1)
	}

	func test_0_over_int_min_returns_0_over_1() throws {
		let r = Rational(0, Int.min)
		XCTAssertEqual(r.numerator, 0)
		XCTAssertEqual(r.denominator, 1)
	}

	func test_int_min_over_int_min_returns_1_over_1() throws {
		let r = Rational(Int.min, Int.min)
		XCTAssertEqual(r.numerator, 1)
		XCTAssertEqual(r.denominator, 1)
	}
}
