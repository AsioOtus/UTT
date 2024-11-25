//
//  CuratedRequest.ResponseModel+stubs.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import DLNetwork
import DLEntitiesStubs

public extension CuratedRequest.ResponseModel {
	static let stubFirstPage = Self(
		page: 1,
		perPage: 5,
		photos: .init(Photo.stubAll[0..<5]),
		nextPage: .stubNextFragment,
		prevPage: .stubPreviousFragment
	)

	static let stubSecondPage = Self(
		page: 2,
		perPage: 5,
		photos: .init(Photo.stubAll[5...]),
		nextPage: .stubNextFragment,
		prevPage: .stubPreviousFragment
	)
}

public extension Photo {
	static let stubBohr = Self(
		id: 1,
		photographer: "Niels Bohr",
		alt: "Description 1",
		src: .stubSampleA,
		width: 100,
		height: 100
	)

	static let stubBorn = Self(
		id: 2,
		photographer: "Max Born",
		alt: "Description 2",
		src: .stubSampleA,
		width: 100,
		height: 100
	)

	static let stubDirac = Self(
		id: 3,
		photographer: "Paul Dirac",
		alt: "Description 3",
		src: .stubSampleA,
		width: 100,
		height: 100
	)

	static let stubEinstein = Self(
		id: 4,
		photographer: "Albert Einstein",
		alt: "Description 4",
		src: .stubSampleA,
		width: 100,
		height: 100
	)

	static let stubFermi = Self(
		id: 5,
		photographer: "Enrico Fermi",
		alt: "Description 5",
		src: .stubSampleA,
		width: 100,
		height: 100
	)

	static let stubHeisenberg = Self(
		id: 6,
		photographer: "Werner Heisenberg",
		alt: "Description 6",
		src: .stubSampleA,
		width: 100,
		height: 100
	)

	static let stubLorenz = Self(
		id: 7,
		photographer: "Hendrik Antoon Lorentz",
		alt: "Description 7",
		src: .stubSampleA,
		width: 100,
		height: 100
	)

	static let stubPauli = Self(
		id: 8,
		photographer: "Wolfgang Pauli",
		alt: "Description 8",
		src: .stubSampleA,
		width: 100,
		height: 100
	)

	static let stubPlanck = Self(
		id: 9,
		photographer: "Max Planck",
		alt: "Description 9",
		src: .stubSampleA,
		width: 100,
		height: 100
	)

	static let stubSchrodinger = Self(
		id: 10,
		photographer: "Erwin Schrödinger",
		alt: "Description 10",
		src: .stubSampleA,
		width: 100,
		height: 100
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

public extension Photo.Source {
	static let stubSampleA = Self(original: .stubOriginal, large: .stubLarge)
}
