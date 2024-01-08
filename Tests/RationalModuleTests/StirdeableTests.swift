import XCTest

@testable import RationalModule

final class StrideableTests: XCTestCase {
	func test_stride_0_to_1_step_1_over_4() throws {
		let values: [Rational] = Array(stride(from: 0, to: 1, by: .init(1, 4)))
		XCTAssertEqual(values, [0, .init(1, 4), .init(1, 2), .init(3, 4)])
	}

	func test_stride_0_through_1_step_1_over_4() throws {
		let values: [Rational] = Array(stride(from: 0, through: 1, by: .init(1, 4)))
		XCTAssertEqual(values, [0, .init(1, 4), .init(1, 2), .init(3, 4), 1])
	}
}
