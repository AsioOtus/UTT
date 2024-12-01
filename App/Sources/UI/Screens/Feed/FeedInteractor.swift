//
//  FeedInteractor.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import Combine
import Foundation
import Multitool

protocol PFeedInteractor {
	var photosPerPage: Int { get }

	var currentFragment: CurrentValueSubject<Loadable<PhotosFragmentEntity>, Never> { get }

	func loadNextFragment () async
	func reloadLastFragment () async
	func reload () async 
}

actor FeedInteractor: PFeedInteractor {
	let feedDataProvider: PFeedDataProvider
	let photoDetailsPersistentDataProvider: PPhotoDetailsPersistentDataProvider

	init (
		feedDataProvider: PFeedDataProvider,
		photoDetailsPersistentDataProvider: PPhotoDetailsPersistentDataProvider
	) {
		self.feedDataProvider = feedDataProvider
		self.photoDetailsPersistentDataProvider = photoDetailsPersistentDataProvider
	}

	let photosPerPage = 20

	private var lastLoadedFragment: PhotosFragmentEntity?
	nonisolated let currentFragment: CurrentValueSubject<Loadable<PhotosFragmentEntity>, Never> = .init(.initial)
}

extension FeedInteractor {
	func loadNextFragment () async {
			switch currentFragment.value {
			case .initial:
				loadFirstFragment()

			case .loading:
				return

			case .successful(let lastFragment):
				loadNextFragment(lastFragment: lastFragment)

			case .failed:
				return
			}
	}

	func reloadLastFragment () async {
		if let lastLoadedFragment {
			loadNextFragment(lastFragment: lastLoadedFragment)
		} else {
			loadFirstFragment()
		}
	}

	func reload () async {
		lastLoadedFragment = nil
		loadFirstFragment()
	}
}

private extension FeedInteractor {
	func loadFirstFragment () {
		loadPhotoFragment {
			let photoFragment = try await self.feedDataProvider.load(photosPerPage: self.photosPerPage)
			try? self.photoDetailsPersistentDataProvider.savePhotos(photoFragment.photos)
			return photoFragment
		}
	}

	func loadNextFragment (lastFragment: PhotosFragmentEntity) {
		guard let nextFragmentUrl = lastFragment.nextFragmentUrl else { return }

		loadPhotoFragment {
			let photoFragment = try await self.feedDataProvider.load(nextFragmentUrl: nextFragmentUrl)
			try? self.photoDetailsPersistentDataProvider.savePhotos(photoFragment.photos)
			return photoFragment
		}
	}

	func loadPhotoFragment (_ loadingAction: @escaping () async throws -> PhotosFragmentEntity) {
		currentFragment.value.cancel()

		let loadingTask = Task<Void, Error> {
			let result = await Loadable<PhotosFragmentEntity> {
				let photoFragment = try await loadingAction()
				lastLoadedFragment = photoFragment
				return photoFragment
			}

			currentFragment.send(result)
		}

		currentFragment.send(.loading(task: loadingTask))
	}
}
