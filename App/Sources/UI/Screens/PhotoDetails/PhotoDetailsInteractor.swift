//
//  PhotoDetailsInteractor.swift
//  il-screen-photo-details
//
//  Created by Anton on 21/11/2024.
//

import Foundation

protocol PPhotoDetailsInteractor: ObservableObject {
	var photoDetails: Loadable<PhotoEntity> { get }
	var useLowQualityUrl: Bool { get }

	func loadPhotoDetails ()
	func downgradePhotoUrl ()
}

class PhotoDetailsInteractor: PPhotoDetailsInteractor {
	let photoDetailsDataProvider: PPhotoDetailsDataProvider
	let photoDetailsPersistentDataProvider: PPhotoDetailsPersistentDataProvider

	let photoId: Int
	@Published var photoDetails: Loadable<PhotoEntity> = .initial
	@Published var useLowQualityUrl: Bool = false

	init (
		photoId: Int,
		photoDetailsDataProvider: PPhotoDetailsDataProvider,
		photoDetailsPersistentDataProvider: PPhotoDetailsPersistentDataProvider
	) {
		self.photoId = photoId
		self.photoDetailsDataProvider = photoDetailsDataProvider
		self.photoDetailsPersistentDataProvider = photoDetailsPersistentDataProvider
	}

	func loadPhotoDetails () {
		photoDetails.cancel()
		let task = Task<Void, Error> {
			photoDetails = await Loadable<PhotoEntity> {
				do {
					let photo = try await photoDetailsDataProvider.loadPhoto(id: photoId)
					try? photoDetailsPersistentDataProvider.savePhoto(photo)
					return photo
				} catch let error as OfflineError {
					if let photoEntity = try? photoDetailsPersistentDataProvider.loadPhoto(id: photoId) {
						return photoEntity
					} else {
						throw error
					}
				}
			}
		}

		photoDetails = .loading(task: task, value: photoDetails.value)
	}

	func downgradePhotoUrl () {
		useLowQualityUrl = true
	}
}
