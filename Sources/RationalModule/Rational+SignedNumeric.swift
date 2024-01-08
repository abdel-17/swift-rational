extension Rational: SignedNumeric {
	public typealias Magnitude = Self

	/// The absolute value of this value.
	///
	/// If the numerator is `T.min`, this property overflows.
	@inlinable
	public var magnitude: Self {
		Self(numerator: abs(numerator), denominator: denominator)
	}

	/// Converts the given integer to a rational value,
	/// if it can be represented exactly.
	///
	/// 	Rational<Int8>(exactly: 100)	Optional(Rational(100, 1))
	/// 	Rational<Int8>(exactly: 1_000)	nil
	///
	@inlinable
	public init?(exactly source: some BinaryInteger) {
		guard let value = T(exactly: source) else { return nil }
		self.init(value)
	}

	@inlinable
	public static func * (lhs: Self, rhs: Self) -> Self {
		let n1 = lhs.numerator
		let d1 = lhs.denominator
		let n2 = rhs.numerator
		let d2 = rhs.denominator

		let g1 = gcd(n1, d2)
		let g2 = gcd(n2, d1)
		return Self(numerator: (n1 / g1) * (n2 / g2), denominator: (d1 / g2) * (d2 / g1))
	}

	@inlinable
	public static func *= (lhs: inout Self, rhs: Self) {
		lhs = lhs * rhs
	}

	@inlinable
	public static prefix func - (operand: Self) -> Self {
		Self(numerator: -operand.numerator, denominator: operand.denominator)
	}
}
