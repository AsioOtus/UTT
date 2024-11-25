//
//  PhotoEntity.swift
//  dl-entities
//
//  Created by Anton on 21/11/2024.
//

import Foundation

public struct PhotoEntity: Equatable {
	public let id: Int
	public let photographerName: String
	public let description: String
	public let width: Int
	public let height: Int
	public let originalUrl: URL
	public let largeUrl: URL

	public init (
		id: Int,
		photographerName: String,
		description: String,
		width: Int,
		height: Int,
		originalUrl: URL,
		largeUrl: URL
	) {
		self.id = id
		self.photographerName = photographerName
		self.description = description
		self.width = width
		self.height = height
		self.originalUrl = originalUrl
		self.largeUrl = largeUrl
	}
}
