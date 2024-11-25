//
//  PhotoDetailsFetchingUseCaseTests.swift
//  dl-use-cases
//
//  Created by Anton on 25/11/2024.
//

import Dependencies
import DLEntities
import DLRepositoriesMocks
import DLEntitiesStubs
import XCTest

@testable import DLUseCases

final class PhotoDetailsFetchingUseCaseTests: XCTestCase {
	var sut: PhotoDetailsFetchingUseCase!

	override func tearDown() {
		sut = nil
	}

	func test_photoLoading_withDefaultId_shouldReturnPhoto () async throws {
		// Given
		let id = 1
		let mock = Mock.PhotoDetailsDataProvider(stubValue: .stubBohr)
		let persistentMock = Mock.PhotoDetailsPersistentDataProvider(stubValue: .stubBohr)

		sut = withDependencies {
			$0.photoDetailsDataProvider = mock
			$0.photoDetailsPersistentDataProvider = persistentMock
		} operation: {
			PhotoDetailsFetchingUseCase()
		}

		// When
		let photosFragment = try await sut.loadPhoto(id: id)

		// Then
		XCTAssertEqual(photosFragment, .stubBohr)
		XCTAssertEqual(persistentMock.paramPhotoEntity, PhotoEntity.stubBohr)
	}

	func test_photoLoading_withOfflineError_shouldReturnPhotoFromPersistentDataProvider () async throws {
		// Given
		let id = 2
		let mock = Mock.Throwing.PhotoDetailsDataProvider(error: OfflineError.init(error: TestError.instance))
		let persistentMock = Mock.PhotoDetailsPersistentDataProvider(stubValue: .stubBorn)

		sut = withDependencies {
			$0.photoDetailsDataProvider = mock
			$0.photoDetailsPersistentDataProvider = persistentMock
		} operation: {
			PhotoDetailsFetchingUseCase()
		}

		// When
		let photosFragment = try await sut.loadPhoto(id: id)

		// Then
		XCTAssertEqual(photosFragment, .stubBorn)
		XCTAssertEqual(persistentMock.paramPhotoEntity, nil)
	}

	func test_photoLoading_withDefaultId_shouldThrow () async {
		// Given
		let mockThrowing = Mock.Throwing.PhotoDetailsDataProvider()

		sut = withDependencies {
			$0.photoDetailsDataProvider = mockThrowing
		} operation: {
			PhotoDetailsFetchingUseCase()
		}

		// When
		await XCTAssertThrowsError(try await sut.loadPhoto(id: 0)) {
			// Then
			XCTAssertEqual($0 as? TestError, TestError.instance)
		}
	}
}
