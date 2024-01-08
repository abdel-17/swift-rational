extension Rational: AdditiveArithmetic {
	/// The additive identity, with numerator `1` and denominator `0`.
	@inlinable
	public static var zero: Self {
		Self(0 as T)
	}

	@inlinable
	public static func + (lhs: Self, rhs: Self) -> Self {
		let n1 = lhs.numerator
		let d1 = lhs.denominator
		let n2 = rhs.numerator
		let d2 = rhs.denominator
		
		let g = gcd(d1, d2)
		guard g != 1 else {
			return Rational(numerator: n1 * d2 + n2 * d1, denominator: d1 * d2)
		}

		let s = d1 / g
		let t = n1 * (d2 / g) + n2 * s
		let g2 = gcd(t, g)
		return Self(numerator: t / g2, denominator: s * (d2 / g2))
	}

	@inlinable
	public static func - (lhs: Self, rhs: Self) -> Self {
		let n1 = lhs.numerator
		let d1 = lhs.denominator
		let n2 = rhs.numerator
		let d2 = rhs.denominator
		
		let g = gcd(d1, d2)
		guard g != 1 else {
			return Rational(numerator: n1 * d2 - n2 * d1, denominator: d1 * d2)
		}

		let s = d1 / g
		let t = n1 * (d2 / g) - n2 * s
		let g2 = gcd(t, g)
		return Self(numerator: t / g2, denominator: s * (d2 / g2))
	}
}
