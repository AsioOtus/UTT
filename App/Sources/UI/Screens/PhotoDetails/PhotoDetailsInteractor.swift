//
//  PhotoDetailsInteractor.swift
//  il-screen-photo-details
//
//  Created by Anton on 21/11/2024.
//

import Foundation
import Multitool

protocol PPhotoDetailsInteractor: ObservableObject {
	var photoDetails: Loadable<PhotoEntity> { get }
	var useLowQualityUrl: Bool { get }

	func loadPhotoDetails ()
	func downgradePhotoUrl ()
}

class PhotoDetailsInteractor: PPhotoDetailsInteractor {
	let photoDetailsFetchingUseCase: PPhotoDetailsFetchingUseCase

	let photoId: Int
	@Published var photoDetails: Loadable<PhotoEntity> = .initial
	@Published var useLowQualityUrl: Bool = false

	init (photoId: Int, photoDetailsFetchingUseCase: PPhotoDetailsFetchingUseCase) {
		self.photoId = photoId
		self.photoDetailsFetchingUseCase = photoDetailsFetchingUseCase
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
