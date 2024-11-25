//
//  FeedRepositoryTests.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import DLEntities
import DLEntitiesStubs
import DLNetwork
import DLNetworkStubs
import NetworkUtil
import XCTest

@testable import DLRepositories

final class FeedRepositoryTest: XCTestCase {
	var sut: FeedRepository!

	override func tearDown() {
		sut = nil
	}

	func test_loadPhotoPerPage_withCustomPhotosPerPageParam_shouldSendRequestAndReturnEntity () async throws {
		// Given
		let perPage = 5

		let mockUrlClient = MockURLClient<CuratedRequest, CuratedRequest.ResponseModel>(
			stubResponseModel: .stubFirstPage
		)

		sut = withDependencies {
			$0.repeatableUrlClient = mockUrlClient
		} operation: {
			FeedRepository()
		}

		// When
		let photosFragmentEntity = try await sut.load(photosPerPage: perPage)

		// Then
		XCTAssertEqual(photosFragmentEntity, .stubFirstPage)

		let resultUrlRequest = try XCTUnwrap(mockUrlClient.resultUrlRequest)
		let resultUrl = URLComponents(url: resultUrlRequest.url!, resolvingAgainstBaseURL: false)!

		let expectedUrlRequest = URLRequest(url: .init(string: "https://api.pexels.com/v1/curated?page=1&per_page=\(perPage)")!)
		let expectedUrl = URLComponents(url: expectedUrlRequest.url!, resolvingAgainstBaseURL: false)!

		let resultQuery = try XCTUnwrap(resultUrl.queryItems)
		let expectedQuery = try XCTUnwrap(expectedUrl.queryItems)

		XCTAssertEqual(resultUrl.path, expectedUrl.path)
		XCTAssertEqual(Set(resultQuery), Set(expectedQuery))
		XCTAssertEqual(resultUrlRequest.httpMethod, expectedUrlRequest.httpMethod)
		XCTAssertNil(resultUrlRequest.httpBody)
	}

	func test_loadNextFragmentUrl_withCustomPhotosPerPageParam_ () async throws {
		// Given
		let mockUrlClient = MockURLClient<NextCuratedRequest, CuratedRequest.ResponseModel>(
			stubResponseModel: .stubSecondPage
		)

		sut = withDependencies {
			$0.repeatableUrlClient = mockUrlClient
		} operation: {
			FeedRepository()
		}

		// When
		let nextPhotosFragmentEntity = try await sut.load(nextFragmentUrl: .stubNextFragment)

		// Then
		XCTAssertEqual(nextPhotosFragmentEntity, .stubSecondPage)

		let resultUrlRequest = try XCTUnwrap(mockUrlClient.resultUrlRequest)
		let resultUrl = URLComponents(url: resultUrlRequest.url!, resolvingAgainstBaseURL: false)!

		let expectedUrlRequest = URLRequest(url: .init(string: "https://api.pexels.com/v1/curated/?page=2&per_page=5")!)
		let expectedUrl = URLComponents(url: expectedUrlRequest.url!, resolvingAgainstBaseURL: false)!

		let resultQuery = try XCTUnwrap(resultUrl.queryItems)
		let expectedQuery = try XCTUnwrap(expectedUrl.queryItems)

		XCTAssertEqual(resultUrl.path, expectedUrl.path)
		XCTAssertEqual(Set(resultQuery), Set(expectedQuery))
		XCTAssertEqual(resultUrlRequest.httpMethod, expectedUrlRequest.httpMethod)
		XCTAssertNil(resultUrlRequest.httpBody)
	}
}
