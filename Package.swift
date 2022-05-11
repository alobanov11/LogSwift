// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "LogSwift",
	platforms: [
		.iOS(.v11),
	],
	products: [
		.library(name: "LogSwift", targets: ["LogSwift"]),
	],
	dependencies: [],
	targets: [
		.target(name: "LogSwift", dependencies: [], path: "Sources"),
	]
)
