//
//  FeedFetchingUseCase.swift
//  dl-use-cases
//
//  Created by Anton on 21/11/2024.
//

import Foundation
import Dependencies

public struct FeedFetchingUseCase: PFeedFetchingUseCase {
	@Dependency(\.feedDataProvider) var feedDataProvider
	@Dependency(\.photoDetailsPersistentDataProvider) var photoDetailsPersistentDataProvider

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

enum FeedFetchingUseCaseDependencyKey: DependencyKey {
	public static var liveValue: any PFeedFetchingUseCase {
		FeedFetchingUseCase()
	}
}

public extension DependencyValues {
	var feedFetchingUseCase: any PFeedFetchingUseCase {
		get { self[FeedFetchingUseCaseDependencyKey.self] }
		set { self[FeedFetchingUseCaseDependencyKey.self] = newValue }
	}
}
