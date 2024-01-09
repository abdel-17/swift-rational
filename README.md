# Swift Rational

## Introduction

Swift Numerics provides the `RationalModule` module for working with rational numbers in Swift.
```swift
import RationalModule

let half = Rational<Int>(1, 2)
```

`RationalModule` has only a single dependency, [swift-numerics](https://github.com/apple/swift-numerics/tree/main).

## Using Swift Rational in your project

To use Swift Rational in a SwiftPM project:

1. Add the following line to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/abdel-17/swift-rational", from: "1.0.0")
```

2. Add `RationalModule` as a dependency for your target:

```swift
.target(
	name: "TargetName",
	dependencies: [
		.product(name: "RationalModule", package: "swift-rational")
	]
)
```

3. Add `import RationalModule` in your source code.

## API

`RationalModule` exports the `Rational` struct. It conforms to standard Swift protocols like `AdditiveArithmetic`, `Numeric`, `Hashable`, `Comparable`, and more.

You can create a `Rational` value using the fraction initializer.
```swift
let half = Rational(2, 4)
print(x.numerator)		// 1
print(x.denominator)	// 2
```

You can also use the integer initializer.
```swift
let one = Rational(1)
```

Or simply an integer literal.
```swift
let two: Rational<Int> = 2
```

`Rational` supports the standard arithmetic and comparison operators.
```swift
Rational(1, 2) + Rational(1, 4)		// Rational(3, 4)
Rational(1)    - Rational(1, 2)		// Rational(1, 2)
Rational(2)    * Rational(3, 4)		// Rational(3, 2)
Rational(1)    / Rational(1, 2)		// Rational(2, 1)
Rational(1, 2) < Rational(3, 4)		// true
```
