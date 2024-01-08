extension Rational: CustomStringConvertible {
	@inlinable
	public var description: String {
		if denominator == 1 {
			"\(numerator)"
		} else {
			"\(numerator)/\(denominator)"
		}
	}
}

extension Rational: CustomDebugStringConvertible {
	@inlinable
	public var debugDescription: String {
		let n = String(reflecting: numerator)
		let d = String(reflecting: denominator)
		return "Rational<\(T.self)>(\(n), \(d))"
	}
}
