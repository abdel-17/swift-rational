import XCTest

@testable import RationalModule

final class StringConvertibleTests: XCTestCase {
	func `test_one_over_two_string_conversion`() throws {
		let r = Rational(numerator: 1, denominator: 2)
		XCTAssertEqual(r.description, "1/2")
	}
	
	func `test_one_over_one_string_conversion`() throws {
		let r = Rational(numerator: 1, denominator: 1)
		XCTAssertEqual(r.description, "1")
	}
	
	func `test_one_over_two_debug_string_conversion`() throws {
		let r = Rational(numerator: 1, denominator: 2)
		XCTAssertEqual(r.debugDescription, "Rational<Int>(1, 2)")
	}
	
	func `test_one_over_two_int32_debug_string_conversion`() throws {
		let r = Rational<Int32>(numerator: 1, denominator: 2)
		XCTAssertEqual(r.debugDescription, "Rational<Int32>(1, 2)")
	}
}
