//
//  FeedCVC.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import Combine
import Kingfisher
import Multitool
import SwiftUI
import UIKit
import UIKitExtensions

public final class FeedCVC: UICollectionViewController, StoryboardInstantiatable {
	private var subscriptions = Set<AnyCancellable>()

	let vm = FeedVM(interactor: FeedInteractor())
}

public extension FeedCVC {
	override func viewDidLoad() {
		super.viewDidLoad()

		configureCollectionView()

		vm.currentFragmentRequestState
			.receive(on: DispatchQueue.main)
			.sink { [weak self] in
				guard
					$0.isLoading,
					let refreshControl = self?.collectionView.refreshControl,
					refreshControl.isRefreshing
				else { return }

				refreshControl.endRefreshing()
			}
			.store(in: &subscriptions)

		vm.onViewDidLoad()
	}

	override func collectionView (_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		vm.onCellTap(indexPath)
	}
}

private extension FeedCVC {
	func configureCollectionView () {
		collectionView.showsVerticalScrollIndicator = false
		collectionView.collectionViewLayout = createLayout()
		collectionView.prefetchDataSource = vm

		collectionView.register(
			FeedFooterLoadingView.xib(bundle: .module),
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
			withReuseIdentifier: FeedFooterLoadingView.reuseIdentifier
		)

		collectionView.register(
			FeedFooterEmptyView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
			withReuseIdentifier: FeedFooterEmptyView.reuseIdentifier
		)

		collectionView.register(
			FeedFooterErrorView.xib(bundle: .module),
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
			withReuseIdentifier: FeedFooterErrorView.reuseIdentifier
		)

		collectionView.register(
			FeedFooterInfoView.xib(bundle: .module),
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
			withReuseIdentifier: FeedFooterInfoView.reuseIdentifier
		)

		let cellRegistration = createCellRegistration()
		vm.dataSource = createDataSource(cellRegistration: cellRegistration)
		vm.dataSource?.supplementaryViewProvider = createSupplementaryDataSource()

		configureRefreshControl()
	}

	func configureRefreshControl () {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
		collectionView.refreshControl = refreshControl
	}

	func createLayout () -> UICollectionViewLayout {
		let item = NSCollectionLayoutItem(
			layoutSize: .init(
				widthDimension: .fractionalWidth(1),
				heightDimension: .absolute(300)
			)
		)
		item.contentInsets = .init(top: 0, leading: 0, bottom: 24, trailing: 0)

		let group = NSCollectionLayoutGroup.vertical(
			layoutSize: .init(
				widthDimension: .fractionalWidth(1),
				heightDimension: .absolute(300)
			),
			subitems: [item]
		)

		let section = NSCollectionLayoutSection(group: group)
		let footer = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: .init(
				widthDimension: .fractionalWidth(1.0),
				heightDimension: .estimated(1)
			),
			elementKind: UICollectionView.elementKindSectionFooter,
			alignment: .bottom
		)
		section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
		section.boundarySupplementaryItems = [footer]

		let layout = UICollectionViewCompositionalLayout(section: section)

		return layout
	}

	func createCellRegistration () -> UICollectionView.CellRegistration<PhotoCell, PhotoModel> {
		.init(cellNib: PhotoCell.xib(bundle: .module)) { cell, indexPath, item in
			cell.photo = item
		}
	}

	func createDataSource (cellRegistration: UICollectionView.CellRegistration<PhotoCell, PhotoModel>) -> FeedDataSource {
		let dataSource = FeedDataSource(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
			collectionView.dequeueConfiguredReusableCell(
				using: cellRegistration,
				for: indexPath,
				item: item
			)
		}

		var initialSnapshot = dataSource.snapshot()
		initialSnapshot.appendSections([0])
		dataSource.apply(initialSnapshot, animatingDifferences: false)

		return dataSource
	}

	func createSupplementaryDataSource () -> FeedDataSource.SupplementaryViewProvider {
		{ [weak self] collectionView, kind, indexPath -> UICollectionReusableView in
			guard kind == UICollectionView.elementKindSectionFooter else { return .init() }
			guard let requestState = self?.vm.currentFragmentRequestState.value else { return FeedFooterEmptyView() }

			if let successfulValue = requestState.successfulValue, successfulValue.nextFragmentUrl == nil {
				let infoView = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: FeedFooterInfoView.reuseIdentifier,
					for: indexPath
				)

				(infoView as? FeedFooterInfoView)?.message = "Congratulations, you have seen everything!"

				return infoView
			}

			switch requestState {
			case .loading:
				return collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: FeedFooterLoadingView.reuseIdentifier,
					for: indexPath
				)

			case .successful, .initial:
				return collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: FeedFooterEmptyView.reuseIdentifier,
					for: indexPath
				)

			case .failed:
				let errorView = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: FeedFooterErrorView.reuseIdentifier,
					for: indexPath
				)

				(errorView as? FeedFooterErrorView)?.onAction = { [weak self] in
					self?.vm.onRefreshButtonTap()
				}

				return errorView
			}
		}
	}

	@objc func onRefresh () {
		vm.onRefresh()
	}
}

