//
//  FeedFetchingUseCase.swift
//  dl-use-cases
//
//  Created by Anton on 21/11/2024.
//

import Foundation

public struct FeedFetchingUseCase: PFeedFetchingUseCase {
	let feedDataProvider: PFeedDataProvider
	let photoDetailsPersistentDataProvider: PPhotoDetailsPersistentDataProvider

	public func fetchPhotosFragment (perPage: Int = 15) async throws -> PhotosFragmentEntity {
		let photoFragment = try await feedDataProvider.load(photosPerPage: perPage)
		try? photoDetailsPersistentDataProvider.savePhotos(photoFragment.photos)
		return photoFragment
	}

	public func fetchPhotosFragment (nextFragmentUrl: URL) async throws -> PhotosFragmentEntity {
		let photoFragment = try await feedDataProvider.load(nextFragmentUrl: nextFragmentUrl)
		try? photoDetailsPersistentDataProvider.savePhotos(photoFragment.photos)
		return photoFragment
	}
}
