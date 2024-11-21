//
//  FeedFooterInfoView.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import UIKit
import UIKitExtensions

final class FeedFooterInfoView: UICollectionReusableView, XibInstantiatable {
	static var reuseIdentifier: String { Self.self.description() }

	var message: String = "" {
		didSet {
			messageLabel.text = message
		}
	}

	@IBOutlet private var messageLabel: UILabel!
}
