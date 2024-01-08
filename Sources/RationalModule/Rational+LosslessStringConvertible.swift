extension Rational: LosslessStringConvertible {
	/// Creates a rational value from its string representation.
	///
	/// The string may begin with a + or - character, followed by
	/// one or more digits (0-9), optionally followed by a / character
	/// and one or more digits.
	///
	/// 	Rational<Int>("2")		// Rational(2, 1)
	/// 	Rational<Int>("2/4")	// Rational(1, 2)
	///
	/// If the string is in an invalid format, or it describes a value that
	/// cannot be represented within this type, `nil` is returned.
	///
	///     Rational<Int>("2 / 3")		// Whitespace.
	///     Rational<Int>("2/")			// Missing denominator
	///     Rational<Int>("1/0")		// Division by zero.
	///     Rational<Int8>("128/2")		// 128 is out of bounds for Int8.
	///
	@inlinable
	public init?(_ description: String) {
		guard let slash = description.firstIndex(of: "/") else {
			guard let value = T(description) else { return nil }
			self.init(value)
			return
		}

		let afterSlash = description.index(after: slash)
		guard afterSlash != description.endIndex else { return nil }

		let lhs = description[..<slash]
		let rhs = description[afterSlash...]
		guard let numerator = T(lhs), let denominator = T(rhs) else { return nil }

		guard denominator != 0 else { return nil }

		self.init(numerator, denominator)
	}
}
