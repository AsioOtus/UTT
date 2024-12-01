//
//  PhotoImageView.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import UIKit

final class PhotoImageView: UIImageView {
	private var aspectRatioConstraint: NSLayoutConstraint?

	override init (frame: CGRect) {
		super.init(frame: frame)

		setupImageView()
	}

	required init? (coder: NSCoder) {
		super.init(coder: coder)

		setupImageView()
	}

	private func setupImageView () {
		contentMode = .scaleAspectFit
	}

	override var image: UIImage? {
		didSet {
			updateAspectRatio()
		}
	}

	private func updateAspectRatio () {
		aspectRatioConstraint?.isActive = false

		guard let image = image else { return }

		let aspectRatio = image.size.width / image.size.height
		aspectRatioConstraint = widthAnchor.constraint(equalTo: heightAnchor, multiplier: aspectRatio)
		aspectRatioConstraint?.isActive = true
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		updateAspectRatio()
	}
}
