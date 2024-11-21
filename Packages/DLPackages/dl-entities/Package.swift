// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "dl-entities",
	platforms: [
		.iOS(.v16),
	],
	products: [
		.library(
			name: "DLEntities",
			targets: [
				"DLEntities",
			]
		),
		.library(
			name: "DLEntitiesStubs",
			targets: [
				"DLEntitiesStubs",
			]
		),
	],
	targets: [
		.target(
			name: "DLEntities"
		),
		.target(
			name: "DLEntitiesStubs",
			dependencies: [
				.target(name: "DLEntities")
			]
		)
	]
)
