//
//  PhotoDetailsFetchingUseCase.swift
//  dl-use-cases
//
//  Created by Anton on 21/11/2024.
//

import Foundation

public struct PhotoDetailsFetchingUseCase: PPhotoDetailsFetchingUseCase {
	let photoDetailsDataProvider: PPhotoDetailsDataProvider
	let photoDetailsPersistentDataProvider: PPhotoDetailsPersistentDataProvider

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
