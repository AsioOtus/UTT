//
//  PhotoDetailsRepository.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import Foundation

public struct PhotoDetailsRepository: PPhotoDetailsDataProvider {
	let networkController = NetworkController()

	public func loadPhoto (id: Int) async throws -> PhotoEntity {
		try await networkController.send(Requests.photo(id), responseType: Photo.self).entity
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
