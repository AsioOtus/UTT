//
//  PhotoDetailsRepository.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import DLEntities
import DLNetwork
import DLUseCasesDataProvidersProtocols
import Foundation

public struct PhotoDetailsRepository: PPhotoDetailsDataProvider {
	@Dependency(\.urlClient) var urlClient

	public func loadPhoto (id: Int) async throws -> PhotoEntity {
		try await urlClient.send(PhotoRequest(id: id), responseModel: Photo.self).model.entity
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
