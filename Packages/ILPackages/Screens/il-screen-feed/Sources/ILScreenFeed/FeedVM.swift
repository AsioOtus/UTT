//
//  FeedVM.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import Combine
import DLEntities
import Multitool
import SwiftUI
import UIKit

final class FeedVM: NSObject {
	private var subscriptions = Set<AnyCancellable>()

	let interactor: PFeedInteractor
	var dataSource: FeedDataSource?
	var coordinator: FeedCoordinator?

	var currentFragmentRequestState: CurrentValueSubject<Loadable<PhotosFragmentEntity>, Never> {
		interactor.currentFragment
	}

	init (interactor: PFeedInteractor) {
		self.interactor = interactor

		super.init()

		configureSubscriptions()
	}
}

extension FeedVM {
	func onViewDidLoad () {
		loadNextFragment()
	}

	func onRefreshButtonTap () {
		reloadCurrentFragment()
	}

	func onRefresh () {
		reload()
	}

	func onCellTap (_ indexPath: IndexPath) {
		guard let selectedPhoto = dataSource?.snapshot().itemIdentifiers[indexPath.row] else { return }
		coordinator?.navigate(selectedPhoto.id)
	}
}

extension FeedVM: UICollectionViewDataSourcePrefetching {
	func collectionView (_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		guard let itemsCount = dataSource?.snapshot().numberOfItems else { return }
		guard let indexPath = indexPaths.last else { return }
		guard itemsCount - indexPath.row < interactor.photosPerPage else { return }

		loadNextFragment()
	}
}

private extension FeedVM {
	func configureSubscriptions () {
		interactor.currentFragment
			.sink { [weak self] fragment in
				guard let self else { return }
				guard var snapshot = dataSource?.snapshot() else { return }

				defer {
					Task { @MainActor [snapshot] in
						self.dataSource?.apply(snapshot, animatingDifferences: true)
					}
				}

				guard let photos = fragment.successfulValue?
					.photos
					.map({
						PhotoModel(
							id: $0.id,
							uiId: .init(),
							photographerName: $0.photographerName + " " + $0.id.description,
							largeUrl: $0.largeUrl,
							originalUrl: $0.originalUrl
						)
					})
				else { return }

				if snapshot.sectionIdentifiers.isEmpty {
					snapshot.appendSections([0])
				} else {
					snapshot.reloadSections([0])
				}

				snapshot.appendItems(photos)
			}
			.store(in: &subscriptions)
	}
}

private extension FeedVM {
	func loadNextFragment () {
		Task {
			await interactor.loadNextFragment()
		}
	}

	func reloadCurrentFragment () {
		Task {
			await interactor.reloadLastFragment()
		}
	}

	func reload () {
		Task { @MainActor in
			guard var snapshot = dataSource?.snapshot() else { return }
			snapshot.deleteAllItems()
			await dataSource?.apply(snapshot, animatingDifferences: true)
			await interactor.reload()
		}
	}
}
