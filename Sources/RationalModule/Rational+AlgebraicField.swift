import RealModule

extension Rational: AlgebraicField {
	/// The multiplicative inverse of this value, if it can be represented.
	///
	/// If the numerator is either `0` or `T.min`, this property is `nil`.
	@inlinable
	public var reciprocal: Self? {
		// The reciprocal of `T.min/d` is `-d/-T.min`, which overflows.
		guard !isZero && numerator != T.min else { return nil }

		var numerator = self.denominator
		var denominator = self.numerator

		if denominator < 0 {
			numerator.negate()
			denominator.negate()
		}

		return Self(numerator: numerator, denominator: denominator)
	}

	@inlinable
	public static func / (lhs: Self, rhs: Self) -> Self {
		guard !rhs.isZero else { fatalError("Cannot divide by zero") }

		let n1 = lhs.numerator
		let d1 = lhs.denominator
		let n2 = rhs.numerator
		let d2 = rhs.denominator

		let g1 = gcd(n1, n2)
		let g2 = gcd(d2, d1)
		var numerator = (n1 / g1) * (d2 / g2)
		var denominator = (d1 / g2) * (n2 / g1)

		if denominator < 0 {
			numerator.negate()
			denominator.negate()
		}

		return Self(numerator: numerator, denominator: denominator)
	}

	@inlinable
	public static func /= (lhs: inout Self, rhs: Self) {
		lhs = lhs / rhs
	}
}
