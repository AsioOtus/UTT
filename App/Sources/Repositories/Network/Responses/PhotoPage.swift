//
//  CuratedResponse.swift
//  App
//
//  Created by Anton on 01/12/2024.
//

import Foundation

public struct PhotoPage: Decodable {
	public let page: Int
	public let perPage: Int
	public let photos: [Photo]
	public let nextPage: URL?
	public let prevPage: URL?

	public init (
		page: Int,
		perPage: Int,
		photos: [Photo],
		nextPage: URL?,
		prevPage: URL?
	) {
		self.page = page
		self.perPage = perPage
		self.photos = photos
		self.nextPage = nextPage
		self.prevPage = prevPage
	}

	public enum CodingKeys: String, CodingKey {
		case page
		case perPage = "per_page"
		case photos
		case nextPage = "next_page"
		case prevPage = "prev_page"
	}
}
