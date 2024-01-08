extension Rational: Equatable {
	@inlinable
	public static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
	}
}
