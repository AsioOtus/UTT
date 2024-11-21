//
//  FeedFetchingUseCaseTests.swift
//  dl-use-cases
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import DLRepositoriesMocks
import DLEntitiesStubs
import XCTest

@testable import DLUseCases

final class FeedFetchingUseCaseTests: XCTestCase {
	var sut: FeedFetchingUseCase!

	override func tearDown() {
		sut = nil
	}

	func test_fetchPhotosFragmentPerPage_withDefaultParams_shouldReturnPhotos () async throws {
		// Given
		let mock = Mock.FeedDataProvider(stubValue: .stubFirstPage)

		sut = withDependencies {
			$0.feedDataProvider = mock
		} operation: {
			FeedFetchingUseCase()
		}

		// When
		let photosFragment = try await sut.fetchPhotosFragment()

		// Then
		XCTAssertEqual(photosFragment, .stubFirstPage)
		XCTAssertEqual(mock.paramPhotosPerPage, 10)
	}

	func test_fetchPhotosFragmentPerPage_withCustomPerPageParam_shouldReturnPhotos () async throws {
		// Given
		let mock = Mock.FeedDataProvider(stubValue: .stubFirstPage)

		sut = withDependencies {
			$0.feedDataProvider = mock
		} operation: {
			FeedFetchingUseCase()
		}

		// When
		let photosFragment = try await sut.fetchPhotosFragment(perPage: 55)

		// Then
		XCTAssertEqual(photosFragment, .stubFirstPage)
		XCTAssertEqual(mock.paramPhotosPerPage, 55)
	}

	func test_fetchPhotosFragmentPerPage_withDefaultParams_shouldThrow () async {
		// Given
		let mockThrowing = Mock.Throwing.FeedDataProvider()

		sut = withDependencies {
			$0.feedDataProvider = mockThrowing
		} operation: {
			FeedFetchingUseCase()
		}

		// When
		await XCTAssertThrowsError(try await sut.fetchPhotosFragment()) {
			// Then
			XCTAssertEqual($0 as? TestError, TestError.instance)
		}
	}

	func test_fetchPhotosFragmentNextFragmentUrl_withValidUrlParam_shouldReturnPhotos () async throws {
		// Given
		let mock = Mock.FeedDataProvider(stubValue: .stubSecondPage)

		sut = withDependencies {
			$0.feedDataProvider = mock
		} operation: {
			FeedFetchingUseCase()
		}

		// When
		let photosFragment = try await sut.fetchPhotosFragment(nextFragmentUrl: .stubNextFragment)

		// Then
		XCTAssertEqual(photosFragment, .stubSecondPage)
		XCTAssertEqual(mock.paramNextFragmentUrl, .stubNextFragment)
	}
}


