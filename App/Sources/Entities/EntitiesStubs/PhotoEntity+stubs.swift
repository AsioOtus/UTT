//
//  PhotoEntity+stubs.swift
//  dl-entities
//
//  Created by Anton on 21/11/2024.
//

public extension PhotoEntity {
	static let stubBohr = Self(
		id: 1,
		photographerName: "Niels Bohr",
		description: "Description 1",
		width: 100,
		height: 100,
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubBorn = Self(
		id: 2,
		photographerName: "Max Born",
		description: "Description 2",
		width: 100,
		height: 100,
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubDirac = Self(
		id: 3,
		photographerName: "Paul Dirac",
		description: "Description 3",
		width: 100,
		height: 100,
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubEinstein = Self(
		id: 4,
		photographerName: "Albert Einstein",
		description: "Description 4",
		width: 100,
		height: 100,
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubFermi = Self(
		id: 5,
		photographerName: "Enrico Fermi",
		description: "Description 5",
		width: 100,
		height: 100,
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubHeisenberg = Self(
		id: 6,
		photographerName: "Werner Heisenberg",
		description: "Description 6",
		width: 100,
		height: 100,
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubLorenz = Self(
		id: 7,
		photographerName: "Hendrik Antoon Lorentz",
		description: "Description 7",
		width: 100,
		height: 100,
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubPauli = Self(
		id: 8,
		photographerName: "Wolfgang Pauli",
		description: "Description 8",
		width: 100,
		height: 100,
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubPlanck = Self(
		id: 9,
		photographerName: "Max Planck",
		description: "Description 9",
		width: 100,
		height: 100,
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubSchrodinger = Self(
		id: 10,
		photographerName: "Erwin Schrödinger",
		description: "Description 10",
		width: 100,
		height: 100,
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubAll: [Self] = [
		.stubBohr,
		.stubBorn,
		.stubDirac,
		.stubEinstein,
		.stubFermi,
		.stubHeisenberg,
		.stubLorenz,
		.stubPauli,
		.stubPlanck,
		.stubSchrodinger,
	]
}
