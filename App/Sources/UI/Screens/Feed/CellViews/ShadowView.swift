//
//  ShadowView.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import UIKit

final class ShadowView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupShadow()

		backgroundColor = .clear
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupShadow()

		backgroundColor = .clear
	}

	private func setupShadow () {
		layer.shadowColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1).cgColor
		layer.shadowOpacity = 1
		layer.shadowOffset = CGSize(width: 0, height: 0.5)
		layer.shadowRadius = 1
		layer.masksToBounds = false
	}

	private func updateShadowPath () {
		layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 15).cgPath
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		
		updateShadowPath()
	}
}
