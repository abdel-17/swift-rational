public struct Rational<T: FixedWidthInteger & SignedInteger>: Hashable {
	/// The numerator of this value.
	///
	/// This value is normalized so that it has no
	/// common factors with the denominator.
	public let numerator: T

	/// The denominator of this value.
	///
	/// This value is normalized so that it's positive and
	/// has no common factors with the numerator.
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
	/// Creates a rational value from a fraction of integers.
	///
	/// The result is normalized so that the numerator and denominator
	/// have no common factors and the denominator is positive.
	///
	///     Rational(2, 4)     // 1/2
	///     Rational(2, 2)     // 1
	///     Rational(1, -3)    // -1/3
	///     Rational(6, 3)     // 2
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
	/// The minimum representible rational value,
	/// with numerator `T.min` and denominator `1`.
	@inlinable
	public static var min: Self {
		Self(T.min)
	}

	/// The maximum representible rational value,
	/// with numerator `T.max` and denominator `1`.
	@inlinable
	public static var max: Self {
		Self(T.max)
	}

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

	/// Whether or not this value is equal to `0`.
	@inlinable
	public var isZero: Bool {
		numerator == 0
	}

	/// Whether or not this value is negative.
	@inlinable
	public var isNegative: Bool {
		numerator < 0
	}

	/// Whether or not this value is positive.
	@inlinable
	public var isPositive: Bool {
		numerator > 0
	}

	/// Whether or not this value represents an integer.
	@inlinable
	public var isInteger: Bool {
		denominator == 1
	}

	/// Whether or not the magnitude of this value is less than `1`.
	@inlinable
	public var isProperFraction: Bool {
		numerator.magnitude < denominator.magnitude
	}
}

// MARK: - Helpers
extension Rational {
	/// Returns `-1` if this value is negative and `1` if it's positive;
	/// otherwise, `0`.
	@inlinable
	public func signum() -> T {
		numerator.signum()
	}

	/// Returns the numerator and denominator as a tuple.
	@inlinable
	public func toRatio() -> (numerator: T, denominator: T) {
		(numerator, denominator)
	}

	/// Returns the closest rational number to this value
	/// with a denominator at most `max`.
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
			let a = floorDivision(n, d)
			let q2 = q0 + a * q1
			guard q2 <= max else { break }

			(p0, q0, p1, q1) = (p1, q1, p0 + a * p1, q2)
			(n, d) = (d, n - a * d)
		}

		let k = floorDivision((max - q0), q1)
		return if 2 * d * (q0 + k * q1) <= denominator {
			Self(numerator: p1, denominator: q1)
		} else {
			Self(numerator: p0 + k * p1, denominator: q0 + k * q1)
		}
	}
}

/// Equivalent to Python's `//` operator.
@usableFromInline
internal func floorDivision<T: BinaryInteger>(_ a: T, _ b: T) -> T {
	let quotient = a / b
	return if a >= 0 {
		quotient
	} else {
		quotient - 1
	}
}

// MARK: - Rounding
extension Rational {
	/// The greatest integer less than or equal to this value.
	@inlinable
	public var floor: T {
		guard !isInteger else { return numerator }
		return if isNegative {
			quotient - 1
		} else {
			quotient
		}
	}

	/// The smallest integer greater than or equal to this value.
	@inlinable
	public var ceil: T {
		guard !isInteger else { return numerator }
		return if isNegative {
			quotient
		} else {
			quotient + 1
		}
	}

	/// The closest integer to this value, or the one with
	/// greater magnitude if two values are equally close.
	@inlinable
	public var rounded: T {
		guard !isInteger else { return numerator }
		// If the magnitude of the fractional part
		// is less than 1/2, round towards zero.
		//
		// |r|    1
		// --- < --- => 2 * |r| < |d|
		// |d|    2
		return if 2 * remainder.magnitude < denominator.magnitude {
			quotient
		} else {
			roundedAwayFromZero
		}
	}

	/// The closest integer whose magnitude is greater than
	/// or equal to this value.
	@inlinable
	public var roundedAwayFromZero: T {
		guard !isInteger else { return numerator }
		return if isNegative {
			quotient - 1
		} else {
			quotient + 1
		}
	}
}
