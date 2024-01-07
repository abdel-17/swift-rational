extension Rational: ExpressibleByIntegerLiteral {
	public typealias IntegerLiteralType = T.IntegerLiteralType
	
	public init(integerLiteral value: IntegerLiteralType) {
		self.init(T(integerLiteral: value))
	}
	
	public init(_ value: T) {
		self.init(numerator: value, denominator: 1)
	}
}
