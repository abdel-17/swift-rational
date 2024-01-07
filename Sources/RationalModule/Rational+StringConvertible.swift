extension Rational: CustomStringConvertible {
	@inlinable
	public var description: String {
		guard denominator != 1 else { return "\(numerator)" }
		return "\(numerator)/\(denominator)"
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
