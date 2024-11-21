//
//  File.swift
//  dl-entities
//
//  Created by Anton on 21/11/2024.
//

import Foundation

public struct PhotoEntity: Equatable {
	public let id: Int
	public let photographerName: String
	public let originalUrl: URL
	public let largeUrl: URL

	public init (
		id: Int,
		photographerName: String,
		originalUrl: URL,
		largeUrl: URL
	) {
		self.id = id
		self.photographerName = photographerName
		self.originalUrl = originalUrl
		self.largeUrl = largeUrl
	}
}

