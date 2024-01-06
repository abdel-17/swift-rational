import XCTest

@testable import RationalModule

final class FractionTests: XCTestCase {
	func `test_two_over_four_equals_half`() throws {
		let r = Rational(2, 4)
		XCTAssertEqual(r.numerator, 1)
		XCTAssertEqual(r.denominator, 2)
	}

	func `test_two_over_two_equals_one`() throws {
		let r = Rational(2, 2)
		XCTAssertEqual(r.numerator, 1)
		XCTAssertEqual(r.denominator, 1)
	}

	func `test_one_over_negative_three_equals_negative_one_third`() throws {
		let r = Rational(1, -3)
		XCTAssertEqual(r.numerator, -1)
		XCTAssertEqual(r.denominator, 3)
	}

	func `test_six_over_three_equals_two`() throws {
		let r = Rational(6, 3)
		XCTAssertEqual(r.numerator, 2)
		XCTAssertEqual(r.denominator, 1)
	}

	func `test_zero_over_int_min_equals_zero`() throws {
		let r = Rational(0, Int.min)
		XCTAssertEqual(r.numerator, 0)
		XCTAssertEqual(r.denominator, 1)
	}

	func `test_int_min_over_int_min_equals_one`() throws {
		let r = Rational(Int.min, Int.min)
		XCTAssertEqual(r.numerator, 1)
		XCTAssertEqual(r.denominator, 1)
	}
}
