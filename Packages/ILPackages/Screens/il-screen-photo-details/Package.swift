// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "il-screen-photo-details",
	platforms: [
		.iOS(.v16),
	],
	products: [
		.library(
			name: "ILScreenPhotoDetails",
			targets: [
				"ILScreenPhotoDetails"
			]
		)
	],
	dependencies: [
		.package(path: "../../../DLPackages/dl-use-cases"),
		.package(path: "../../../DLPackages/dl-use-cases-protocols"),

		.package(url: "https://github.com/AsioOtus/multitool", from: "1.0.0"),
		.package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.3.0"),
	],
	targets: [
		.target(
			name: "ILScreenPhotoDetails",
			dependencies: [
				.product(name: "DLUseCases", package: "dl-use-cases"),
				.product(name: "DLUseCasesProtocols", package: "dl-use-cases-protocols"),

				.product(name: "Multitool", package: "multitool"),
				.product(name: "Dependencies", package: "swift-dependencies"),
			]
		)
	]
)
