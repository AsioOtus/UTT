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

	init (interactor: Interactor) {
		self.interactor = interactor

		interactor.objectWillChange
			.receive(on: DispatchQueue.main)
			.sink { [weak self] _ in self?.objectWillChange.send() }
			.store(in: &subscriptions)
	}

	func onAppear () {
		interactor.loadPhoto()
	}

	func reload () {
		interactor.loadPhoto()
	}

	subscript <T> (dynamicMember keyPath: KeyPath<Interactor, T>) -> T {
		interactor[keyPath: keyPath]
	}
}
