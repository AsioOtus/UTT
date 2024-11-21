//
//  PhotoDetailsFetchingUseCase.swift
//  dl-use-cases
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import DLRepositories
import DLUseCasesDataProvidersProtocols
import DLUseCasesProtocols
import Foundation

public struct PhotoDetailsFetchingUseCase: PPhotoDetailsFetchingUseCase {
	@Dependency(\.photoDetailsDataProvider) var photoDetailsDataProvider

	public func loadPhoto (url: URL) async throws -> Data {
		try await photoDetailsDataProvider.loadPhoto(url: url)
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

