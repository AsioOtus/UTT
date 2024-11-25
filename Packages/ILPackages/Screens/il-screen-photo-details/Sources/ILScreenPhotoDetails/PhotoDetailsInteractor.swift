//
//  PhotoDetailsInteractor.swift
//  il-screen-photo-details
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import DLEntities
import DLUseCases
import Foundation
import Multitool

protocol PPhotoDetailsInteractor: ObservableObject {
	var photoDetails: Loadable<PhotoEntity> { get }
	var useLowQualityUrl: Bool { get }

	func loadPhotoDetails ()
	func downgradePhotoUrl ()
}

class PhotoDetailsInteractor: PPhotoDetailsInteractor {
	@Dependency(\.photoDetailsFetchingUseCase) var photoDetailsFetchingUseCase

	let photoId: Int
	@Published var photoDetails: Loadable<PhotoEntity> = .initial
	@Published var useLowQualityUrl: Bool = false

	init (photoId: Int) {
		self.photoId = photoId
	}

	func loadPhotoDetails () {
		photoDetails.setLoading {
			Task {
				photoDetails = await Loadable<PhotoEntity>.result {
					try await photoDetailsFetchingUseCase.loadPhoto(id: photoId)
				}
			}
		}
	}

	func downgradePhotoUrl () {
		useLowQualityUrl = true
	}
}
