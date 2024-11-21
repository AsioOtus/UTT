//
//  PhotoCell.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import Foundation
import Kingfisher
import UIKit
import UIKitExtensions

final class PhotoCell: UICollectionViewCell, XibInstantiatable {
	var photo: PhotoModel? {
		didSet {
			update()
		}
	}

	let placeholder = PlaceholderView()
	let reloadPhotoView = ReloadPhotoView.instantiate(bundle: .module)

	private var photoLoadingTask: DownloadTask?

	@IBOutlet private var labelBackgroundView: UIView!
	@IBOutlet private var photographerNameLabel: UILabel!
	@IBOutlet private var imageView: PhotoImageView!
	@IBOutlet private var shadowView: ShadowView!

	override init (frame: CGRect) {
		super.init(frame: frame)

		reloadPhotoView.onReload =  { [weak self] in self?.reloadImage() }
	}

	required init? (coder: NSCoder) {
		super.init(coder: coder)

		reloadPhotoView.onReload =  { [weak self] in self?.reloadImage() }
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		layer.masksToBounds = false
		contentView.layer.masksToBounds = false
		imageView.clipsToBounds = false
		imageView.layer.masksToBounds = false

		labelBackgroundView.layer.cornerRadius = 8
		labelBackgroundView.layer.masksToBounds = true
		photographerNameLabel.textColor = .secondaryLabel
	}

	func update () {
		guard let photo else {
			imageView.image = nil
			return
		}

		photographerNameLabel.text = photo.photographerName

		imageView.kf.setImage(
			with: photo.largeUrl,
			placeholder: placeholder,
			options: [
				.cacheSerializer(FormatIndicatedCacheSerializer.png),
				.processor(RoundCornerImageProcessor(cornerRadius: 38)),
				.downloadPriority(URLSessionTask.lowPriority),
			]
		) { [weak self] result in
			switch result {
			case .success:
				self?.hideReloadView()
			case .failure:
				self?.showReloadView()
			}
		}
	}

	private func reloadImage () {
		guard let photo else { return }

		hideReloadView()

		photoLoadingTask = imageView.kf.setImage(
			with: photo.largeUrl,
			placeholder: placeholder,
			options: [
				.cacheSerializer(FormatIndicatedCacheSerializer.png),
				.processor(RoundCornerImageProcessor(cornerRadius: 38)),
				.downloadPriority(URLSessionTask.lowPriority),
				.forceRefresh,
			]
		) { [weak self] result in
			switch result {
			case .success:
				self?.hideReloadView()
			case .failure:
				self?.showReloadView()
			}
		}
	}

	func showReloadView () {
		imageView.isHidden = true
		shadowView.addSubview(reloadPhotoView)
		reloadPhotoView.pinBounds(to: shadowView)
	}

	func hideReloadView () {
		imageView.isHidden = false
		reloadPhotoView.removeFromSuperview()
	}

	override func prepareForReuse () {
		super.prepareForReuse()

		photoLoadingTask?.cancel()
		photoLoadingTask = nil
		photo = nil
	}
}
