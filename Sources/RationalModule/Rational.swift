public struct Rational<T: SignedInteger> {
	/// The normalized numerator.
	public let numerator: T

	/// The normalized denominator.
	public let denominator: T

	/// Creates a rational number with the given numerator and denominator.
	@inlinable
	internal init(numerator: T, denominator: T) {
		assert(denominator > 0, "Denominator must be positive.")
		assert(gcd(numerator, denominator) == 1, "Fraction must normalized.")

		self.numerator = numerator
		self.denominator = denominator
	}
}

extension Rational {
	/// Creates a rational number from a fraction.
	///
	/// The result is normalized so that the numerator and denominator
	/// have no common factors and the denominator is positive.
	///
	///     Rational(2, 4)      1/2
	///     Rational(2, 2)      1
	///     Rational(1, -3)     -1/3
	///     Rational(6, 3)      2
	///
	/// - Parameters:
	///   - numerator: The numerator of the fraction.
	///   - denominator: The denominator of the fraction.
	///
	/// - Precondition: `denominator` must not be zero.
	@inlinable
	public init(_ numerator: T, _ denominator: T) {
		precondition(denominator != 0, "Denominator must not be zero.")

		let g = gcd(numerator, denominator)
		var numerator = numerator / g
		var denominator = denominator / g

		if denominator < 0 {
			numerator.negate()
			denominator.negate()
		}

		self.init(numerator: numerator, denominator: denominator)
	}
}
