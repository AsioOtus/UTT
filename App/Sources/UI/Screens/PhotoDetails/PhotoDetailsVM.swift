//
//  PhotoDetailsVM.swift
//  il-screen-photo-details
//
//  Created by Anton on 21/11/2024.
//

import Combine
import Foundation

@dynamicMemberLookup
class PhotoDetailsVM <Interactor: PPhotoDetailsInteractor>: ObservableObject {
	private var subscriptions = Set<AnyCancellable>()

	@Published var interactor: Interactor

	var photoModel: Loadable<PhotoModel> {
		interactor.photoDetails.mapValue {
			PhotoModel(
				id: $0.id,
				photographer: $0.photographerName,
				description: $0.description,
				size: $0.width.description + "x" + $0.height.description,
				originalUrl: $0.originalUrl,
				largeUrl: $0.largeUrl
			)
		}
	}

	init (interactor: Interactor) {
		self.interactor = interactor

		interactor.objectWillChange
			.receive(on: DispatchQueue.main)
			.sink { [weak self] _ in self?.objectWillChange.send() }
			.store(in: &subscriptions)
	}

	func onAppear () {
		interactor.loadPhotoDetails()
	}

	func reload () {
		interactor.loadPhotoDetails()
	}

	func onImageLoadingFailed () {
		interactor.downgradePhotoUrl()
	}

	subscript <T> (dynamicMember keyPath: KeyPath<Interactor, T>) -> T {
		interactor[keyPath: keyPath]
	}
}
