//
//  PhotoDetailsFetchingUseCase.swift
//  dl-use-cases
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import Foundation

public struct PhotoDetailsFetchingUseCase: PPhotoDetailsFetchingUseCase {
	@Dependency(\.photoDetailsDataProvider) var photoDetailsDataProvider
	@Dependency(\.photoDetailsPersistentDataProvider) var photoDetailsPersistentDataProvider

	public func loadPhoto (id: Int) async throws -> PhotoEntity {
		do {
			let photo = try await photoDetailsDataProvider.loadPhoto(id: id)
			try? photoDetailsPersistentDataProvider.savePhoto(photo)
			return photo
		} catch let error as OfflineError {
			if let photoEntity = try? photoDetailsPersistentDataProvider.loadPhoto(id: id) {
				return photoEntity
			} else {
				throw error
			}
		}
	}
}

enum PhotoDetailsFetchingUseCaseDependencyKey: DependencyKey {
	public static var liveValue: any PPhotoDetailsFetchingUseCase {
		PhotoDetailsFetchingUseCase()
	}
}

public extension DependencyValues {
	var photoDetailsFetchingUseCase: any PPhotoDetailsFetchingUseCase {
		get { self[PhotoDetailsFetchingUseCaseDependencyKey.self] }
		set { self[PhotoDetailsFetchingUseCaseDependencyKey.self] = newValue }
	}
}

