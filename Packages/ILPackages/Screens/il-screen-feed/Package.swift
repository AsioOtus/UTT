// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "il-screen-feed",
	platforms: [
		.iOS(.v16)
	],
	products: [
		.library(
			name: "ILScreenFeed",
			targets: [
				"ILScreenFeed"
			]
		)
	],
	dependencies: [
		.package(path: "../../../DLPackages/dl-entities"),
		.package(path: "../../../DLPackages/dl-use-cases"),
		.package(path: "../../../DLPackages/dl-use-cases-protocols"),
		
		.package(path: "../il-screen-photo-details"),
		.package(path: "../il-components"),

		.package(url: "https://github.com/onevcat/Kingfisher", exact: "7.12.0"),
		.package(url: "https://github.com/AsioOtus/multitool", from: "1.0.0"),
		.package(url: "https://github.com/AsioOtus/ui-extensions", from: "1.0.1"),
	],
	targets: [
		.target(
			name: "ILScreenFeed",
			dependencies: [
				.product(name: "DLEntities", package: "dl-entities"),
				.product(name: "DLUseCases", package: "dl-use-cases"),
				.product(name: "DLUseCasesProtocols", package: "dl-use-cases-protocols"),

				.product(name: "ILScreenPhotoDetails", package: "il-screen-photo-details"),
				.product(name: "ILComponents", package: "il-components"),

				.product(name: "Kingfisher", package: "Kingfisher"),
				.product(name: "Multitool", package: "multitool"),
				.product(name: "UIKitExtensions", package: "ui-extensions"),
			]
		)
	]
)
