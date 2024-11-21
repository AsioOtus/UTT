// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "il-screen-root",
	platforms: [
		.iOS(.v16)
	],
	products: [
		.library(
			name: "ILScreenRoot",
			targets: [
				"ILScreenRoot",
			]
		)
	],
	dependencies: [
		.package(path: "../il-screen-feed"),
	],
	targets: [
		.target(
			name: "ILScreenRoot",
			dependencies: [
				.product(name: "ILScreenFeed", package: "il-screen-feed"),
			]
		)
	]
)
