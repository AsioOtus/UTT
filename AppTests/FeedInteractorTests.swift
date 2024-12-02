//
//  AppTests.swift
//  AppTests
//
//  Created by Anton on 02/12/2024.
//

import XCTest

@testable import App

final class FeedInteractorTests: XCTestCase {
	var sut: FeedInteractor!

	override func tearDown() {
		sut = nil
	}

	func test_loadFirstFragment_shouldSaveLoadingStateAndFirstFragment () async throws {
		// Given
		let persistentMock = Mock.PhotoDetailsPersistentDataProvider(stubValue: .stubBohr)
		let taskFactory = TestTaskFactory()
		sut = .init(
			feedDataProvider: Mock.FeedDataProvider(stubValue: .stubFirstPage),
			photoDetailsPersistentDataProvider: persistentMock,
			taskFactory: taskFactory
		)

		var states = [Loadable<PhotosFragmentEntity>]()

		// When
		let с = sut.currentFragment.sink { states.append($0) }

		// Then
		XCTAssertEqual(states.map(\.value), [nil])

		// When
		await sut.loadNextFragment()

		// Then
		await taskFactory.waitAll()
		XCTAssertEqual(states.map(\.value), [nil, nil, .stubFirstPage])
		XCTAssertEqual(persistentMock.paramPhotoEntities, [PhotosFragmentEntity.stubFirstPage.photos])
	}

	func test_loadNextFragmentWhileLoading_shouldIgnore () async throws {
		// Given
		let persistentMock = Mock.PhotoDetailsPersistentDataProvider(stubValue: .stubBohr)
		let taskFactory = TestTaskFactory()
		sut = .init(
			feedDataProvider: Mock.FeedDataProvider(stubValue: .stubFirstPage),
			photoDetailsPersistentDataProvider: persistentMock,
			taskFactory: taskFactory
		)

		var states = [Loadable<PhotosFragmentEntity>]()

		// When
		let с = sut.currentFragment.sink { states.append($0) }

		// Then
		XCTAssertEqual(states.map(\.value), [nil])

		// When
		sut.currentFragment.send(.loading(task: nil, value: nil))

		// Then
		XCTAssertEqual(states.map(\.value), [nil, nil])

		// When
		await sut.loadNextFragment()

		// Then
		await taskFactory.waitAll()
		XCTAssertEqual(states.map(\.value), [nil, nil])

		// When
		await sut.loadNextFragment()
		await sut.loadNextFragment()

		// Then
		await taskFactory.waitAll()
		XCTAssertEqual(states.map(\.value), [nil, nil])
		XCTAssertEqual(persistentMock.paramPhotoEntities, [])
	}

	func test_loadNextFragmentAfterLoadingFirst_shouldSaveBoth () async {
		// Given
		let persistentMock = Mock.PhotoDetailsPersistentDataProvider(stubValue: .stubBohr)
		let taskFactory = TestTaskFactory()
		sut = .init(
			feedDataProvider: Mock.FeedDataProvider(stubValue: .stubSecondPage),
			photoDetailsPersistentDataProvider: persistentMock,
			taskFactory: taskFactory
		)

		var states = [Loadable<PhotosFragmentEntity>]()

		// When
		let c = sut.currentFragment.sink { states.append($0) }

		// Then
		XCTAssertEqual(states.map(\.value), [nil])

		// When
		sut.currentFragment.send(.successful(.stubFirstPage))

		// Then
		XCTAssertEqual(states.map(\.value), [nil, .stubFirstPage])

		// When
		await sut.loadNextFragment()

		// Then
		await taskFactory.waitAll()
		XCTAssertEqual(states.map(\.value), [nil, .stubFirstPage, nil, .stubSecondPage])
		XCTAssertEqual(persistentMock.paramPhotoEntities, [PhotosFragmentEntity.stubSecondPage.photos])
	}

	func test_failureWhileLoading_shouldSaveLoadingStateAndError () async {
		// Given
		let persistentMock = Mock.PhotoDetailsPersistentDataProvider(stubValue: .stubBohr)
		let taskFactory = TestTaskFactory()
		sut = .init(
			feedDataProvider: Mock.Throwing.FeedDataProvider(),
			photoDetailsPersistentDataProvider: persistentMock,
			taskFactory: taskFactory
		)

		var states = [Loadable<PhotosFragmentEntity>]()

		// When
		let c = sut.currentFragment.sink { states.append($0) }

		// Then
		XCTAssertEqual(states.map(\.value), [nil])

		// When
		await sut.loadNextFragment()

		// Then
		await taskFactory.waitAll()
		XCTAssertEqual(states.map(\.isFailed), [false, false, true])
		XCTAssertEqual(persistentMock.paramPhotoEntities, [])
	}

	func test_reload_shouldSaveFirstPage () async {
		// Given
		let persistentMock = Mock.PhotoDetailsPersistentDataProvider(stubValue: .stubBohr)
		let taskFactory = TestTaskFactory()
		sut = .init(
			feedDataProvider: Mock.FeedDataProvider(stubValue: .stubFirstPage),
			photoDetailsPersistentDataProvider: persistentMock,
			taskFactory: taskFactory
		)

		var states = [Loadable<PhotosFragmentEntity>]()

		// When
		let c = sut.currentFragment.sink { states.append($0) }

		// Then
		XCTAssertEqual(states.map(\.value), [nil])

		// When
		sut.currentFragment.send(.successful(.stubFirstPage))
		sut.currentFragment.send(.successful(.stubSecondPage))

		// Then
		XCTAssertEqual(states.map(\.value), [nil, .stubFirstPage, .stubSecondPage])

		// When
		await sut.reload()

		// Then
		await taskFactory.waitAll()
		XCTAssertEqual(states.map(\.value), [nil, .stubFirstPage, .stubSecondPage, nil, .stubFirstPage])
		XCTAssertEqual(persistentMock.paramPhotoEntities, [PhotosFragmentEntity.stubFirstPage.photos])
	}
}
