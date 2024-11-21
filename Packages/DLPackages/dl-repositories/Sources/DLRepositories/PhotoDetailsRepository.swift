//
//  PhotoDetailsRepository.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import DLNetwork
import DLUseCasesDataProvidersProtocols
import Foundation

public struct PhotoDetailsRepository: PPhotoDetailsDataProvider {
	@Dependency(\.urlClient) var urlClient

	public func loadPhoto (url: URL) async throws -> Data {
		try await urlClient
			.send(
				.get(url.absoluteString),
				delegate: .standard(decoding: { data, _, _ in data })
			)
			.data
	}
}

enum PhotoDetailsRepositoryDependencyKey: DependencyKey {
	public static var liveValue: any PPhotoDetailsDataProvider {
		PhotoDetailsRepository()
	}
}

public extension DependencyValues {
	var photoDetailsDataProvider: any PPhotoDetailsDataProvider {
		get { self[PhotoDetailsRepositoryDependencyKey.self] }
		set { self[PhotoDetailsRepositoryDependencyKey.self] = newValue }
	}
}
