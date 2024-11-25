// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "il-components",
	platforms: [
		.iOS(.v16)
	],
	products: [
		.library(
			name: "ILComponents",
			targets: [
				"ILComponents"
			]
		)
	],
	dependencies: [
		.package(path: "../../DLPackages/dl-repositories"),

		.package(url: "https://github.com/onevcat/Kingfisher", exact: "7.12.0"),
	],
	targets: [
		.target(
			name: "ILComponents",
			dependencies: [
				.product(name: "DLPersistence", package: "dl-repositories"),

				.product(name: "Kingfisher", package: "Kingfisher"),
			]
		)
	]
)
