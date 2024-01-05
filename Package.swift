// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "swift-rational",
	products: [
		.library(
			name: "RationalModule",
			targets: ["RationalModule"]
		)
	],
	dependencies: [
		.package(
			url: "https://github.com/apple/swift-format.git",
			exact: "509.0.0"
		)
	],
	targets: [
		.target(name: "RationalModule"),
		.testTarget(
			name: "RationalModuleTests",
			dependencies: ["RationalModule"]
		)
	]
)
