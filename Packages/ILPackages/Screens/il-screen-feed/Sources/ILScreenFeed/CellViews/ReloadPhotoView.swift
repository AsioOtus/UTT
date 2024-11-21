//
//  ReloadPhotoView.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import UIKit
import UIKitExtensions

final class ReloadPhotoView: UIView, XibInstantiatable {
	@IBOutlet private var messageLabel: UILabel!

	var onReload: (() -> Void)?

	override func awakeFromNib () {
		super.awakeFromNib()

		layer.cornerRadius = 15

		messageLabel.text = "Failed to load image"
	}

	@IBAction func onReloadButtonTap() {
		onReload?()
	}
}
