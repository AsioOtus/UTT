//
//  PhotoDetailsInteractor.swift
//  il-screen-photo-details
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import DLUseCases
import Foundation
import Multitool

protocol PPhotoDetailsInteractor: ObservableObject {
	var photo: Loadable<Data> { get }

	func loadPhoto ()
}

class PhotoDetailsInteractor: PPhotoDetailsInteractor {
	@Dependency(\.photoDetailsFetchingUseCase) var photoDetailsFetchingUseCase

	let url: URL
	@Published var photo: Loadable<Data> = .initial

	init (url: URL) {
		self.url = url
	}

	func loadPhoto () {
		photo.setLoading {
			Task {
				photo = await Loadable<Data>.result {
					try await photoDetailsFetchingUseCase.loadPhoto(url: url)
				}
			}
		}
	}
}
