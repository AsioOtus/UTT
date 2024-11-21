// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "dl-use-cases",
	platforms: [
		.iOS(.v16),
	],
	products: [
		.library(
			name: "DLUseCases",
			targets: [
				"DLUseCases",
			]
		),
	],
	dependencies: [
		.package(path: "../dl-entities"),
		.package(path: "../dl-repositories"),

			.package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.3.0"),
	],
	targets: [
		.target(
			name: "DLUseCases",
			dependencies: [
				.product(name: "DLEntities", package: "dl-entities"),
				.product(name: "DLRepositories", package: "dl-repositories"),

					.product(name: "Dependencies", package: "swift-dependencies"),
			]
		),

			.testTarget(
				name: "DLUseCasesTests",
				dependencies: [
					.target(name: "DLUseCases"),

						.product(name: "DLEntities", package: "dl-entities"),
					.product(name: "DLEntitiesStubs", package: "dl-entities"),
					.product(name: "DLRepositories", package: "dl-repositories"),
					.product(name: "DLRepositoriesMocks", package: "dl-repositories"),
				]
			),
	]
)
