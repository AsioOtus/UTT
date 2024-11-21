// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "dl-logic",
	products: [
		.library(
			name: "DLLogic",
			targets: [
				"DLLogic"
			]
		)
	],
	targets: [
		.target(
			name: "DLLogic"
		)
	]
)
