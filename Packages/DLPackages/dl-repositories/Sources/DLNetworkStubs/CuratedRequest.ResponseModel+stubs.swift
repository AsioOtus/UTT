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

public extension CuratedRequest.ResponseModel.Photo {
	static let stubBohr = Self(
		id: 1,
		photographer: "Niels Bohr",
		src: .stubSampleA
	)

	static let stubBorn = Self(
		id: 2,
		photographer: "Max Born",
		src: .stubSampleA
	)

	static let stubDirac = Self(
		id: 3,
		photographer: "Paul Dirac",
		src: .stubSampleA
	)

	static let stubEinstein = Self(
		id: 4,
		photographer: "Albert Einstein",
		src: .stubSampleA
	)

	static let stubFermi = Self(
		id: 5,
		photographer: "Enrico Fermi",
		src: .stubSampleA
	)

	static let stubHeisenberg = Self(
		id: 6,
		photographer: "Werner Heisenberg",
		src: .stubSampleA
	)

	static let stubLorenz = Self(
		id: 7,
		photographer: "Hendrik Antoon Lorentz",
		src: .stubSampleA
	)

	static let stubPauli = Self(
		id: 8,
		photographer: "Wolfgang Pauli",
		src: .stubSampleA
	)

	static let stubPlanck = Self(
		id: 9,
		photographer: "Max Planck",
		src: .stubSampleA
	)

	static let stubSchrodinger = Self(
		id: 10,
		photographer: "Erwin Schrödinger",
		src: .stubSampleA
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

public extension CuratedRequest.ResponseModel.Photo.Source {
	static let stubSampleA = Self(original: .stubOriginal, large: .stubLarge)
}
