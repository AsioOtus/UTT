//
//  CuratedRequest.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Foundation
import NetworkUtil

public struct CuratedRequest: Request {
	public let page: Int
	public let perPage: Int

	public var configuration: RequestConfiguration {
		.init()
			.setScheme("https")
			.setHost("api.pexels.com")
			.setPath("v1/curated")
			.addQueryItem(.init(name: "page", value: page.description))
			.addQueryItem(.init(name: "per_page", value: perPage.description))
	}

	public init (page: Int, perPage: Int) {
		self.page = page
		self.perPage = perPage
	}
}

extension CuratedRequest {
	public struct ResponseModel: Decodable {
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
}
