extension Rational: ExpressibleByIntegerLiteral {
	public typealias IntegerLiteralType = T.IntegerLiteralType

	@inlinable
	public init(integerLiteral value: IntegerLiteralType) {
		self.init(T(integerLiteral: value))
	}
}

extension Rational {
	/// Converts the given integer value to a rational.
	///
	/// Equivalent to creating a rational value with numerator
	/// equal to `value` and denominator `1`.
	@inlinable
	public init(_ value: T) {
		self.init(numerator: value, denominator: 1)
	}
}
