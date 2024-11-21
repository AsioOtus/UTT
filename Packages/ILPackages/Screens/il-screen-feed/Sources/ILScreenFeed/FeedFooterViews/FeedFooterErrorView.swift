//
//  FeedFooterErrorView.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import UIKit
import UIKitExtensions

final class FeedFooterErrorView: UICollectionReusableView, XibInstantiatable {
	static var reuseIdentifier: String { Self.self.description() }

	var onAction: (() -> Void)?

	@IBOutlet private var messageLabel: UILabel!
	@IBOutlet private var actionButton: UIButton!

	override func awakeFromNib () {
		super.awakeFromNib()

		layer.cornerRadius = 20
		messageLabel.text = "Something went wrong"
		actionButton.setTitle("Refresh", for: .normal)
	}

	@IBAction func action () {
		onAction?()
	}
}
