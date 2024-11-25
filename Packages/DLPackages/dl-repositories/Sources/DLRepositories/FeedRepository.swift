//
//  FeedRepository.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import DLEntities
import DLNetwork
import DLUseCasesDataProvidersProtocols
import Foundation

struct FeedRepository: PFeedDataProvider {
	@Dependency(\.repeatableUrlClient) var urlClient

	func load (photosPerPage: Int) async throws -> PhotosFragmentEntity {
		let request = CuratedRequest(page: 1, perPage: photosPerPage)
		let responseModel = try await urlClient.send(request, responseModel: CuratedRequest.ResponseModel.self).model
		let photosFragmentEntity = map(responseModel)

		return photosFragmentEntity
	}

	func load (nextFragmentUrl: URL) async throws -> PhotosFragmentEntity {
		let request = NextCuratedRequest(addressUrl: nextFragmentUrl)
		let responseModel = try await urlClient.send(request, responseModel: CuratedRequest.ResponseModel.self).model
		let photosFragmentEntity = map(responseModel)

		return photosFragmentEntity
	}
}

private extension FeedRepository {
	func map (_ responseModel: CuratedRequest.ResponseModel) -> PhotosFragmentEntity {
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
