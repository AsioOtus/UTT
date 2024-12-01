//
//  PhotoModel.swift
//  il-screen-photo-details
//
//  Created by Anton on 21/11/2024.
//

import Foundation

struct PhotoModel {
	public let id: Int
	public let photographer: String
	public let description: String
	public let size: String
	public let originalUrl: URL
	public let largeUrl: URL

	public init (
		id: Int,
		photographer: String,
		description: String,
		size: String,
		originalUrl: URL,
		largeUrl: URL
	) {
		self.id = id
		self.photographer = photographer
		self.description = description
		self.size = size
		self.originalUrl = originalUrl
		self.largeUrl = largeUrl
	}
}

