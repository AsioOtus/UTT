//
//  FeedViewControllerRepresentable.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import SwiftUI

struct FeedViewControllerRepresentable: UIViewControllerRepresentable {
	var presentedPhotoId: Binding<Int?>

	init (presentedPhotoId: Binding<Int?>) {
		self.presentedPhotoId = presentedPhotoId
	}

	func makeUIViewController (context: Context) -> FeedCVC {
		let feedVC = FeedCVC.instantiateInitial(from: .init(name: FeedCVC.storyboardName, bundle: .module))
		feedVC.vm.coordinator = context.coordinator
		return feedVC
	}

	func updateUIViewController(_ uiViewController: FeedCVC, context: Context) { }

	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	class Coordinator: NSObject, FeedCoordinator {
		var view: FeedViewControllerRepresentable

		init (_ view: FeedViewControllerRepresentable) {
			self.view = view
		}

		func navigate (_ id: Int?) {
			view.presentedPhotoId.wrappedValue = id
		}
	}
}

protocol FeedCoordinator {
	func navigate (_ photoId: Int?)
}
