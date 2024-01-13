import Foundation
import XCTest

@testable import RationalModule

final class AdditiveArithmaticTests: XCTestCase {
	func test_adding_zero_to_any_rational_number_returns_the_same_number() {
		for _ in 0..<20 {
			let r = Rational(Int.random(in: -100...100), Int.random(in: 1...100))
			XCTAssertEqual(r + .zero, r)
		}
	}

	func test_random_additions() {
		/// Random test cases created using the following Python script:
		///
		/// ```
		/// import random
		/// from fractions import Fraction
		///
		/// # Generate a list of random fractions
		/// fractions = [Fraction(random.randint(-10, 10), random.randint(1, 10)) for _ in range(20)]
		///
		/// # Add them in pairs and print the result
		/// for i in range(0, len(fractions), 2):
		///    sum_of_pair = fractions[i] + fractions[i+1]
		///    print(f"(Rational({fractions[i].numerator}, {fractions[i].denominator}), Rational({fractions[i+1].numerator}, {fractions[i+1].denominator}), Rational({sum_of_pair.numerator}, {sum_of_pair.denominator})),")
		/// ```

		let testCases = [
			(Rational(3), Rational(7, 10), Rational(37, 10)),
			(Rational(1, 3), Rational(1, 2), Rational(5, 6)),
			(Rational(2, 1), Rational(-3, 2), Rational(1, 2)),
			(Rational(1, 2), Rational(-1, 1), Rational(-1, 2)),
			(Rational(2, 1), Rational(2, 7), Rational(16, 7)),
			(Rational(-1, 1), Rational(-7, 8), Rational(-15, 8)),
			(Rational(-3, 2), Rational(5, 3), Rational(1, 6)),
			(Rational(-2, 7), Rational(7, 5), Rational(39, 35)),
			(Rational(-2, 1), Rational(7, 8), Rational(-9, 8)),
			(Rational(-4, 1), Rational(-4, 3), Rational(-16, 3)),
		]

		for (f1, f2, result) in testCases {
			XCTAssertEqual(f1 + f2, result)
		}
	}

	func test_random_subtractions() {
		/// Random test cases created using the following Python script:
		///
		/// ```
		/// import random
		/// from fractions import Fraction
		///
		/// # Generate a list of random fractions
		/// fractions = [Fraction(random.randint(-10, 10), random.randint(1, 10)) for _ in range(20)]
		///
		/// # Add them in pairs and print the result
		/// for i in range(0, len(fractions), 2):
		///    sum_of_pair = fractions[i] - fractions[i+1]
		///    print(f"(Rational({fractions[i].numerator}, {fractions[i].denominator}), Rational({fractions[i+1].numerator}, {fractions[i+1].denominator}), Rational({sum_of_pair.numerator}, {sum_of_pair.denominator})),")
		/// ```

		let testCases = [
			(Rational(1, 1), Rational(-1, 4), Rational(5, 4)),
			(Rational(0, 1), Rational(9, 4), Rational(-9, 4)),
			(Rational(5, 7), Rational(1, 2), Rational(3, 14)),
			(Rational(-5, 4), Rational(10, 1), Rational(-45, 4)),
			(Rational(3, 2), Rational(10, 1), Rational(-17, 2)),
			(Rational(-5, 2), Rational(-3, 4), Rational(-7, 4)),
			(Rational(-3, 5), Rational(-1, 4), Rational(-7, 20)),
			(Rational(0, 1), Rational(0, 1), Rational(0, 1)),
			(Rational(3, 7), Rational(-8, 9), Rational(83, 63)),
			(Rational(-1, 3), Rational(-4, 5), Rational(7, 15)),
		]

		for (f1, f2, result) in testCases {
			XCTAssertEqual(f1 - f2, result)
		}
	}
}
