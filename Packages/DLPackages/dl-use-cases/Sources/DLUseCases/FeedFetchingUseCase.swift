//
//  FeedFetchingUseCase.swift
//  dl-use-cases
//
//  Created by Anton on 21/11/2024.
//

import Foundation
import Dependencies
import DLEntities
import DLRepositories
import DLUseCasesDataProvidersProtocols
import DLUseCasesProtocols

public struct FeedFetchingUseCase: PFeedFetchingUseCase {
	@Dependency(\.feedDataProvider) var feedDataProvider

	public func fetchPhotosFragment (perPage: Int = 15) async throws -> PhotosFragmentEntity {
		try await feedDataProvider.load(photosPerPage: perPage)
	}

	public func fetchPhotosFragment (nextFragmentUrl: URL) async throws -> PhotosFragmentEntity {
		try await feedDataProvider.load(nextFragmentUrl: nextFragmentUrl)
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

