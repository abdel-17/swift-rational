extension Rational: Comparable {
	@inlinable
	public static func < (lhs: Self, rhs: Self) -> Bool {
		let n1 = lhs.numerator
		let d1 = lhs.denominator
		let n2 = rhs.numerator
		let d2 = rhs.denominator
		
		// n1   n2    n1 * d2   n2 * d1
		// -- < -- => ------- < ------- => n1 * d2 < n2 * d1
		// d1   d2    d1 * d2   d1 * d2
		let (a, overflow1) = n1.multipliedReportingOverflow(by: d2)
		let (b, overflow2) = n2.multipliedReportingOverflow(by: d1)
		
		guard !overflow1 && !overflow2 else {
			// Go down the slow path only if multiplication overflows.
			return n1.multipliedFullWidth(by: d2) < n2.multipliedFullWidth(by: d1)
		}
		
		return a < b
	}
}
