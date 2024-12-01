//
//  PlaceholderView.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import Kingfisher
import UIKit

final class PlaceholderView: UIView, Placeholder {
	let reloadPhotoView = ReloadPhotoView.instantiate()

	override var intrinsicContentSize: CGSize {
		.init(width: 300, height: 500)
	}

	private let gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer()

		let color = UIColor.systemGray
		let sideColor = color.withAlphaComponent(0.5).cgColor
		let centerColor = color.withAlphaComponent(0.8).cgColor
		gradientLayer.colors = [sideColor, centerColor, sideColor]

		gradientLayer.cornerRadius = 15
		gradientLayer.startPoint = CGPoint(x: 1, y: 0)
		gradientLayer.endPoint = CGPoint(x: 0, y: 1)
		gradientLayer.locations = [0.0, 0.5, 1.0]
		gradientLayer.zPosition = CGFloat(Float.greatestFiniteMagnitude)

		return gradientLayer
	}()

	private let gradientAnimation: CABasicAnimation = {
		let animation = CABasicAnimation(keyPath: "locations")
		animation.fromValue = [-1.0, -0.5, 0.0]
		animation.toValue = [1.0, 1.5, 2.0]
		animation.repeatCount = .infinity
		animation.duration = 1.5
		animation.isRemovedOnCompletion = false
		return animation
	}()

	override init (frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = .systemBackground
		layer.cornerRadius = 15
		layer.addSublayer(gradientLayer)
	}

	required init? (coder: NSCoder) {
		super.init(coder: coder)
	}

	override func layoutSubviews () {
		super.layoutSubviews()

		gradientLayer.frame = self.bounds
	}

	override func willMove (toSuperview newSuperview: UIView?) {
		super.willMove(toSuperview: newSuperview)

		if newSuperview != nil {
			gradientLayer.add(gradientAnimation, forKey: gradientAnimation.keyPath)
		} else {
			gradientLayer.removeAllAnimations()
		}
	}

	func showReloadView () {
		self.addSubview(reloadPhotoView)
		reloadPhotoView.pinBounds(to: self)
	}

	func hideReloadView () {
		reloadPhotoView.removeFromSuperview()
	}
}
