//
//  FeedRepository.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import Foundation

struct FeedRepository: PFeedDataProvider {
	let networkController = NetworkController()

	func load (photosPerPage: Int) async throws -> PhotosFragmentEntity {
		let photoPage = try await networkController.send(
			Requests.curated(page: 1, perPage: photosPerPage),
			responseType: PhotoPage.self
		)
		let photosFragmentEntity = map(photoPage)

		return photosFragmentEntity
	}

	func load (nextFragmentUrl: URL) async throws -> PhotosFragmentEntity {
		let photoPage = try await networkController.send(
			Requests.nextCurated(nextFragmentUrl),
			responseType: PhotoPage.self
		)
		let photosFragmentEntity = map(photoPage)

		return photosFragmentEntity
	}
}

private extension FeedRepository {
	func map (_ responseModel: PhotoPage) -> PhotosFragmentEntity {
		.init(
			page: responseModel.page,
			photosPerPage: responseModel.perPage,
			photos: responseModel.photos.map(\.entity),
			previousFragmentUrl: responseModel.prevPage,
			nextFragmentUrl: responseModel.nextPage
		)
	}
}

enum FeedDataProviderDependencyKey: DependencyKey {
	public static var liveValue: any PFeedDataProvider {
		FeedRepository()
	}
}

public extension DependencyValues {
	var feedDataProvider: any PFeedDataProvider {
		get { self[FeedDataProviderDependencyKey.self] }
		set { self[FeedDataProviderDependencyKey.self] = newValue }
	}
}
