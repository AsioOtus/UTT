//
//  Photo.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import DLEntities
import Foundation

public struct Photo: Decodable {
	public let id: Int
	public let photographer: String
	public let alt: String
	public let src: Source
	public let width: Int
	public let height: Int

	public init (
		id: Int,
		photographer: String,
		alt: String,
		src: Source,
		width: Int,
		height: Int
	) {
		self.id = id
		self.photographer = photographer
		self.alt = alt
		self.src = src
		self.width = width
		self.height = height
	}
}

extension Photo {
	public struct Source: Decodable {
		public let original: URL
		public let large: URL

		public init (
			original: URL,
			large: URL
		) {
			self.original = original
			self.large = large
		}
	}
}

public extension Photo {
	var entity: PhotoEntity {
		.init(
			id: id,
			photographerName: photographer,
			description: alt,
			width: width,
			height: height,
			originalUrl: src.original,
			largeUrl: src.large
		)
	}
}
