//
//  PhotoEntity+stubs.swift
//  dl-entities
//
//  Created by Anton on 21/11/2024.
//

import DLEntities

public extension PhotoEntity {
	static let stubBohr = Self(
		id: 1,
		photographerName: "Niels Bohr",
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubBorn = Self(
		id: 2,
		photographerName: "Max Born",
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubDirac = Self(
		id: 3,
		photographerName: "Paul Dirac",
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubEinstein = Self(
		id: 4,
		photographerName: "Albert Einstein",
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubFermi = Self(
		id: 5,
		photographerName: "Enrico Fermi",
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubHeisenberg = Self(
		id: 6,
		photographerName: "Werner Heisenberg",
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubLorenz = Self(
		id: 7,
		photographerName: "Hendrik Antoon Lorentz",
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubPauli = Self(
		id: 8,
		photographerName: "Wolfgang Pauli",
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubPlanck = Self(
		id: 9,
		photographerName: "Max Planck",
		originalUrl: .stubOriginal,
		largeUrl: .stubLarge
	)

	static let stubSchrodinger = Self(
		id: 10,
		photographerName: "Erwin Schrödinger",
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
