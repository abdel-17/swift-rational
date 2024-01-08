public struct Rational<T: FixedWidthInteger & SignedInteger>: Hashable {
	/// The numerator of this value.
	///
	/// This value is normalized so that it has no
	/// common factors with `denominator`.
	public let numerator: T

	/// The denominator of this value.
	///
	/// This value is normalized so that it's positive and
	/// has no common factors with `numerator`.
	public let denominator: T

	/// Creates a rational value with the given numerator and denominator.
	///
	/// The given values must be noramlized, that is:
	/// 1. `numerator` and `denominator` have no common factors.
	/// 2. `denominator` is positive.
	@inlinable
	internal init(numerator: T, denominator: T) {
		assert(denominator > 0, "The denominator must be positive")
		assert(gcd(numerator, denominator) == 1, "The fraction must normalized")

		self.numerator = numerator
		self.denominator = denominator
	}
}

// MARK: - Initializers
extension Rational {
	/// Creates a rational value from a fraction.
	///
	/// The result is normalized so that the numerator and denominator
	/// have no common factors and the denominator is positive.
	///
	///     Rational(2, 4)      1/2
	///     Rational(2, 2)      1
	///     Rational(1, -3)     -1/3
	///     Rational(6, 3)      2
	///
	/// - Precondition: `denominator != 0`
	@inlinable
	public init(_ numerator: T, _ denominator: T) {
		precondition(denominator != 0, "The denominator must not be zero")

		// We cannot compute `gcd(0, T.min)` and `gcd(T.min, T.min)` due to overflow,
		// so we must handle these cases separately.
		if numerator == 0 {
			self.init(numerator: 0, denominator: 1)
			return
		}

		if numerator == denominator {
			self.init(numerator: 1, denominator: 1)
			return
		}

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

// MARK: - Properties
extension Rational {
	/// The quotient of the numerator divided by the denominator.
	@inlinable
	public var quotient: T {
		numerator / denominator
	}

	/// The remainder of the numerator divided by the denominator.
	@inlinable
	public var remainder: T {
		numerator % denominator
	}

	/// The quotient and remainder of the numerator divided by the denominator.
	@inlinable
	public var quotientAndRemainder: (quotient: T, remainder: T) {
		numerator.quotientAndRemainder(dividingBy: denominator)
	}

	/// Whether or not this value is equal to zero.
	@inlinable
	var isZero: Bool {
		numerator == 0
	}

	/// Whether or not this value is negative.
	@inlinable
	var isNegative: Bool {
		numerator < 0
	}
}

// MARK: - Helpers
extension Rational {
	/// Returns the numerator and denominator as a tuple.
	@inlinable
	public func toRatio() -> (numerator: T, denominator: T) {
		(numerator, denominator)
	}

	/// Returns the closest rational number to this value
	/// with `denominator` at most `max`.
	///
	/// - Precondition: `max >= 1`
	@inlinable
	public func limitDenominator(to max: T) -> Self {
		precondition(max >= 1, "The value of `max` should be at least 1")

		guard denominator > max else { return self }

		var p0: T = 0
		var q0: T = 1
		var p1: T = 1
		var q1: T = 0
		var n = numerator
		var d = denominator

		while true {
			let a = n / d
			let q2 = q0 + a * q1
			guard q2 <= max else { break }

			(p0, q0, p1, q1) = (p1, q1, p0 + a * p1, q2)
			(n, d) = (d, n - a * d)
		}

		let k = (max - q0) / q1
		return if 2 * d * (q0 + k * q1) <= denominator {
			Self(numerator: p1, denominator: q1)
		} else {
			Self(numerator: p0 + k * p1, denominator: q0 + k * q1)
		}
	}
}
