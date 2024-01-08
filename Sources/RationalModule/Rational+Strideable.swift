extension Rational: Strideable {
	public typealias Stride = Self

	@inlinable
	public func advanced(by n: Self) -> Self {
		self + n
	}

	@inlinable
	public func distance(to other: Self) -> Self {
		other - self
	}
}
