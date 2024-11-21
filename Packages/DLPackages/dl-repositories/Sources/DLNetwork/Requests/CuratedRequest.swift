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

	public var path: String { "" }
	public var body: Data? { nil }

	public var query: Query {
		[
			"page": page.description,
			"per_page": perPage.description
		]
	}

	public init (page: Int, perPage: Int) {
		self.page = page
		self.perPage = perPage
	}

	public func configurationUpdate (_ configuration: URLRequestConfiguration) -> URLRequestConfiguration {
		configuration
			.setScheme("https")
			.setAddress("api.pexels.com")
			.setBaseSubpath("v1/curated")
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

extension CuratedRequest.ResponseModel {
	public struct Photo: Decodable {
		public let id: Int
		public let photographer: String
		public let src: Source

		public init (
			id: Int,
			photographer: String,
			src: Source
		) {
			self.id = id
			self.photographer = photographer
			self.src = src
		}
	}
}

extension CuratedRequest.ResponseModel.Photo {
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
