//
//  PhototModel.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import Foundation

struct PhotoModel: Hashable {
	public let id: Int
	public let uiId: UUID // API can return duplicated items
	public let photographerName: String
	public let largeUrl: URL
	public let originalUrl: URL

	public init (
		id: Int,
		uiId: UUID,
		photographerName: String,
		largeUrl: URL,
		originalUrl: URL
	) {
		self.id = id
		self.uiId = uiId
		self.photographerName = photographerName
		self.largeUrl = largeUrl
		self.originalUrl = originalUrl
	}

	func hash (into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(uiId)
	}
}
