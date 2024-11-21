// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "dl-use-cases-protocols",
	platforms: [
		.iOS(.v16),
	],
	products: [
		.library(
			name: "DLUseCasesProtocols",
			targets: [
				"DLUseCasesProtocols",
				"DLUseCasesDataProvidersProtocols",
			]
		),
	],
	dependencies: [
		.package(path: "../dl-entities"),
	],
	targets: [
		.target(
			name: "DLUseCasesProtocols",
			dependencies: [
				.product(name: "DLEntities", package: "dl-entities")
			]
		),
		.target(
			name: "DLUseCasesDataProvidersProtocols",
			dependencies: [
				.product(name: "DLEntities", package: "dl-entities")
			]
		),
	]
)
