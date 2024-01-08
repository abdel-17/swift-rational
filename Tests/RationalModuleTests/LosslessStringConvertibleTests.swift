import XCTest

@testable import RationalModule

final class LosslessStringConvertibleTests: XCTestCase {
	func `test_2_returns_2_over_1`() throws {
		let r = Rational<Int>("2")
		XCTAssertNotNil(r)
		XCTAssertEqual(r?.numerator, 2)
		XCTAssertEqual(r?.denominator, 1)
	}

	func `test_2_over_4_returns_1_over_2`() throws {
		let r = Rational<Int>("2/4")
		XCTAssertNotNil(r)
		XCTAssertEqual(r?.numerator, 1)
		XCTAssertEqual(r?.denominator, 2)
	}

	func `test_whitespace_returns_nil`() throws {
		let r = Rational<Int>("2 / 3")
		XCTAssertNil(r)
	}

	func `test_missing_denominator_returns_nil`() throws {
		let r = Rational<Int>("2/")
		XCTAssertNil(r)
	}

	func `test_division_by_0_returns_nil`() throws {
		let r = Rational<Int>("1/0")
		XCTAssertNil(r)
	}

	func `test_128_over_2_returns_nil_for_int8`() throws {
		let r = Rational<Int8>("128/2")
		XCTAssertNil(r)
	}
}
