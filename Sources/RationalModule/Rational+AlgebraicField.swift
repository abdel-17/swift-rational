import RealModule

extension Rational: AlgebraicField {
	/// The multiplicative inverse of this value, if it can be represented.
	///
	/// If the numerator is either `0` or `T.min`, this property is `nil`.
	public var reciprocal: Self? {
		// The reciprocal of `T.min/d` is `-d/-T.min`, which overflows.
		guard !isZero && numerator != T.min else { return nil }
		return if isNegative {
			Self(numerator: -denominator, denominator: -numerator)
		} else {
			Self(numerator: denominator, denominator: numerator)
		}
	}

	public static func / (lhs: Self, rhs: Self) -> Self {
		let n1 = lhs.numerator
		let d1 = lhs.denominator
		let n2 = rhs.numerator
		let d2 = rhs.denominator

		guard !rhs.isZero else { fatalError("Cannot divide by zero") }

		let g1 = gcd(n1, n2)
		let g2 = gcd(d2, d1)
		let numerator = (n1 / g1) * (d2 / g2)
		let denominator = (d1 / g2) * (n2 / g1)

		return if denominator < 0 {
			Self(numerator: -numerator, denominator: -denominator)
		} else {
			Self(numerator: numerator, denominator: denominator)
		}
	}

	public static func /= (lhs: inout Self, rhs: Self) {
		lhs = lhs / rhs
	}
}
